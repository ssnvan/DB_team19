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

	String s_pw = (String)request.getParameter("s_pw");
	String s_address = (String)request.getParameter("s_address");
	String s_phone = (String)request.getParameter("s_phone");
	String s_sex = (String)request.getParameter("s_sex");
	String s_age = (String)request.getParameter("s_age");
	String s_job = (String)request.getParameter("s_job");
	String s_type = (String)request.getParameter("s_type");
	
	
	int age = 0;
	try{
		age = Integer.parseInt(s_age);
	}catch(NumberFormatException e){
		System.out.println(e.getMessage());
	}
	
	boolean s_value=false;
	if(s_sex.equals("F") || s_sex.equals("T")){
		s_value = false;
	}
	else{
		s_value=true;
	}
	
	if( s_pw.length()<4 || s_address.length() < 10 || s_phone.length() < 10 || s_value || (age <0 && age>100) ){
		response.sendRedirect("sign_up.html");
	}
	
	String query="INSERT INTO Customer values ('" + (String)request.getParameter("s_id")+"', '"
			+s_pw + "', '" +s_address + "', '" +s_phone + "', '" +s_sex + "', "+s_age + ", '"
			+s_job + "', '"+s_type + "')";
	
	out.println(query);
	pstmt = conn.prepareStatement(query);
	int rst=pstmt.executeUpdate();
	
	if(rst == 1){
	
	%>
	<br />
	<a href="start.html">SUCCESS!</a>
	<br />
	<%
	}
	else{
		response.sendRedirect("sign_up.html");	
	}
	%>
	
</body>
</html>