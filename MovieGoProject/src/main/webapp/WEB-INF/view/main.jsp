<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- video css -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/main/css/style.css">
<!-- content css -->
<link rel="shortcut icon" href="../favicon.ico">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/main/css/component.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/main/css/content.css" />
<script src="<%=request.getContextPath()%>/main/js/modernizr.custom.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
/* input 박스에 기본값 넣어주고 마우스 클릭시 초기화 */ 
	$(document).ready(function() {
		$("#joinid").focus(function() {
			$(this).val('');
		}).blur(function() {
			if ($(this).val() == "") {
				$(this).val("아이디는 영문/숫자 10자리 입력");
			}
		});
	});
</script>
<title>메인 페이지</title>
</head>
<body>
	<!-- 메인 배경화면 -->
		<div class="wrapper">
			<div class="screen" id="screen-3" data-video="vid/camera.mp4">
				<img src="<%=request.getContextPath()%>/img/camera.jpg"
					class="big-image" />
				<h1 class="main-title">MOVIE<font color="#A52127">GO</font></h1>
			</div>
		</div>
		<!-- 로그인/회원가입 -->
		<header>
				<div class="mockup-content">
					<div class="morph-button morph-button-modal morph-button-modal-1 morph-button-fixed">
						<button type="button">LOGIN</button>
						<div class="morph-content">
							<div>
								<div class="content-style-form content-style-form-1">
									<span class="icon icon-close">Close the dialog</span>
									<h2>Login</h2>
									<form>
										<p><label>Email</label><input type="text" /></p>
										<p><label>Password</label><input type="password" /></p>
										<p><button>Login</button></p>
										<p id="searchinfo"><a href="javascript:userInfo()">ID/비밀번호 찾기</a></p>
									</form>
								</div>
							</div>
						</div>
					</div><!-- morph-button -->
					<div class="morph-button morph-button-modal morph-button-modal-2 morph-button-fixed">
						<button type="button">SIGN UP</button>
						<div class="morph-content">
							<div>
								<div class="content-style-form content-style-form-2">
									<span class="icon icon-close">Close the dialog</span>
									<h2>Sign Up</h2>
									<form name="joinform">
										<p><label>아이디 (영문/숫자 혼합 10자리)</label><input type="text"/></p>
										<p><label>이메일</label><input type="text" /></p>
										<p><label>비밀번호 (영문/숫자 혼합 10자리)</label>
										<input type="password" id="pass" name="pass"/></p>
										<p><label>비밀번호 확인</label>
										<input type="password" id="pass2" name="pass2" onblur="javascript:passchk()"/></p>
										<input type="text" name="chk" id="confirm"  
										value="비밀번호를 입력하세요" readonly="readonly">
										<p><label>생년월일</label><input type="date" /></p>
										<p><button>Sign Up</button></p>
									</form>
								</div>
							</div>
						</div>
					</div><!-- morph-button -->
				</div><!-- /form-mockup -->
		</header>	
	<script src="<%=request.getContextPath()%>/main/js/classie.js"></script>
	<script src="<%=request.getContextPath()%>/main/js/uiMorphingButton_fixed.js"></script>
	<script>
		function userInfo(){
			<c:url value="/find_user_info" var="url"></c:url>
			window.open('${url}','client_window', 'resizable=no scrollbars=no width=400 height=550');
		}
		/* 비밀번호 유효성 체크 */
		function passchk() {
			var pass = document.joinform.pass.value;
			var pass2 = document.joinform.pass2.value;
			if (pass2.length == 0 || pass2 == null) {
				document.joinform.chk.value = "비밀번호를 입력하세요";
			} else if (pass != pass2) {
				document.joinform.chk.value = "비밀번호가 다릅니다.";
			} else {
				document.joinform.chk.value = "비밀번호가 동일합니다.";
			}
			return;
		}
		
		(function() {
			var docElem = window.document.documentElement, didScroll, scrollPosition;

			// trick to prevent scrolling when opening/closing button
			function noScrollFn() {
				window.scrollTo(scrollPosition ? scrollPosition.x : 0,
						scrollPosition ? scrollPosition.y : 0);
			}

			function noScroll() {
				window.removeEventListener('scroll', scrollHandler);
				window.addEventListener('scroll', noScrollFn);
			}

			function scrollFn() {
				window.addEventListener('scroll', scrollHandler);
			}

			function canScroll() {
				window.removeEventListener('scroll', noScrollFn);
				scrollFn();
			}

			function scrollHandler() {
				if (!didScroll) {
					didScroll = true;
					setTimeout(function() {
						scrollPage();
					}, 60);
				}
			}
			;

			function scrollPage() {
				scrollPosition = {
					x : window.pageXOffset || docElem.scrollLeft,
					y : window.pageYOffset || docElem.scrollTop
				};
				didScroll = false;
			}
			;

			scrollFn();

			[].slice.call(document.querySelectorAll('.morph-button')).forEach(
					function(bttn) {
						new UIMorphingButton(bttn, {
							closeEl : '.icon-close',
							onBeforeOpen : function() {
								// don't allow to scroll
								noScroll();
							},
							onAfterOpen : function() {
								// can scroll again
								canScroll();
							},
							onBeforeClose : function() {
								// don't allow to scroll
								noScroll();
							},
							onAfterClose : function() {
								// can scroll again
								canScroll();
							}
						});
					});

			// for demo purposes only
			[].slice.call(document.querySelectorAll('form button')).forEach(
					function(bttn) {
						bttn.addEventListener('click', function(ev) {
							ev.preventDefault();
						});
					});
		})();
		
		
	</script>
</body>
</html>
