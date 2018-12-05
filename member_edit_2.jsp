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

	
	
	String m_address=(String)request.getParameter("m_address");
	String m_phone=(String)request.getParameter("m_phone");
	String m_sex=(String)request.getParameter("m_sex");
	String m_age=(String)request.getParameter("m_age");
	String m_job=(String)request.getParameter("m_job");
	String m_type=(String)request.getParameter("m_type");
	int age = -1;
	try{
		age = Integer.parseInt(m_age);
	}catch(NumberFormatException e){
		System.out.println(e.getMessage());
	}

	boolean s_value=false;
	if(m_sex.equals("F") || m_sex.equals("M")){
		s_value = false;
	}
	else{
		s_value=true;
	}
	String query="UPDATE Customer set Address = '"  + m_address + "', Phone ='" + m_phone + 
			"', Sex = '" + m_sex + "', Age = " +age + ", Job = " + m_job + ", Type ='" + m_type +"'"
			+" WHERE Customer_ID = " + session.getAttribute("id");
	
	if( m_address.length() > 10 || m_phone.length() > 13 || s_value || (age <0 && age>100) || m_job.length() > 15){
		response.sendRedirect("member_edit.jsp");
	}
	
	else{
		pstmt = conn.prepareStatement(query);
		try{
			int ret = pstmt.executeUpdate();
			System.out.println("Return : " + ret);
			if(ret == 1){
			%>
			<a href="login_success.jsp">SUCCESS!</a>
			<%
			}
			else{
				response.sendRedirect("edit_failed.jsp");
			}

			
		}catch(com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException e){
			System.out.println(e.getMessage());
		}catch(java.sql.SQLException e){
			System.out.println(e.getMessage());
		}
	}
	
%>

</body>
</html>