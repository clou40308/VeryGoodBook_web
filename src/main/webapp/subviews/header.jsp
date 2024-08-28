<%@page pageEncoding="UTF-8"%>
<!-- header.jsp start -->
<header>
	<h2>
		<a href="./">NoteBook</a> 
		<sub><%=request.getParameter("subheader") == null ? "筆電商城":request.getParameter("subheader") %></sub>
	</h2>
	<form action="products_list.jsp" method="get">
		<input type="search" name="keyword" required placeholder="請輸入關鍵字">
		<input type="submit" value="查詢">
	</form>
	<hr>
</header>
<!-- header.jsp end -->