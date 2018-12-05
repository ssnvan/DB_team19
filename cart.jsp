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
    int res;
    Statement stmt=null;
    ResultSet rs;
    String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(url, user,pass);
    }catch(Exception e){
        System.out.println(e.getMessage());
    }
    String id="";
    id = (String)session.getAttribute("id");
    String query = null;

%>
	<table border="1">
	<th>Product code</th>
	<th>Quantity</th>
<%
	String cart = null;
	query ="select Cart_code from Cart where Customer_ID=\""+id+"\"";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	while(rs.next()){
		cart = rs.getString(1);
	}
	query = "select * from Cart_orders where Cart_code='"+cart+"'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("<td>"+rs.getInt(2)+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	 
 
 %>
 <form action = "Order.jsp" method = "POST">
<select name = "delivery">
<option value = '' selected>--select delivery--</option>
<option value="Hanjin">Hanjin</option>
<option value="Coupang">Coupang</option>
<option value="Logen">Logen</option>
</select>

<input type = "submit" value = "Order"/>
</form>
 

</body>
</html>
