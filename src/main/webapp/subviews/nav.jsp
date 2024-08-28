<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8" %>
<!-- nav.jsp start -->
<nav>
    <%
        Customer member = (Customer)session.getAttribute("member");  
     %>
	<a href="products_list.jsp">買筆電</a>|
	<% if(member==null){ //尚未登入%>
	<a href="/vgb/login.jsp">登入</a> |
	<a href="register.jsp">註冊</a> |
	<%}else{ //已經登入  %>
	<a href="/vgb/logout.do">登出</a> |
	<a href="#">修改會員</a> |
	<%} %>
	<span class="welcomeSpan"><%=member!=null?member.getName():""%>您好!</span>
	<hr>
</nav>
<!-- nav.jsp end -->