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

	String a="";
	String id=(String)request.getParameter("id");
	String pw =(String)request.getParameter("pw");
   
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


	if( isid && ispw ){
		out.println("login admin");
		response.sendRedirect("Admin_page.jsp");
		
	}
	else if( isid && !ispw ){
		response.sendRedirect("start.html");
	}
	else{
		String query="SELECT PW FROM Customer WHERE Customer_ID = " + id;
		pstmt = conn.prepareStatement(query);
		try{
			rs=pstmt.executeQuery();
			
			String t_pw="";
			ResultSetMetaData rsmd = rs.getMetaData();

			int cnt = rsmd.getColumnCount();
			while(rs.next()){
				t_pw  = (String)rs.getString(1);
			}
			
			
			out.println("after query");
			
			boolean ispw2=false;
			
			try{
				ispw2 = pw.equals(t_pw);
			}catch(NullPointerException e){
				out.println("null");
			}
			
			out.println(ispw2 + t_pw);
			if( ispw2 ){
				out.println("login ok");
				session.setAttribute("id", id);
				response.sendRedirect("login_success.jsp");
			}
			else{		
				response.sendRedirect("start.html");
			}
			
			
		}catch(com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException e){
			System.out.println(e.getMessage());
		}

		
		
	}
	
	
%>


</body>
</html>