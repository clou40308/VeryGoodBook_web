<%@page import="uuu.vgb.entity.SpecialOffer"%>
<%@page import="uuu.vgb.entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@page import="uuu.vgb.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>非常好書 購物車</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/vgb.css">
		<script>
		
		</script>
		
		<style>
			.h2Msg{width: 85%;margin: auto;}
			#cartDetails {
			  font-family:  Helvetica, Arial, sans-serif;
			  border-collapse: collapse;
			  width: 85%;margin: auto;
			}
			
			#cartDetails td, #cartDetails th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}
			
			#cartDetails tr:nth-child(even){background-color: #f2f2f2;}
			
			#cartDetails tr:hover {background-color: #ddd;}
			
			#cartDetails caption {
			  padding-top: 12px;
			  padding-bottom: 12px;		  
			  background-color: #04AA6D;
			  color: white;
			}
			
			#cartDetails tbody input[type=number]{width:5ex}
			#cartDetails tfoot{text-align: right}
			.productName{font-weight: bold}
			.listPrice{text-decoration: line-through;font-size: smaller;color:gray}
			.price{font-size: larger;color:blue}
		</style>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="購物車" name="subheader"/>
		</jsp:include>
		<%@include file="/subviews/nav.jsp" %>
		<article >
		
<%-- 			<p>購物車內容: ${sessionScope.cart}</p> --%>
			
			<%
			
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
				if(cart==null || cart.isEmpty()){
			%>
				<h2 class='h2Msg'>購物車是空的</h2>
			<%} else{%>			
			<% //cart.setMember((Customer)session.getAttribute("member")); %>
			${sessionScope.cart.setMember(sessionScope.member)}
			
			<form action="update_cart.do" method="POST">
				<table id="cartDetails">
					<caption>購物明細</caption>					
					<thead>
						<tr>
							<th>編號</th><th>產品名稱 顏色 規格</th>
							<th>價格</th>
							<th>數量</th><th>小計</th><th>刪除?</th>
						</tr>
					</thead>
					<tbody>
						<% 	Set<CartItem> itemSet = cart.getCartItemsSet();					
							for(CartItem item:itemSet){						
						%>
						<tr>
							<td><%= item.getProductId() %></td>
							<td>
								<a href="../products_detail.jsp?productId=<%=item.getProductId() %>">
									<img style="width:40px;float:left;" src="<%= item.getPhotoUrl() %>">
									<div class='productName'><%= item.getProductName() %></div>
								</a>
								<%= item.getCpuName() %> <%= item.getSizeName() %> 庫存<%= item.getStock() %>件
							</td>
							<td>
								<% if(item.getTheProduct() instanceof SpecialOffer) {%>
									<div><span class='listPrice'><%= item.getListPrice() %></span>元</div>
								<% } %> 
								<div><%= item.getDiscountString() %></div>
								<span class='price'><%= item.getPrice() %></span>元
							</td>						
							<td><input type="number" name="quantity<%=item.hashCode() %>" max="<%= item.getStock() %>" value="<%= cart.getQuantity(item) %>" required>  </td>
							<td><%= cart.getAmount(item) %></td>
							<td><input type="checkbox" name="delete<%=item.hashCode() %>"></td>
						</tr>
						<% } %>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="3">共<%= cart.size() %>項</td>
							<td colspan="1"><%= cart.getTotalQuantity() %>件</td>
							<td colspan="2">總金額: <%= cart.getTotalAmount() %>元</td>
						</tr>
						<tr>
							<td colspan="4"><input type="submit" value="修改購物車"></td>
							<td colspan="2"><button value="checkOut" name="submit">我要結帳</button></td>
						</tr>
					</tfoot>
				</table>
			</form>
			<%} %>
		</article>
		<%@include file="/subviews/footer.jsp" %>
	</body>
</html>