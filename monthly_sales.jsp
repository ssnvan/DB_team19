<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Monthly Sales</title>
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
	if(request.getParameter("year")==""&&request.getParameter("month")==""){
		out.println("Please give input...");
	}else if(request.getParameter("year")==""){
		out.println("Please input year...");
	}else if(request.getParameter("month")==""){
		out.println("Please input month...");
	}else{
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		int monthplus = Integer.parseInt(month)+1;
		String start = year+"-"+month+"-01";
		String end = year+"-"+monthplus+"-01";
		int total=0;
		
		query = "select O.Order_Date,OP.Product_code, OP.Product_quantity, P.Price"
				+" from Orders O, Ordered_products OP, Product P";
		query += " where O.OrderID = OP.OrderID and O.Order_Date>=\""+start+ "\" and O.Order_Date <\""+end+"\"";
		query += " and P.Product_code = OP.Product_code";
		try{
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			while(rs.next()){
				total += rs.getInt(3)*rs.getInt(4);
			}
			if(total==0){
				out.println("There is no Sales in "+year+"-"+month);
			}else{
				out.println("Total Sales of "+year+"-"+month+" : "+total);
			}
		}catch(NullPointerException e){
			out.println(e.getMessage());
		}catch(com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException e){
			out.println(e.getMessage());
		}
		
	}
%>
</body>
</html>