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
			$("select[name=size]").on("change", changeSpanCPUData);
			//$("input[name=cpu]:first").attr("checked", true);
			//$(".spanCPU:first" ).trigger("click");
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
			//$(".specSelect").hide();
			//$("#spec"+$(this).attr("title")).show();
			ajaxGetSpecsOption(cpuName);
		}

		function ajaxGetSpecsOption(cpuName){
			//Ajax請求->get_size_specs.jsp
			var productId = $("input[name=productId]").val();
			
			$.ajax({
				url:"get_cpu_size.jsp?cpuName=" +cpuName + "&productId="+productId,
				method:"GET"
			}).done(ajaxGetSpecsOptionDone);
		}

		function ajaxGetSpecsOptionDone(result,status,xhr){
			//alert(result);
			
			//將選項套用在$("select[name=spec]")，顯示spec選單
			$("select[name=size]").html(result);
		}

		function changeSpanCPUData(){
			 //alert("changeSpanCPUData :"+$("select[name=size] option:selected").attr("data-stock"));
			 var stock = $("select[name=size] option:selected").attr("data-stock");
			 var listPrice = $("select[name=size] option:selected").attr("data-list-price");
			 var price = $("select[name=size] option:selected").attr("data-price");
			 console.log(stock,listPrice,price);
			 
			//TODO: 修改畫面中指定位置的資料	
			$("input[name=quantity]").attr("max",  stock);
			$("#theListPrice").text(listPrice);
			$("#thePrice").text(price);	
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
			<jsp:param value="產品說明" name="subheader" />
		</jsp:include>
		<%@include file="./subviews/nav.jsp" %>
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
					<div id="product-detail-unitprice">定價:<span id="theListPrice"><%= ((SpecialOffer)p).getListPrice() %></span>元</div>
					<% } %>
					<div id="product-detail-discount">優惠價: <%=p instanceof SpecialOffer ?((SpecialOffer)p).getDiscountString() :"" %> <span id="thePrice"><%= p.getUnitPrice() %></span> 元</div>
					<div id="product-detail-stock">庫存:共<%=p.getStock() %>台 <span id="theCpuStock"></span></div>
					
					<form action="add_to_cart.do" method="POST" >
						<input type="hidden" name="productId" value="<%= p.getId() %>">
						<% if(p.getCpuList() !=null && p.getCpuList().size() >0){%>
						<div class="cpuDiv">
							<label for="cpu">CPU:</label>
							<% for(int i =0 ; i < p.getCpuList().size() ; i++ ){
								Cpu cpu = p.getCpuList().get(i);
							%>
							<label>
							<input type="radio" name="cpu" value="<%= cpu.getCpuName() %>"  required>
							<span 	class="spanCPU" title="<%= cpu.getCpuName() %>" 
									data-photo-src="<%= cpu.getPhotoUrl() %>" 
									data-release-date="<%= cpu.getReleaseDate()%>" 
									data-stock="<%= cpu.getStock()%>" >
									<%= cpu.getCpuName() %>
							</span>
							</label>
							<% }%>
						</div>
						<%}%>
						<!-- 判斷有無規格資料 -->
						<% if( p.getSizeCount()>0 ){ %>
						<div class="sizeDiv">
							<label>尺寸:</label>
							<select name="size"  class="sizeSelect" required>
								<option value="">請先選擇CPU</option>
							</select>
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
			<script>		
				<% if( p.getCpuList().size() == 0 && p.getSizeCount()>0 ){ %>
					//alert("應帶入尺寸資料");
					ajaxGetSpecsOption("");
				<% } %>
			</script>
			
			<% } %>
		</article>
		<%@include file="./subviews/footer.jsp" %>
	</body>

	</html>