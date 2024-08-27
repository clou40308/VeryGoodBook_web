<%@page import="java.time.LocalDate"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>NoteBook</title>
	<link rel="stylesheet" href="style/vgb.css"  type="text/css">
</head>

<body>
<header>
	<h2>
		NoteBook <sub>首頁</sub>
	</h2>
	<hr>
</header>
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
<article>
	<img src="images/Twitter logo.png">
</article>
<footer>
      <hr>
      <h3>NoteBook&copy;2024-08~<%=LocalDate.now().getYear()%>-<%=LocalDate.now().getMonthValue()%></h3>
</footer>
</body>

</html>