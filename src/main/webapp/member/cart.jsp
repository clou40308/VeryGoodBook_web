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
				<tr>
					<td>1</td>
					<td>
						<img style="width: 60px;"  src="https://img.pchome.com.tw/cs/items/DHAG7ZA900HO6E7/000001_1723721517.jpg" alt="">
						HP 惠普_ Pavilion 文書效能筆電銀色(R5-8640U/16G/512G SSD/W11/bg0051AU) cpu 尺寸
					</td>
					<td>
						<span class="listPrice">45900</span>元 
						 <div>9折</div>	
						 <span id="price">45900</span>元
					</td>
					<td>1</td>
					<td>小計</td>
					<td>不</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3">共1項</td>
					<td colspan="1">1台</td>
					<td colspan="2">總金額:1000元</td>
				</tr>
			</tfoot>
		</table>
	</article>
	<%@include file="/subviews/footer.jsp" %>
</body>
</html>