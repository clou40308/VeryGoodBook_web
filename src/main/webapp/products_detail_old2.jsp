<%@page import="uuu.vgb.entity.Cpu"%>
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
		<script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
		<script>
		$(document).ready(init);
		
		function init(){
			$(".cpuDiv span").on("click", changeCpuData);
			$("input[name=cpu]:first").attr("checked", true);
			$(".spanCPU:first" ).trigger("click");
		}
		
		function changeCpuData(){
			console.log("change Color Data:" , 
					$(this).attr("title"), $(this).attr("data-photo-src"), $(this).attr("data-release-date"),$(this).attr("data-stock"));
			
			var cpuName = $(this).attr("title");
			var photoUrl = $(this).attr("data-photo-src");
			var releaseDate = $(this).attr("data-release-date");
			var stock = $(this).attr("data-stock");
			
			//修改畫面中指定位置的資料			
			$("#thePhoto").attr("src", photoUrl);
			$("#theReleaseDate").text(releaseDate);
			$("#theCpuStock").text( ", " + cpuName + ": "+ stock + "台");
			$("input[name=quantity]").attr("max", stock);
			
		}
		</script>
		<style>
			#product-detail-area {
				display: flex;
				margin-left: 50px;
			}

			.product-detail-img {
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
			/* HIDE RADIO */
			.cpuDiv input[type=radio] { 
		  		position: absolute;
		  		opacity: 0;
		  		width: 1px;
		  		height: 1px;
			}
		</style>
	</head>

	<body>
		<jsp:include page="./subviews/header.jsp">
			<jsp:param value="產品明細" name="subheader" />
		</jsp:include>
		<article>
			<%
				String productId = request.getParameter("productId");
				Product p = null;
				ProductService pService = new ProductService();
				if(productId != null && (productId=productId.trim()).length()>0){
					p =  pService.getProductById(productId);
				}
			%>
			<% if( p == null){ %>
					<h3>查無此代號的產品(<%=productId %>)</h3>
			<% }else{ %>
			<div id="product-detail-area">
				<img class="product-detail-img " id="thePhoto" src="<%=p.getPhotoUrl() %>"
					alt="">
				<div id="product-detail">
					<h3 id="product-detail-name"><%=p.getName() %></h3>
					<div id="product-detail-releasedate">上架日期:<span id="theReleaseDate"><%=p.getReleaseDate() %></span></div>
					<% if(p instanceof SpecialOffer){ %>
					<div id="product-detail-unitprice">定價:<%=((SpecialOffer)p).getUnitPrice() %></div>
					<% } %>
					<div id="product-detail-discount">優惠價: <%=p instanceof SpecialOffer ?((SpecialOffer)p).getDiscountString() :"" %> <%=p.getUnitPrice() %></div>
					<div id="product-detail-stock">庫存:共<%=p.getStock() %>台 <span id="theCpuStock"></span></div>
					<form action="">
						<input type="hidden" name="priductId" value="<%= p.getId() %>">
						<% if(p.getCpuList() !=null && p.getCpuList().size() >0){%>
						<div class="cpuDiv">
							<label for="cpu">CPU:</label>
							<% for(int i =0 ; i < p.getCpuList().size() ; i++ ){
								Cpu cpu = p.getCpuList().get(i);
							%>
							<label>
							<input type="radio" name="cpu" value="<%= cpu.getCpuName() %>9"  required>
							<span class="spanCPU"	title="<%= cpu.getCpuName() %>" 
									data-photo-src="<%= cpu.getPhotoUrl() %>" 
									data-release-date="<%= cpu.getReleaseDate()%>" 
									data-stock="<%= cpu.getStock()%>" >
									<%= cpu.getCpuName() %>
							</span>
							</label>
							<% }%>
						</div>
						<%}%>
						<div>
							<label>數量:</label>
							<input type="number" name="quantity" required min="1" max="<%= p.getStock() %>">
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