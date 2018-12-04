<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = "";
	try{
		id = (String)session.getAttribute("id");
		out.println("Hello " + id);
	}catch(NullPointerException e){
		out.println("id is null");
	}
%>

<a href=logout.jsp>LOG OUT</a>
<br />
<a href=member_edit.jsp>MEMBER EDIT</a>
<br />
<a href=password_edit.jsp>PASSWORD EDIT</a>
<br />
</body>
</html>