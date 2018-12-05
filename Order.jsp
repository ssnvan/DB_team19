<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page language="java" import="java.text.*, java.sql.*, java.util.*" %>
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
    ResultSet rs2;
    
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
    String delivery = request.getParameter("delivery");
	//System.out.println(delivery);
	
	
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
	 String today = formatter.format(new java.util.Date());
	 //System.out.println(today);
	 
	 
	query = "select OrderID from Orders";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	int orderid=0;
	while(rs.next()){
		orderid++;
	}
	System.out.println(orderid);
	String OrderID ="order"+orderid;
	System.out.println(OrderID);
	
    
    
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
		int quantity = rs.getInt(2);
		String code = rs.getString(3);
		int unit=0, inventory=0;
		System.out.println("code : "+code);
		query = "select Unit, Inventory from Product where Product_code='"+code+"'";
		pstmt = conn.prepareStatement(query);
		rs2 = pstmt.executeQuery();
		while(rs2.next()){
			unit = rs2.getInt(1);
			inventory=rs2.getInt(2);
		}
		if(inventory < quantity * unit){
			out.println("There is no sufficient inventory for"+code+"<br/>");
		}else{
			query = "insert into Orders values('"+OrderID+"', '"+id+"', '"+today+"', '"+delivery+"')";
    		stmt = conn.createStatement();
    	    res = stmt.executeUpdate(query);
			query = "insert into Ordered_products values('"+OrderID+"',"+quantity+",'"+code+"')";
			//System.out.println(query);
			stmt = conn.createStatement();
	    	res = stmt.executeUpdate(query);
	    	if(res>0){
	    		query = "delete from Contains where Cart_code='"+cart+"' and Product_code='"+code+"'";
	    		stmt = conn.createStatement();
	    	    res = stmt.executeUpdate(query);
	    		query = "delete from Cart_orders where Cart_code = '"+cart+"' and Product_code='"+code+"'";
	    		res = stmt.executeUpdate(query);		
	    		out.println("Successfully Ordered code "+code+"<br/>");
	    		query = "update Product set Inventory=Inventory-"+quantity*unit+" where Product_code='"+code+"'";
	    		System.out.println(query);
	    		res = stmt.executeUpdate(query);
	    	}else{
	    		out.println("Error Ordering...");
	    	}
		}
	}
	
	
	
%>

</body>
</html>