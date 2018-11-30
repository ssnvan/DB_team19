<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShoppingmallX - Category</title>
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
        System.out.println("connected");
    }catch(Exception e){
        System.out.println(e.getMessage());
    }
%>

<h2>Select Category</h2>
</br>

<form action = "item_list.jsp" method = "POST">
Search item: <input type = "text" name = "item_name">
<input type = "submit" value = "검색"/>
</form>
</br>
<h3>Select Category</h3>
<form action = "item_list.jsp" method = "POST">

<select name = "category">
<%
String query = "select * from Category";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();

int cnt = rsmd.getColumnCount();

while(rs.next()){
	out.println("<option value = \""+rs.getString(1)+"\">"+rs.getString(2)+"-"+rs.getString(3)+"-"+rs.getString(4)+"</option>");
}
%>


</select>

<input type = "submit" value = "선택"/>
</form>
<% 
pstmt.close();
conn.close();
%>

</body>
</html> 