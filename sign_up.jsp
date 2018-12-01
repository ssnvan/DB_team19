<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 

	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmallX?characterEncoding=UTF-8&serverTimezone=UTC";
	String DB_USER = "root";
	String DB_PASSWORD= "8888";
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	Statement stmt;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	stmt = conn.createStatement();
	
	
	
	
	String query="INSERT INTO Customer value ('" + (String)request.getParameter("sign_id")+"', '"
			+(String)request.getParameter("sign_pw") + "', '"
			+(String)request.getParameter("address") + "', '"
			+(String)request.getParameter("phone") + "', '"
			+(String)request.getParameter("sex") + "', '"
			+(String)request.getParameter("age") + "', '"
			+(String)request.getParameter("job") + "', '"
			+(String)request.getParameter("type") + "'";
	pstmt = conn.prepareStatement(query);
	rs=pstmt.executeQuery();
	
	
	//insert success
	if(True){
		response.sendRedirect("start.html");
	}
	else{
		%>
		<a href="start.html">MAIN</a>
		<a href="sign_up.html">SIGN UP</a>
<%
	}

%>



</body>
</html>