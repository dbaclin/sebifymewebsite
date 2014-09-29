__author__ = 'Didier.Baclin'

import bottle
import backend
import datetime
import hashlib
import random
import cherrypy
from secret import GLOBAL_SECRET, SALT_BEFORE, SALT_AFTER, SMTP_PASSWORD
from smtplib import SMTP

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

@route('/videos/<filename:re:.*\.*>')
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

    filenameForStorage = get_a_uuid() + "." + upload.filename.rsplit(".", 1)[1]
    videoTable = db.table('videos')
    filename = os.path.join('./static/uploaded-content/',filenameForStorage)
    existing_cookie = request.get_cookie("sebifyme",secret=GLOBAL_SECRET)
    print "existing cookie", existing_cookie
    uid =  existing_cookie['uid']
    print "uid", uid

    videoTable.insert({'key':filenameForStorage,'values':{'views':0,
                                                          'uploaded_by_uid':uid,
                                                          'uploaded_by_user':None,
                                                          'seen_by_users':[],
                                                          'ratings':[],
                                                          'location':filename,
                                                          'time':str(datetime.now())}})
    print filename
    upload.save( filename)
    return 'OK'

@route('/submit-email-password-initial', method="POST")
def submitEmailPassword():

    for k in request.forms.keys():
        print k, request.forms[k]

    username = request.forms.get('email')
    password = request.forms.get('password')
    h = hashlib.new('sha256')
    h.update(SALT_BEFORE + password + SALT_AFTER)
    password_hashed = h.hexdigest()

    usersTable = db.table('users')

    existingUser = usersTable.search(where('key') == username)
    if existingUser:
        if existingUser['values']['password'] == password_hashed:
            pass
        else:
            print "wrong login"
    else:
        usersTable.insert({'key':username, 'values':{'password':password_hashed}})
        videosTable = db.table('videos')
        existing_cookie = request.get_cookie('sebifyme',secret=GLOBAL_SECRET)
        uid = existing_cookie['uid']
        elements = videosTable.search(where('values').has('uploaded_by_uid') == uid)
        for el in elements:
            currentValues = el['values']
            currentValues['uploaded_by_user'] = username
            videosTable.update({'values':currentValues}, eids=[el.eid])

    website_content = template('video',video_name='joke.mp4')

    return website_content

@route('/vidz/<name>')
def show_videos(name='joke.mp4'):

    website_content = template('video',video_name=name)

    return website_content

@route('/randomvid')
def show_videos():

    videosTable = db.table('videos')
    allVideos = map(lambda x: x.eid,  videosTable.all())
    random_video = random.sample(allVideos,1)[0]
    website_content = template('video',video_name=videosTable.get(eid=random_video)['key'])

    return website_content

@route('/sendemail')
def send_email():

    from_addr = 'info@oinoi.com'
    to_addrs = ['dbaclin@gmail.com']
    # msg = open('email_msg.txt','r').read()
    msg = "hello world now \n"

    s = SMTP()
    s.connect('smtp.webfaction.com')
    s.login('oinoi',SMTP_PASSWORD)
    s.sendmail(from_addr, to_addrs, msg)
    s.quit()

@route('/mainpage')
def mainpage():
    website_content = template('index') # static_file('index.html', root='./static')
    existing_cookie = request.get_cookie("sebifyme",secret=GLOBAL_SECRET)

    if existing_cookie:
        print "last visit", existing_cookie['last_visit'], "nof visits:" , existing_cookie['nof_visits']
        response.set_cookie("sebifyme", {"last_visit":datetime.now(), "uid": existing_cookie['uid'], "nof_visits": existing_cookie['nof_visits'] + 1}, secret=GLOBAL_SECRET, max_age=365*24*60*60*5)
    else:
        response.set_cookie("sebifyme", {"last_visit":datetime.now(), "uid": get_a_uuid(), "nof_visits": 1}, secret=GLOBAL_SECRET, max_age=365*24*60*60*5)

    return website_content

# run(host='localhost', port=8080, debug=False)
run(host='localhost', port=8080, server='cherrypy')
# run(host='localhost', port=12704, server='cherrypy')
# 12704