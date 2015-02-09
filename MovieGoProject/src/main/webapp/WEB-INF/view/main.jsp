<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">
<!-- video css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bigvideo.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/content.css">
<!-- form css  -->
<link rel="stylesheet" type="text/css" href="css/demo.css" />
<script src="<%=request.getContextPath() %>/js/modernizr-2.5.3.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- contents -->
    <header>
        <div class="mockup-content">
					<div class="morph-button morph-button-modal morph-button-modal-2 morph-button-fixed">
						<button type="button">Login</button>
						<div class="morph-content">
							<div>
								<div class="content-style-form content-style-form-1">
									<span class="icon icon-close">Close the dialog</span>
									<h2>Login</h2>
									<form>
										<p><label>Email</label><input type="text" /></p>
										<p><label>Password</label><input type="password" /></p>
										<p><button>Login</button></p>
									</form>
								</div>
							</div>
						</div>
					</div><!-- morph-button -->
					<strong class="joiner">or</strong>
					<div class="morph-button morph-button-modal morph-button-modal-3 morph-button-fixed">
						<button type="button">Signup</button>
						<div class="morph-content">
							<div>
								<div class="content-style-form content-style-form-2">
									<span class="icon icon-close">Close the dialog</span>
									<h2>Sign Up</h2>
									<form>
										<p><label>Email</label><input type="text" /></p>
										<p><label>Password</label><input type="password" /></p>
										<p><label>Repeat Password</label><input type="password" /></p>
										<p><button>Sign Up</button></p>
									</form>
								</div>
							</div>
						</div>
					</div><!-- morph-button -->
				</div><!-- /form-mockup -->
    </header>

	<!-- video -->
	<div class="wrapper">
        <div class="screen" id="screen-3" data-video="vid/camera.mp4">
            <img src="<%=request.getContextPath() %>/img/camera.jpg" class="big-image" />
            <h1 class="video-title">MOVIE <font color="#a52127">GO</font></h1>
        </div>
    </div>


    <!-- BigVideo Dependencies -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/jquery-1.8.1.min.js"><\/script>')</script>
    <script src="<%=request.getContextPath() %>/js/jquery-ui-1.8.22.custom.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery.imagesloaded.min.js"></script>
    <script src="<%=request.getContextPath() %>/http://vjs.zencdn.net/c/video.js"></script>

    <!-- BigVideo -->
    <script src="js/bigvideo.js"></script>

    <!-- Tutorial Demo -->
    <script src="js/jquery.transit.min.js"></script>
    <script>
        $(function() {

            // Use Modernizr to detect for touch devices, 
            // which don't support autoplay and may have less bandwidth, 
            // so just give them the poster images instead
            var screenIndex = 1,
                numScreens = $('.screen').length,
                isTransitioning = false,
                transitionDur = 1000,
                BV,
                videoPlayer,
                isTouch = Modernizr.touch,
                $bigImage = $('.big-image'),
                $window = $(window);
            
            if (!isTouch) {
                // initialize BigVideo
                BV = new $.BigVideo({forceAutoplay:isTouch});
                BV.init();
                showVideo();
                
                BV.getPlayer().addEvent('loadeddata', function() {
                    onVideoLoaded();
                });

                // adjust image positioning so it lines up with video
                $bigImage
                    .css('position','relative')
                    .imagesLoaded(adjustImagePositioning);
                // and on window resize
                $window.on('resize', adjustImagePositioning);
            }
            
            function showVideo() {
                BV.show($('#screen-'+screenIndex).attr('data-video'),{ambient:true});
            }

            function next() {
                isTransitioning = true;
                
                // update video index, reset image opacity if starting over
                if (screenIndex === numScreens) {
                    $bigImage.css('opacity',1);
                    screenIndex = 1;
                } else {
                    screenIndex++;
                }
                
                if (!isTouch) {
                    $('#big-video-wrap').transit({'left':'-100%'},transitionDur)
                }
                    
                (Modernizr.csstransitions)?
                    $('.wrapper').transit(
                        {'left':'-'+(100*(screenIndex-1))+'%'},
                        transitionDur,
                        onTransitionComplete):
                    onTransitionComplete();
            }

            /* 
					function onVideoLoaded() {
						    $('#screen-'+screenIndex).find('.big-image').transit({'opacity':0},500)
						}
						 
						function onTransitionComplete() {
						    isTransitioning = false;
						    if (!isTouch) {
						        $('#big-video-wrap').css('left',0);
						        showVideo();
						    }
						} 
						  
						 function adjustImagePositioning() {
						    $bigImage.each(function(){
						        var $img = $(this),
						            img = new Image();

						        img.src = $img.attr('src');

						        var windowWidth = $window.width(),
						            windowHeight = $window.height(),
						            r_w = windowHeight / windowWidth,
						            i_w = img.width,
						            i_h = img.height,
						            r_i = i_h / i_w,
						            new_w, new_h, new_left, new_top;

						        if( r_w > r_i ) {
						            new_h   = windowHeight;
						            new_w   = windowHeight / r_i;
						        }
						        else {
						            new_h   = windowWidth * r_i;
						            new_w   = windowWidth;
						        }

						        $img.css({
						            width   : new_w,
						            height  : new_h,
						            left    : ( windowWidth - new_w ) / 2,
						            top     : ( windowHeight - new_h ) / 2
						        })

						    });

						} */
					});
				</script>
</body>
</html>