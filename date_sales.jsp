<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Date Sales</title>
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


<%
	String query="";
	String date = request.getParameter("date");
	int total=0;
	if(date==""){
		out.println("Please give input...");
	}else{
		query = "select O.Order_Date,OP.Product_code, OP.Product_quantity, P.Price"
				 +" from Orders O, Ordered_products OP, Product P"
				 +" where O.OrderID = OP.OrderID and O.Order_Date=\""+date+"\""
				 +" and P.Product_code = OP.Product_code";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()){
			total += rs.getInt(3)*rs.getInt(4);
		}
		if(total==0){
			out.println("There is no Sales in "+date);
		}else{
			out.println("Total Sales of "+date+" : "+total);
		}
	}
%>
</body>
</html>