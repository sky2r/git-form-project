<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	String orderDate = request.getParameter("orderDate");
	System.out.println(orderDate);
	Class.forName("");
	Connection conn = DriverManger.getConnection("","root","java0000");
	// 1. select amount from orders where order_date=?
	PreparedStatement stmt = conn.prepareStatement("select amount from orders where order_date=?");	
	stmt.setString(1, orderDate);
	ResultSet rs = stmt.executeQuery();
	int amount = 0;
	if(rs.next()) {
		amount = rs.getInt("amount");
	} else {
		out.print("공연이 없는 날짜입니다");
	}
	// 2. 1의 결과가 0이면 ... 매진!
	// 3. 1의 결과가 0보다 크면
	if(amount == 0) {
		out.print("매진!");
	} else {
		PreparedStatement stmt2 = conn.prepareStatement("update orders set amount = amount-1 where order_date=?");
		stmt2.setString(1, orderDate);
		stmt2.executeUpdate();
		out.print("주문성공!");
	}
	
	// update orders set amount = amount-1 where order_date=?
%>

</body>
</html>