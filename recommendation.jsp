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

	String id = (String)session.getAttribute("id");
	String query="SELECT * FROM Orders WHERE Customer_ID = '"+ id+ "'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	int i=0;
	while(rs.next()){
		rs.getString(1);
		i++;
	}
	boolean a=false;
	if(i==0){
		a= true;
	}
	
	
	query="select * from Cart_orders where Cart_code in (select Cart_code from Cart where Customer_ID='"+ session.getAttribute("id") +"')";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	i=0;
	while(rs.next()){
		rs.getString(1);
		i++;
	}
	boolean b=false;
	if(i==0){
		b= true;
	}
	
	if(a && b){
		out.println("2 products with the highest order frequency <br />");
		
		query = "select count(*) as num,Product_code from Ordered_products group by Product_code order by num desc limit 2";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){
			String s = "Num: "+rs.getString(1) + ", Product_code: " + rs.getString(2);
			out.println(s + "<br />");
			
		}
		out.println("<br />");
		
		
		
		out.println("2 products of the most frequent items in the current shopping cart <br />");
		
		query = "select count(*) as num, Product_code from Cart_orders group by Product_code order by num desc limit 2;";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){
			String s = "Num: "+rs.getString(1) + ", Product_code: " + rs.getString(2);
			out.println(s + "<br />");
			
		}
		out.println("<br />");
		
		
		query = "select Type from Customer where Customer_ID='"+id+"'";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		String type=null;
		boolean nullflag = false;
		while(rs.next()){
			type = rs.getString(1);
			nullflag=true;
		}
		
		out.println("2 products with the highest order frequency in the same customer type <br />");
		if(nullflag){
			query = "select count(*) as num , OP.Product_code from Ordered_products OP"
					+" where OP.OrderID in("
					+" select OrderID from Orders"
					+" where Customer_Id in (select Customer_ID from Customer where Type='"+type+"'))"
					+" group by OP.Product_code"
					+" order by num desc limit 2";
		}else{
			query = "select count(*) as num , OP.Product_code from Ordered_products OP"
					+" where OP.OrderID in("
					+" select OrderID from Orders"
					+" where Customer_Id in (select Customer_ID from Customer where Type is null))"
					+" group by OP.Product_code"
					+" order by num desc limit 2";
		}
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){
			String s = "Num: "+rs.getString(1) + ", Product_code: " + rs.getString(2);
			out.println(s + "<br />");
			
		}
		out.println("<br />");
		
	}
	else{
		out.println("<br />"
				+"<a href=\"login_success.jsp\">YOU ARE NOT NEW CUSTOMER</a>"
				+"<br />");
	}
	
	
%>
</body>
</html>