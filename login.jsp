<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language = "java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%-- --%>
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

	String a="";
	String id=(String)request.getParameter("id");
	String pw ="";//(String)request.getParameter("pw")
   
	boolean isid=false, ispw=false;
	try{
		isid = id.equals("admin");
	}catch(NullPointerException e){
		out.println("null");
	}
	try{
		ispw = pw.equals("0000");
	}catch(NullPointerException e){
		out.println("null");
	}

	if( isid && ispw){
		a="login admin";
	}
	else{
		String query="SELECT PW FROM Customer WHERE Customer_ID = " + id;
		pstmt = conn.prepareStatement(query);
		rs=pstmt.executeQuery();


		String t_pw="";
		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData();

		int cnt = rsmd.getColumnCount();
		while(rs.next()){
			t_pw  = (String)rs.getString(1);
		}

		if( pw.equals(t_pw) ){
			response.sendRedirect("success_login.html");
		}
		else{
			out.println("LOGIN Failed");
			
%>
			<a href="start.html">MAIN</a>			
<%	
		}
	}
	
	
	%>



</body>
</html>