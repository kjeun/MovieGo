<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head> 
<style type="text/css">
	#submenu {
		width : 30%;
		float : right;
	}
	#mypage {
		width : 70%;
		float : right;
	}
</style>
<body>
	<jsp:include page="header.jsp" flush="false"></jsp:include>
<div id="mypage">
mypage
</div>
<div id="submenu">
<jsp:include page="submenu.jsp"></jsp:include>
</div>
</body>
</html>