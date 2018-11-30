<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShoppingmallX - Item list</title>
</head>
<body>

<%
    String serverIP="localhost";
    String portNum="3306";
    String url="jdbc:mysql://localhost:3306/shop?characterEncoding=UTF-8&serverTimezone=UTC";
    String user="root";
    String pass="000000";
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
String categoryID = request.getParameter("category");
String query = "select * from Category where Category_ID = \""+categoryID+"\"";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
while(rs.next()){
String category = rs.getString(2)+"-"+rs.getString(3)+"-"+rs.getString(4);
out.println("Selected Category : "+category);
}
query = "select * from Product where Category_ID = \""+categoryID+"\"";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();
int cnt = rsmd.getColumnCount();

out.println("<table border = \"1\">");
out.println("<th>"+rsmd.getColumnName(5)+"</th>");
out.println("<th>"+rsmd.getColumnName(2)+"</th>");
out.println("<th>"+rsmd.getColumnName(3)+"</th>");
out.println("<th>"+rsmd.getColumnName(6)+"</th>");
out.println("<th>"+rsmd.getColumnName(7)+"</th>");
while(rs.next()){
	out.println("<tr>");
	out.println("<td>"+rs.getString(5)+"</td>");
	out.println("<td>"+rs.getInt(2)+"</td>");
	out.println("<td>"+rs.getInt(3)+"</td>");
	out.println("<td>"+rs.getString(6)+"</td>");
	out.println("<td>"+rs.getString(7)+"</td>");
	out.println("</tr>");
}
%>
</body>
</html>