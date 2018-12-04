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
	String m_address=(String)request.getParameter("m_address");
	String m_phone=(String)request.getParameter("m_phone");
	String m_sex=(String)request.getParameter("m_sex");
	String m_age=(String)request.getParameter("m_age");
	String m_job=(String)request.getParameter("m_job");

	/*
	if( m_address.length() < 10 ){
		response.sendRedirect("member_edit_failed.jsp");
	}
	if(m_phone.length() < 10){
		response.sendRedirect("member_edit_failed.jsp");
	}
	if( !m_sex.equals("F") || !m_sex.equals("T")){
		response.sendRedirect("member_edit_failed.jsp");
	}
	int age = Integer.parseInt(m_age);
	if( age <0 && age>100 ){
		response.sendRedirect("member_edit_failed.jsp");
	}*/
	int age = Integer.parseInt(m_age);	
	if( m_address.length() < 10 || m_phone.length() < 10 || !m_sex.equals("F") || !m_sex.equals("T") || (age <0 && age>100) ){
		response.sendRedirect("member_edit_failed.jsp");
	}
%>

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

	
	String id = "";
	try{
		id = (String)session.getAttribute("id");
		out.println("Hello " + id);
	}catch(NullPointerException e){
		out.println("id is null");
	}
	
	String query="UPDATE Employee SET Address = " + m_address + ", " +
			"Phone = " + m_phone + ", "+
			"Sex = " + m_sex + ", "+
			"Age = " + age + ","+
			"Job = " + m_job + 
			"WHERE ID = " + id;
	pstmt = conn.prepareStatement(query);
	rs=pstmt.executeQuery();


%>

</body>
</html>