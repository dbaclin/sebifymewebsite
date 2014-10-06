
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


    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body id="upload-page">

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

    <div class="container" id="upload-page-content">

      <div class="row" id="row-banner">
        <div class="col-md-offset-2">
          <img id="page_logo" src="img/icons/cloud32_BLUE.png" />
          <h1>UPLOAD<br/><span class="lead">your speech</span></h1>
        </div>
      </div>
      
             


      <div class="row">
        <div class="col-md-8 col-md-offset-2">
                    
              
              
              <div class="dropzone" id="my-awesome-dropzone" ></div>
              <p clas="text-left" id="instructions">People will see your speech but they won’t receive the file. Once you get your feedback, your video will be deleted from our server
              </p>
              <div id="button-next-page">
              <form role="form" action="/submit" method="post">
                  <p id="row-button"><a class="btn btn-primary btn-lg" id="btn_to_feedback" role="button">Upload &raquo;</a></p>
              </form>
            </div>

        </div>
        <div class="col-md-2"></div>
      </div>
    </div><!-- /.container -->
    <footer></footer>

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

    <script>
        Dropzone.autoDiscover = false;
        var myDropzone = new Dropzone("div#my-awesome-dropzone",
                   {
                    url: "/file-upload",
                    maxFilesize: 50,
                    addRemoveLinks: true,
                    dictDefaultMessage: "Drop files here to upload"
                    });



        
        $(document).ready(function() {
                

                myDropzone.on("addedfile", function(file) {
    /* Maybe display some more file information on your page $('#submitVideo').attr('disabled','disabled'); */
                });
        });

    </script>

  </body>
</html>
