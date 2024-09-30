<%@page import="uuu.vgb.entity.ShoppingCart"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8" %>
<!-- nav.jsp start -->
<nav>
    <%
        Customer member = (Customer)session.getAttribute("member");  
     %>
	<a href="<%=request.getContextPath() %>/products_list.jsp">買筆電</a>|
	<% if(member==null){ //尚未登入%>
	<a href="<%=request.getContextPath() %>/login.jsp">登入</a> |
	<a href="<%=request.getContextPath() %>/register.jsp">註冊</a> |
	<%}else{ //已經登入  %>
	<a href="<%=request.getContextPath() %>/logout.do">登出</a> |
	<a href="<%=request.getContextPath() %>/member/update.jsp">修改會員</a> |
	<%} %>
	<a class="cartA" href="<%=request.getContextPath() %>/member/cart.jsp">
		<img id="cart-icon"  src="<%=request.getContextPath() %>/images/cart_icon.png" alt="">
		(${sessionScope.cart.getTotalQuantity()})
	</a>
	<span class="welcomeSpan"><%=member!=null?member.getName():""%>您好!</span>
	<hr>
</nav>
<!-- nav.jsp end -->