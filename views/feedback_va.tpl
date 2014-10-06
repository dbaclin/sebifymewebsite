
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="DoubleBees" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Sebify.me</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/starter-template.css" rel="stylesheet">
    <link href="css/dropzone/css/dropzone.css" rel="stylesheet">
     <link href="css/kartik-star-rating/css/star-rating.min.css" media="all" rel="stylesheet" type="text/css" />
    

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body id="feedback-page">

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><img src="img/icons/Sebify-Logo.png" /></a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container" id="feedback-page-content">

      <div class="row" id="row-banner">
        <div class="col-md-offset-1">
          <img id="page_logo" src="img/icons/darker-heart_no_crazy.png" />
          <h1>GIVE<br/><span class="lead">feedback to others</span></h1>
        </div>
      </div>


      <div class="row">
              <div class="col-md-5 col-md-offset-1" >
                  <h2>Watch the video</h2>
                  <div id="video-container"></div>
              </div>
              <div class="col-md-5" id="rating">
                <h2>Rate the video <span>(it will be anonymous)</span></h2>
                <div class="row">
                  <div class="col-md-4" ><p>Posture</p></div>
                  <div class="col-md-8" ><input id="input-posture" type="number" class="rating" min=1 max=5 step=1 data-size="xs" data-rtl="false"></div>

                </div>
                      <div class="row">
                  <div class="col-md-4" ><p>Gestures</p></div>
                  <div class="col-md-8" ><input id="input-gesture" type="number" class="rating" min=1 max=5 step=1 data-size="xs" data-rtl="false"></div>
                </div>
                <div class="row">
                  <div class="col-md-4" ><p>Derailers</p></div>
                  <div class="col-md-8" ><input id="input-derailers" type="number" class="rating" min=1 max=5 step=1 data-size="xs" data-rtl="false"></div>
                </div>
                <div class="row">
                  <div class="col-md-4" ><p>Voice</p></div>
                  <div class="col-md-8" ><input id="input-voice" type="number" class="rating" min=1 max=5 step=1 data-size="xs" data-rtl="false"></div>
                </div>

              </div>
      </div>
         <div class="row">
              <div class="col-md-5 col-md-offset-1" >
                    <h2>Give your feedback in words</h2>
                    <textarea rows="4" cols="50">
                        Your speech was very persuasive. Try to keep a strong spine and your head level up.
                    </textarea>
              </div>
              <div class="col-md-5" id="rating">
                <div class="row" id="total-rating">
                  <div class="col-md-4" ><p >Overall</p></div>
                  <div class="col-md-8" ><input id="input-posture" type="number" class="rating" min=1 max=5 step=1 data-size="xs" data-rtl="false"></div>

                </div>

              </div>
      </div>
      <div id="button-next-page">
              <form role="form" action="/submit" method="post">
                  <p id="row-button"><a class="btn btn-primary btn-lg" id="btn_to_nextstep" role="button">Next video &raquo;</a></p>
              </form>
      </div>


    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

      <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>


    <script src="js/dropzone/dropzone.js"></script>
    <script src="js/kartik-star-rating/js/star-rating.min.js" type="text/javascript"></script>
    
    <script>
        Dropzone.autoDiscover = false;
        var myDropzone = new Dropzone("div#my-awesome-dropzone",
                   {
                    url: "/file-upload",
                    maxFilesize: 50,
                    addRemoveLinks: true,
                    dictDefaultMessage: "Drop files here to upload"
                    });

        // initialize with defaults
          $(".rating").rating();
 
          // with plugin options
          $(".rating").rating(['min'=>1, 'max'=>5, 'step'=>1, 'size'=>'xs', 'data-rtl' => 'false']);

        
        $(document).ready(function() {
                

            myDropzone.on("addedfile", function(file) {
    /* Maybe display some more file information on your page $('#submitVideo').attr('disabled','disabled'); */
            });


          

        });

    </script>

  </body>
</html>
