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
String categoryID = request.getParameter("category");
String Product_name = request.getParameter("Product_name");
String query;
if(categoryID != null){
	query = "select * from Category where Category_ID = \""+categoryID+"\"";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	while(rs.next()){
	String category = rs.getString(2)+"-"+rs.getString(3)+"-"+rs.getString(4);
	out.println("Selected Category : "+category);
	out.println("</br>");
	}
	query = "select * from Product where Category_ID = \""+categoryID+"\"";
}else{
	query = "select * from Product where Product_name like \"%"+Product_name+"%\"";
	out.println("Search Keyword : "+Product_name);
	out.println("</br>");
}
%>
<form action = "item.jsp" method = "POST">

<%
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();
int cnt = rsmd.getColumnCount();
while(rs.next()){
	out.println("<input type = \"radio\" name = \"Product_code\" value=\""+rs.getString(1)+"\">"+rs.getString(5)+".......price : "+rs.getInt(2));
	out.println("</br>");
}
%>

<input type = "submit" value = "Select"/>

</form>
</body>
</html>