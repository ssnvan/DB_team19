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
    String url="jdbc:mysql://localhost:3306/shop?characterEncoding=UTF-8&serverTimezone=UTC";
    String user="root";
    String pass="000000";
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
<h2>Increase Inventory</h2> </br>
<form action = "increase_item.jsp" method = "POST">
<select name = "product_increase">
<%
String query = "select Product_code, Product_name from Product";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
ResultSetMetaData rsmd = rs.getMetaData();

int cnt = rsmd.getColumnCount();
out.println("<option value = '' selected>--select Product--</option>");
while(rs.next()){
	out.println("<option value = \""+rs.getString(1)+"\">"+rs.getString(1)+"</option>");
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


<h2>Out of stock</h2></br>
<%
query = "create view To_order as"
		+" select Product_code, sum(Product_quantity) as orderNum from Cart_orders group by Product_code";
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
<form action="/action_page.php">
  Birthday:
  <input type="date" name="bday">
  <input type="submit">
</form>



<form action = "total_sales.jsp" method = "POST">
<select name = "year_1" id="testid">
<option value = '' selected>--select Year--</option>
<%
for(int i=2014;i<=2018;i++){
	out.println("<option value = \""+i+"\">"+i+"</option>");
}
%>
</select>
<select name = "month_1">
<option value = '' selected>--select Month--</option>
<%
for(int i=1;i<=12;i++){
	out.println("<option value = \""+i+"\">"+i+"</option>");
}
%>
</select>
<script type="text/javascript">
var temp = document.getElementByID("testid");
alert(temp.oprions[temp.selectedIndex].text);
</script>

<input type = "submit" value = "Search Monthly Sales"/>
</form>


<form action = "total_sales.jsp" method = "POST">
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
</select>
<select name = "date">
<option value = '' selected>--select Date--</option>
<%
for(int i=1;i<=31;i++){
	out.println("<option value = \""+i+"\">"+i+"</option>");
}
%>
</select>
<input type = "submit" value = "Search Date Sales"/>
</form>


<h2>Number of times that each Delivery Delivered</h2></br>

<%
query = "select count(*) as total_delivery, Delivery_name from Orders group by Delivery_Name";
pstmt = conn.prepareStatement(query);
rs = pstmt.executeQuery();
while(rs.next()){
	out.println(rs.getString(2)+" : "+rs.getString(1)+" times delivered");
	out.println("</br>");
}
%>

</body>
</html>