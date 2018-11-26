<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Log in</title>
</head>
<body>
	<ul>
	<% String a;
	if( request.getParameter("id").equals("admin")&& request.getParameter("pw").equals("0000")){
		a="Streaming...";
		out.println(
				"<video width=\"640\" height=\"480\" controls>"
				  +"<source src=\"rtsp://222.104.215.115:8554/test\" type=\"video/mp4\">"
				  +"</video>");
	}else{
		a="Your ID / PW is wrong...";
	}
	out.println("<h2>"+a+"</h2>");
		
	%>
	</ul>

</body>
</html>