__author__ = 'Didier.Baclin'

import bottle
import backend
import datetime
import hashlib
import random
from passlib.hash import pbkdf2_sha256
import cherrypy
import secret
from secret import NOF_HASH_ROUNDS, GLOBAL_COOKIE_SECRET, SMTP_PASSWORD, ENCRYPTION_PASSWORD, EMAIL_FROM
from smtplib import SMTP
from simplecrypt import encrypt, decrypt
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib

from backend import db
from bottle import *
from tinydb import *

import base64
import uuid



# get a UUID - URL safe, Base64
def get_a_uuid():
    r_uuid = base64.urlsafe_b64encode(uuid.uuid4().bytes)
    return r_uuid.replace('=', '')

@route('/')
def hello():
    return "This is a test!"

@route('/hello/<name>')
def index(name):
    return template('<b>Hello {{name}}</b>!', name=name)

@route('/js/<filename:re:.*\.js>')
def javascripts(filename):
    return static_file(filename, root='./static/js')

@route('/css/<filename:re:.*\.(css|styl|png)>')
def stylesheets(filename):
    return static_file(filename, root='./static/css')

@route('/img/<filename:re:.*\.(jpg|png|gif|ico)>')
def images(filename):
    return static_file(filename, root='./static/img')

@route('/fonts/<filename:re:.*\.(eot|ttf|woff|svg)>')
def fonts(filename):
    return static_file(filename, root='./static/fonts')

@route('/font-awesome-4.1.0/<filename:re:.*\.*>')
def fonts(filename):
    return static_file(filename, root='./static/font-awesome-4.1.0')

@route('/static/uploaded-content/<filename:re:.*\.*>')
def videos(filename):
    return static_file(filename, root='./static/uploaded-content')

@route('/file-upload', method='POST')
def file_upload():
    for k in request.files.keys():
        print k, request.files[k]

    upload = request.files.get('file')
    name, ext = os.path.splitext(upload.filename)

    # if ext not in ('.png','.jpg','.jpeg'):
    #    return 'File extension not allowed.'

    uuid = get_a_uuid()
    filenameForStorage = uuid + "." + upload.filename.rsplit(".", 1)[1]
    videoTable = db.table('videos')
    filename = os.path.join('./static/uploaded-content/',filenameForStorage)

    existing_cookie = request.get_cookie("sebifyme",secret=GLOBAL_COOKIE_SECRET)
    print "existing cookie", existing_cookie
    uid =  existing_cookie['uid']
    print "uid", uid

    videoTable.insert({'key':uuid,'values':              {'views':0,
                                                          'uploaded_by_uid':uid,
                                                          'uploaded_by_user':None,
                                                          'seen_by_users':[],
                                                          'ratings':[],
                                                          'location':filename,
                                                          'time':str(datetime.now())}})
    print filename
    upload.save(filename)

    return uuid

@route('/submit-email-password-initial', method="POST")
def submitEmailPassword():

    for k in request.forms.keys():
        print k, request.forms[k]

    username = request.forms.get('email')
    password = request.forms.get('password')

    password_hashed = base64.urlsafe_b64encode(pbkdf2_sha256.encrypt(password, rounds=NOF_HASH_ROUNDS, salt_size=16))

    username_encrypted = base64.urlsafe_b64encode(encrypt(ENCRYPTION_PASSWORD, username))

    usersTable = db.table('users')

    existingUser = usersTable.search(where('key') == username_encrypted)
    if existingUser:
        if pbkdf2_sha256.verify(existingUser['values']['password'],password_hashed):
            pass
        else:
            print "wrong login"
    else:
        usersTable.insert({'key':username_encrypted, 'values':{'password':password_hashed}})
        videosTable = db.table('videos')
        existing_cookie = request.get_cookie('sebifyme',secret=GLOBAL_COOKIE_SECRET)
        uid = existing_cookie['uid']
        elements = videosTable.search((where('values').has('uploaded_by_uid') == uid) & (where('values').has('uploaded_by_user') == None))
        for el in elements:
            currentValues = el['values']
            currentValues['uploaded_by_user'] = username_encrypted
            videosTable.update({'values':currentValues}, eids=[el.eid])

    website_content = template('video',video_name='joke.mp4')

    return website_content

@route('/vidz/<name>')
def show_videos(name='joke.mp4'):

    website_content = template('video',video_name=name)

    return website_content

@route('/randomvid',method='POST')
@route('/randomvid')
def show_videos():

    import json
    import urllib

    videos_history = request.forms.get('videos-history')
    for k in request.forms.keys():
        print k, request.forms[k]

    if videos_history == None:
        print "no history"
    else:
        print json_loads(urllib.unquote(videos_history))

    videosTable = db.table('videos')
    allVideos = map(lambda x: x['key'],  videosTable.all())
    alreadySeenVideos = []
    allVideos = list(set(allVideos) - set(alreadySeenVideos))
    if len(allVideos) > 0:
        random_video = random.sample(allVideos,1)[0]
        video_url = videosTable.get(where('key')==random_video)['values']['location']
        website_content = template('video',video_url=video_url)
        return website_content
    else:
        return template('index')

@route('/thanks',method='POST')
def thanks():
    return template('thanks')

def send_email(email_address, content):

    COMMASPACE = ', '

    # Create the container (outer) email message.
    msg = MIMEMultipart()
    msg['Subject'] = "Trying something different now"
    # me == the sender's email address
    # family = the list of all recipients' email addresses
    msg['From'] = EMAIL_FROM
    msg['To'] = COMMASPACE.join([email_address])
    html = content # "<html><head></head><body><p>Hi!<br>How are you?<br></p></body></html>"

    # Record the MIME types of both parts - text/plain and text/html.
    html_message = MIMEText(html, 'html')

    # Attach parts into message container.
    # According to RFC 2046, the last part of a multipart message, in this case
    # the HTML message, is best and preferred.
    msg.attach(html_message)

    # Send the email via our own SMTP server.
    s = smtplib.SMTP()
    s.connect('smtp.webfaction.com')
    from secret import SMTP_LOGIN
    s.login(SMTP_LOGIN,SMTP_PASSWORD)
    s.sendmail(msg['From'], msg['To'], msg.as_string())
    s.quit()

@route('/mainpage')
def mainpage():
    website_content = template('index') # static_file('index.html', root='./static')
    existing_cookie = request.get_cookie("sebifyme",secret=GLOBAL_COOKIE_SECRET)

    if existing_cookie:
        print "last visit", existing_cookie['last_visit'], "nof visits:" , existing_cookie['nof_visits']
        response.set_cookie("sebifyme", {"last_visit":datetime.now(), "uid": existing_cookie['uid'], "nof_visits": existing_cookie['nof_visits'] + 1}, secret=GLOBAL_COOKIE_SECRET, max_age=365*24*60*60*5)
    else:
        response.set_cookie("sebifyme", {"last_visit":datetime.now(), "uid": get_a_uuid(), "nof_visits": 1}, secret=GLOBAL_COOKIE_SECRET, max_age=365*24*60*60*5)

    return website_content

# run(host='localhost', port=8080, debug=False)
run(host='localhost', port=8080, server='cherrypy')
# run(host='localhost', port=12704, server='cherrypy')
# 12704