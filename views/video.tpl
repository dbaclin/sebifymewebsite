 <html>
      <head>

        <link href="/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="/css/agency.css" rel="stylesheet">

            <link href="/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>


        <link href="/css/general.css" rel="stylesheet">
        <link href="/css/owl/owl.carousel.css" rel="stylesheet">
        <link href="/css/owl/owl.theme.css" rel="stylesheet">
        <link href="/css/owl/owl.transitions.css" rel="stylesheet">

      </head>
      <body>

        <div id="owl-carousel-videos" class="owl-carousel owl-theme">

            % radioIndex = 0
            % video_list = ['HJc-xu7FShyOm1gYSjX9tA1.MOV','HJc-xu7FShyOm1gYSjX9tA2.MOV','HJc-xu7FShyOm1gYSjX9tA3.MOV']
            % for players in xrange(3):
            %    video_to_play = video_list[players]
            %    players = players + 1
            <div class="item videoplayer">
                <video id="video{{players}}" controls preload="metadata"><source src="/videos/{{video_to_play}}"></source></video>
                <div class="row">
                     <div class="col-xs-1 col-md-1"></div>
                     % from questionnaire_templates import presentation_skills
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
                            <td class="questionnaire theme item">{{question}}</td>
                            <td class="questionnaire yes-no answer"><input type="radio" name="optionsRadios{{radioIndex}}" value="yes"></td>
                            <td class="questionnaire yes-no answer"><input type="radio" name="optionsRadios{{radioIndex}}" value="no"></td>
                        </tr>
                      %   radioIndex = radioIndex + 1
                      % end
                      </tbody>
                    </table>
                    </div>
                    % end
                    <div class="col-xs-1 col-md-1"></div>
                </div>
          </div>
          % end

        </div>

        <script src="http://popcornjs.org/code/dist/popcorn-complete.min.js"></script>
        <script src="/js/jquery-1.11.0.js"></script>
        <script src="/js/owl.carousel.js"></script>

		<script>

             $( document ).ready(function() {


              $("#owl-carousel-videos").owlCarousel({

                  navigation: true,
                  slideSpeed : 300,
                  paginationSpeed : 400,
                  transitionStyle:"fade",
                  singleItem:true,
                  mouseDrag : false,
                  touchDrag : false

                  // "singleItem:true" is a shortcut for:
                  // items : 1,
                  // itemsDesktop : false,
                  // itemsDesktopSmall : false,
                  // itemsTablet: false,
                  // itemsMobile : false

              });

              });


		</script>
     </body>
   </html>