<%@page import="uuu.vgb.entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@page import="uuu.vgb.entity.ShoppingCart"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>購物車</title>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/style/vgb.css"  type="text/css">
	<script>

	</script>
	<style>
            #cartDetails {
				font-family: Arial, Helvetica, sans-serif;
				border-collapse: collapse;
				background-color: burlywood;
				width: 100%;
				margin: auto;
			}

			#cartDetails td,
			#cartDetails th {
				border: 1px solid #ddd;
				padding: 8px;
			}

			#cartDetails tr:nth-child(even) {
				background-color: #f2f2f2;
			}

			#cartDetails tr:hover {
				background-color: #ddd;
			}

			#cartDetails caption {
				padding-top: 12px;
				padding-bottom: 12px;
				text-align: center;
				background-color: #04AA6D;
				color: white;
				font-size: 20px;
			}

			.listPrice{
				text-decoration: line-through;
				font-size: smaller;
				color: gray;
			}
	</style>
</head>
<body>
	<jsp:include page="/subviews/header.jsp">
	  <jsp:param value="購物車" name="subheader" />
	</jsp:include>

	<%@include file="/subviews/nav.jsp" %>
	
	<article>
	
	<%
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
		if(cart==null || cart.isEmpty()){
	%>
		<h2>購物車是空的</h2>
	<%}else{ %>
	<%if(cart.getMember() == null) cart.setMember(member); %>
	<form action="update_cart.do" method="POST">
		<table id="cartDetails">
			<caption>購物明細</caption>
			<thead>
				<tr>
					<th>編號</th>
					<th>產品名稱 cpu 尺寸</th>
					<th>定價 折扣 售價</th>
					<th>數量</th>
					<th>小計</th>
					<th>刪除</th>
				</tr>
			</thead>
			<tbody>
				<%
				    Set<CartItem> itemSet = cart.getCartItemsSet();
					for(CartItem item : itemSet){
				%>
				<tr>
					<td><%=item.getProductId()%></td>
					<td>
						<img style="width: 60px;"  src="<%=item.getPhotoUrl()%>" alt="">
						<%=item.getProductName()%>
					</td>
					<td>
						<span class="listPrice"><%=item.getListPrice()%></span>元 
						 <div><%=item.getDiscountString()%></div>	
						 <span id="price"><%=item.getPrice()%></span>元
					</td>
					<td><input type="number" name="quantity<%=item.hashCode() %>" value="<%=cart.getQuantity(item)%>" max="<%=item.getStock() %>" required></td>
					<td><%=cart.getAmount(item)%></td>
					<td><input type="checkbox" name="delete<%=item.hashCode() %>"></td>
				</tr>
				<%} %>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3">共<%= cart.size() %>項</td>
					<td colspan="1"><%= cart.getTotalQuantity() %>台</td>
					<td colspan="2">總金額: <%= cart.getTotalAmount() %>元</td>
				</tr>
				<tr>
					<td colspan="4"><input type="submit" value="修改購物車"></td>
					<td colspan="2"><input type="button" value="我要結帳" onclick="location.href='check_out.jsp';"></td>
				</tr>
			</tfoot>
		</table>
	</form>
	<%} %>
	
	</article>
	<%@include file="/subviews/footer.jsp" %>
</body>
</html>