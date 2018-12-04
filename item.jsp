<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item Description</title>
</head>
<body>

<%
    String serverIP="localhost";
    String portNum="3306";
    String url="jdbc:mysql://localhost:3306/shoppingmallX?characterEncoding=UTF-8&serverTimezone=UTC";
    String user="root";
    String pass="8888";
    Connection conn=null;
    PreparedStatement pstmt;
    ResultSet rs;
    String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(url, user,pass);
    }catch(Exception e){
        System.out.println(e.getMessage());
    }
%>
<%
	String Product_code = request.getParameter("Product_code");
	String query;
	query = "select Product_name from Product where Product_code = \""+Product_code+"\"";
		
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	while(rs.next())
		out.println("Selected Product : "+rs.getString(1));
	out.println("</br>");
		
	query = "select * from Product where Product_code = \""+Product_code+"\"";
		
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	ResultSetMetaData rsmd = rs.getMetaData();
	while(rs.next()){
		out.println(rsmd.getColumnName(5)+" : "+rs.getString(5)+"</br>");
		out.println(rsmd.getColumnName(2)+" : "+rs.getInt(2)+"</br>");
		out.println(rsmd.getColumnName(3)+" : "+rs.getInt(3)+"</br>");
		out.println(rsmd.getColumnName(6)+" : "+rs.getString(6)+"</br>");
		out.println(rsmd.getColumnName(7)+" : "+rs.getString(7)+"</br>");
	}
%>
<br />
<form action = "buy.jsp" method = "POST">
<input type = "submit" value = "Buy"/>
</form>
</body>
</html>