<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShoppingmallX - Increase item inventory</title>
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
        System.out.println("connected");
    }catch(Exception e){
        System.out.println(e.getMessage());
    }
    String Product_code = request.getParameter("product_increase");
    String Product_num = request.getParameter("product_increase_val");
	String query = "update Product set Inventory=Inventory+"+Product_num+"*unit where Product_code = \""+Product_code+"\"";
	//System.out.println(query);
	try{
		stmt = conn.createStatement();
		int res = stmt.executeUpdate(query);
		query ="select Product_name, Unit from Product where Product_code = \""+Product_code+"\"";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		if(res >0){
			while(rs.next()){
				out.println("Product "+rs.getString(1) +" Increased inventory by "+rs.getInt(2)*Integer.parseInt(Product_num)+" ("+Integer.parseInt(Product_num)+" Units)");
			}
		}
		else{
				out.println("Error increasing inventory...");
		}
	}catch(NullPointerException e){
		out.println(e.getMessage());
	}
%>

</body>
</html>