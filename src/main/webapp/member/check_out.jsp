<%@page import="uuu.vgb.entity.ShippingType"%>
<%@page import="uuu.vgb.entity.CartItem"%>
<%@page import="java.util.Set"%>
<%@page import="uuu.vgb.entity.ShoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>非常好書 結帳</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/vgb.css">
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
				integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>		
		<script>
			function copyMemberData(){
				//alert("copyMemberData");
				
				$("input[name=name]").val("${sessionScope.member.getName()}");
				$("input[name=email]").val("${sessionScope.member.getEmail()}");
				$("input[name=phone]").val("${sessionScope.member.getPhone()}");
				$("input[name=shippingAddress]").val("${sessionScope.member.getAddress()}");
			}
			
			function calculateFee(){
				alert("calculateFee");
				var amount = Number($("#totalAmount").text());
				var shippingFee=0;
				if($("select[name=shippingType] option:selected").val()!=''){
					shippingFee = Number($("select[name=shippingType] option:selected").attr("data-fee"));
				}
				alert(amount + shippingFee);
				$("#totalAmountWithFee").text(amount + shippingFee);
				
			}
		</script>
		
		<style>
			.h2Msg{width: 85%;margin: auto;}
			#checkOutForm{width: 85%;margin: auto;padding: 1em}
			#shippingTypeSpan, #paymentTypeSpan{float:left;width:30%}
			
			#checkOutForm fieldset{width: 100%;margin: 3em auto 0 auto;}
			#checkOutForm fieldset label{display:inline-block;min-width:3.5em;vertical-align: text-top;}
			#checkOutForm fieldset input:not([type=button]){width:75%;min-width:20ex}
			input[name=shippingAddress]{vertical-align: bottom;}
			
			details {width: 85%;margin: auto;}
			#cartDetails{
			  font-family:  Helvetica, Arial, sans-serif;
			  border-collapse: collapse;
			  width: 100%;
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
			<jsp:param value="結帳" name="subheader"/>
		</jsp:include>
		<%@include file="/subviews/nav.jsp" %>
		<article >
		
<%-- 			<p>購物車內容: ${sessionScope.cart}</p> --%>
			<%
			
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
				if(cart==null || cart.isEmpty()){
			%>
				<h2 class='h2Msg'>購物車是空的，無法結帳!請先至[賣場]選購!</h2>
			<%} else{%>				
				<form id="checkOutForm">
					<p>
						<span id="shippingTypeSpan">
							<label>貨運方式:</label>
							<select name="shippingType" required onchange="calculateFee()">
								<option value=''>請選擇...</option>
								<% for(int i=0;i<ShippingType.values().length;i++) {%>
								<option value='<%= ShippingType.values()[i].name()%>' data-fee="<%= ShippingType.values()[i].getFee()%>">
									<%= ShippingType.values()[i]%>									
								</option>
								<% } %>
							</select>
						</span>
						<span id="paymentTypeSpan">
							<label>付款方式:</label>
							<select name="paymentType" required>
								<option value=''>請選擇...</option>
								<option value='SHOP'>門市付款</option>
								<option value='ATM'>ATM轉帳</option>
								<option value='HOME'>貨到付款, 80元</option>
								<option value='STORE'>超商付款</option>
								<option value='CARD'>信用卡</option>
							</select>
						</span>
						<input type="submit" value="送出訂單" >
					</p>
					
					<fieldset>
						<legend>收件人<input type="button" value="同訂購人" onclick="copyMemberData()"></legend>
						<div><label>姓名:</label><input name="name" placeholder="請輸入真實姓名" required></div>
						<div><label>手機:</label><input type="tel" name="phone" placeholder="請輸入正確手機號碼" required></div>
						<div><label>Email:</label><input type="email" name="email" placeholder="請輸入正確Emial" required></div>
						<div><label>地址:</label><input name="shippingAddress" required></div>
					</fieldset>
				</form>
				<details>
					<summary>共<%= cart.getTotalQuantity() %>件, 總金額: <span id="totalAmountWithFee"><%= cart.getTotalAmount() %></span>元 (點選即可看到明細)</summary>
					<table id="cartDetails">
						<caption>購物明細</caption>					
						<thead>
							<tr>
								<th>編號</th><th>產品名稱 顏色 規格</th>
								<th>價格</th>
								<th>數量</th><th>小計</th>
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
									<div><span class='listPrice'><%= item.getListPrice() %></span>元</div> 
									<div><%= item.getDiscountString() %></div> 
									<span class='price'><%= item.getPrice() %></span>元
								</td>						
								<td><%= cart.getQuantity(item) %></td>
								<td><%= cart.getAmount(item) %></td>							
							</tr>
							<% } %>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">共<%= cart.size() %>項</td>
								<td colspan="1"><%= cart.getTotalQuantity() %>件</td>
								<td colspan="2">總金額: <span id="totalAmount"><%= cart.getTotalAmount() %></span>元</td>
							</tr>						
						</tfoot>
					</table>
				</details>		
			<%} %>
		</article>
		<%@include file="/subviews/footer.jsp" %>
	</body>
</html>