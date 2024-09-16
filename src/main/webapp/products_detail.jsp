<%@page import="uuu.vgb.entity.SpecialOffer"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="java.security.spec.PSSParameterSpec"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>產品明細</title>
		<link rel="stylesheet" href="./style/vgb.css" type="text/css">
		<script>

		</script>
		<style>
			#product-detail-area {
				display: flex;
				margin-left: 50px;
			}

			#product-detail-img {
				height: 300px;
				width: 300px;
				margin-left: 100px;
			}

			#product-detail {
				margin-left: 50px;
			}

			#product-detail-name {
				color: blue;
			}

			#product-desc {
				margin-left: 50px;
			}
		</style>
	</head>

	<body>
		<jsp:include page="./subviews/header.jsp">
			<jsp:param value="Product Detail" name="subheader" />
		</jsp:include>
		<article>
			<%
				String priductId =request.getParameter("priductId");
				Product p = null;
				ProductService pService = new ProductService();
				if(priductId != null && (priductId=priductId.trim()).length()>0){
					p =  pService.getProductById(priductId);
				}
			%>
			<% if( p == null){ %>
					<h3>查無此代號的產品(<%=priductId %>)</h3>
			<% }else{ %>
			<div id="product-detail-area">
				<img id="product-detail-img" src="<%=p.getPhotoUrl() %>"
					alt="">
				<div id="product-detail">
					<h3 id="product-detail-name"><%=p.getName() %></h3>
					<div id="product-detail-releasedate">上架日期:<%=p.getReleaseDate() %></div>
					<% if(p instanceof SpecialOffer){ %>
					<div id="product-detail-unitprice">定價:<%=((SpecialOffer)p).getUnitPrice() %></div>
					<% } %>
					<div id="product-detail-discount">優惠價: <%=p instanceof SpecialOffer ?((SpecialOffer)p).getDiscountString() :"" %> <%=p.getUnitPrice() %></div>
					<div id="product-detail-stock">庫存: <%=p.getStock() %></div>
					<form action="">
						<input type="hidden" name="priductId" value="1">
						<div>
							<label>數量:</label>
							<input type="number" name="quantity" required min="1" max="3">
						</div>
						<div>
							<input type="submit" value="加入購物車">
						</div>
					</form>
				</div>
			</div>
			<div id="product-desc">
				<hr>
				<p><%=p.getDescription() %></p>
			</div>
			<% } %>
		</article>
		<%@include file="./subviews/footer.jsp" %>
	</body>

	</html>