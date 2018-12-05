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
	//System.out.println(request.getParameter("order_quantity"));
	String order_quantity = request.getParameter("order_quantity");
	String[] arr = order_quantity.split(",");
    int quantity = Integer.parseInt(arr[1]);
    String code = arr[0];
    //System.out.println(quantity);
    //System.out.println(code);
    String query,cart=null;
    query ="select Cart_code from Cart where Customer_ID=\""+id+"\"";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    while(rs.next()){
    	cart = rs.getString(1);
    }
    query = "select * from Contains where Cart_code='"+cart+"' and Product_code='"+code+"'";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();
    String temp=null;
    if(rs.next()){
    	temp = rs.getString(1);
    }
    System.out.println("temp : "+temp);
    if(temp==null){
	    query = "insert into Contains values('"+cart+"','"+code+"')";
	    stmt = conn.createStatement();
	    res = stmt.executeUpdate(query);
	    System.out.println(query +" : "+res);
	    query = "insert into Cart_orders values('"+cart+"',"+quantity+",'"+code+"')";
	    res= stmt.executeUpdate(query);
    }else{
    	query = "Update Cart_orders set Product_quantity = Product_quantity+"+quantity+" where Cart_code = '"+cart+"' and Product_code = '"+code+"'";
    	//System.out.println(query);
    	stmt = conn.createStatement();
    	res= stmt.executeUpdate(query);
		System.out.println(query +" : "+res);
    }
    if(res>0){
    	out.println("Successfully Inserted into cart!");
    }else{
    	out.println("Error Inserting into the cart...");
    }
%>

</body>
</html>