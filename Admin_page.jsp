<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Admin</title>
</head>
<body>
<h2>Administrator Page</h2>
<%
    String serverIP="localhost";
    String portNum="3306";
    String url="jdbc:mysql://localhost:3306/shoppingmallX?characterEncoding=UTF-8&serverTimezone=UTC";
    String user="root";
    String pass="8888";
    Connection conn=null;
    PreparedStatement pstmt;
    Statement stmt;
    ResultSet rs;
    String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    try{
        Class.forName(JDBC_DRIVER);
        conn = DriverManager.getConnection(url, user,pass);
    }catch(Exception e){
        System.out.println(e.getMessage());
    }
%>
<h2>Increase Inventory</h2> 
<br />
<form action = "increase_item.jsp" method = "POST">
	<select name = "product_increase">
	<%
	String query = "select Product_code, Product_name from Product";
	try{
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		out.println("<option value = '' selected>--select Product--</option>");
		while(rs.next()){
			out.println("<option value = \""+rs.getString(1)+"\">"+rs.getString(1)+"</option>");
		}
	}catch(NullPointerException e){
		out.println(e.getMessage());
	}
		
	%>
	</select>
	increase
	<select name = "product_increase_val">
	<option value = '' selected>--select Unit--</option>
	<%
	for(int i=1;i<=20;i++){
		out.println("<option value = \""+i+"\">"+i+" unit </option>");
	}
	%>
	</select>
	
	<input type = "submit" value = "Increase"/>
</form>


<h2>Out of stock</h2>
<br />
<%
	query = "create view To_order as"
			+" select Product_code, sum(Product_quantity) as orderNum from Cart_orders group by Product_code";
	try{
		stmt = conn.createStatement();
		
		stmt.executeUpdate(query);
		query = "create view P_inven as"
			+" select p.Product_code, p.inventory from Product p"
			+" where p.Product_code in (select Product_code from Cart_orders group by Product_code)"
			+" group by p.Product_code";
		stmt.executeUpdate(query);
		query = "select i.Product_code, i.inventory, o.orderNum from P_inven i, To_order o"
				+" where i.Product_code = o.Product_code"
				+" and i.inventory<o.orderNum";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
%>
<table border="1">
<th>Product code</th>
<th>Left Inventory</th>
<th>Total numbers in the cart</th>
<% 
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getInt(2)+"</td>");
			out.println("<td>"+rs.getInt(3)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		query = "drop view To_order";
		stmt.executeUpdate(query);
		query = "drop view P_inven";
		stmt.executeUpdate(query);
%>
<h2>Total sales : </h2>
<%
		query = "select sum(temp.num*temp.p) as money from("
				+"select sum(O.Product_quantity) num , O.Product_code code, P.Price p"
				+" from Ordered_products O,Product P"
				+" where O.Product_code = P.Product_code"
				+" group by O.Product_code"
				+") as temp";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){
			out.println("Total Sales : "+rs.getInt(1));
		}
%>
</table>
<br />
<form action="monthly_sales.jsp">
	<select name = "year">
	<option value = '' selected>--select Year--</option>
	<%
		for(int i=2014;i<=2018;i++){
			out.println("<option value = \""+i+"\">"+i+"</option>");
		}
	%>
	</select>
	<select name = "month">
	<option value = '' selected>--select Month--</option>
	<%
		for(int i=1;i<=12;i++){
			out.println("<option value = \""+i+"\">"+i+"</option>");
		}
	%>
	<input type = "submit" value = "Search Monthly Sales"/>
	</select>
</form>


<form action="date_sales.jsp">
  <input type="date" name="date">
  <input type="submit" value = "Search Date Sales">
</form>



<form action = "total_sales.jsp" method = "POST">

<h2>Number of times that each Delivery Delivered</h2>
<br />
<%
		query = "select count(*) as total_delivery, Delivery_name from Orders group by Delivery_Name";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){
			out.println(rs.getString(2)+" : "+rs.getString(1)+" times delivered");
			out.println("</br>");
		}
	}catch(NullPointerException e){
		out.println(e.getMessage());
	}
%>


</form>
</body>
</html>