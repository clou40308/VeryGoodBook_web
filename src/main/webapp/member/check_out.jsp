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
		if(cart == null|| cart.isEmpty()){
	%>
		<h2>購物車是空的</h2>
	<%}else{ %>
		<form id="checkOutForm">
		<p>
			<label>貨運方式:</label>
				<select name="shippingType" required>
				<option value='SHOP'>門市</option>
				<option value='HOME'>宅配</option>
				<option value='STORE'>超商取貨</option>
			</select>
		</p>
		<p>
			<label>付款方式:</label>
			<select name="paymentType" required>
				<option value='SHOP'>門市付款</option>
				<option value='ATM'>ATM轉帳</option>
				<option value='HOME'>貨到付款</option>
				<option value='STORE'>超商付款</option>
				<option value='CARD'>信用卡</option>
			</select>
		</p>
		<fieldset>
			<legend>收件人</legend>
			<label>姓名:</label><input name="name" placeholder="請輸入真實姓名"><br>
			<label>手機:</label><input name="phone" placeholder="請輸入正確手機號碼"><br>
			<label>Email:</label><input name="email" placeholder="請輸入正確Emial"><br>
			<label>地址:</label><input name="shippingAddress"><br>
		</fieldset>
		</form>	
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
			</tfoot>
		</table>
	<%} %>
	
	</article>
	<%@include file="/subviews/footer.jsp" %>
</body>
</html>