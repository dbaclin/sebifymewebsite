 <html>
      <head>

        <link href="/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="/css/agency.css" rel="stylesheet">

        <link href="/css/general.css" rel="stylesheet">

            <link href="/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

      </head>
      <body>

            <div id="video-feedback">
                <video id="videoplayer" controls preload="metadata"><source src="{{video_url}}"></source></video>
                <div class="row">
                     <div class="col-xs-1 col-md-1"></div>
                     % from questionnaire_templates import presentation_skills
                     % radioIndex = 0
                     % for theme in presentation_skills:
                     <div class="col-xs-6 col-md-2">
                     <table class="table questionnaire">
                      <thead>
                        <tr>
                          <th class="questionnaire theme header">{{theme}}</th>
                          <th class="questionnaire yes-no header">Yes</th>
                          <th class="questionnaire yes-no header">No</th>
                        </tr>
                      </thead>
                      <tbody>
                      % for question in presentation_skills[theme]:
                        <tr>
                            <td class="questionnaire theme item answer">{{question}}</td>
                            <td class="questionnaire yes-no answer"><input type="radio" name="optionsRadios{{radioIndex}}" value="yes"></td>
                            <td class="questionnaire yes-no answer"><input type="radio" name="optionsRadios{{radioIndex}}" value="no"></td>
                        </tr>
                      %     radioIndex = radioIndex + 1
                      % end
                      </tbody>
                    </table>
                    </div>
                    % end
                    <div class="col-xs-1 col-md-1"></div>
                </div>

                <div class="row">
                        <div class="col-xs-1 col-md-1"></div>
                        <div class="col-xs-24 col-md-8"><textarea class="form-control freetext-feedback" rows="2"></textarea></div>
                        <div class="col-xs-1 col-md-1"></div>
                </div>
                <div class="row">
                        <div class="col-xs-1 col-md-1"></div>
                        <div class="col-xs-12 col-md-4">
                            <button type="submit" class="btn btn-xl submit feedback" id='submit-feedback' >Submit Feedback</button>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <button type="submit" class="btn btn-xl submit feedback" id='i-am-done' >I am done!</button>
                        </div>
                        <div class="col-xs-1 col-md-1"></div>
                </div>

            </div>


        <script src="http://popcornjs.org/code/dist/popcorn-complete.min.js"></script>
        <script>


        </script>

     </body>
   </html>