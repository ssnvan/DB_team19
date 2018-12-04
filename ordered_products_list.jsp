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
	
	String query="SELECT O.Order_date, OP.Product_quantity, OP.Product_code from Orders O, Ordered_products OP " +
			"where O.OrderID= (select OrderID from Orders where Customer_ID = " + session.getAttribute("id") + ")";
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	while(rs.next()){
		String lists = "Date: " + rs.getString(1)+", ea. "+rs.getString(2)+", Products Name: "+rs.getString(3);
		out.println(lists);
		out.println("</br>");
	}
%>
<br />
<a href="login_success.jsp">BACK</a>


</body>
</html>