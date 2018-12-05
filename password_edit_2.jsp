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


	String pw_e = request.getParameter("pw_e");

	if( pw_e.length() >4 || pw_e.length()<0 ){
		response.sendRedirect("password_edit.jsp");
	}
	else{
		String query="UPDATE Customer set PW = " + pw_e
				+" WHERE Customer_ID = " + session.getAttribute("id");
		
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