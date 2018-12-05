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
<br />
<a href=logout.jsp>LOG OUT</a>
<br />
<a href=member_edit.jsp>MEMBER EDIT</a>
<br />
<a href=password_edit.jsp>PASSWORD EDIT</a>
<br />
<br />
<a href=Category.jsp>Category</a>
<br />
<a href=ordered_products_list.jsp>Ordered products list</a>
<br />
<a href=cart.jsp>Cart</a>
<br />
<a href=recommendation.jsp>Recommend</a>
<br />
</body>
</html>