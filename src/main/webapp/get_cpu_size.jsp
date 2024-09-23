<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Size"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8" %>
   <!-- ajax get_cpu_size.jsp -->
   <%
   		String cpuName =request.getParameter("cpuName");
   		String productId =request.getParameter("productId");
   		List<Size> list = null;
   		ProductService pService = new ProductService();
   		if(productId != null && cpuName!= null){
   			//list = pService.getProductSizeByIdAndCpuName("8", "Ultra 7");
   			list = pService.getProductSizeByIdAndCpuName(productId, cpuName);
   		}
   		
   		if( list != null && list.size()>0){
   %>
	<option value="">請選擇尺寸...</option>
		<%for(int i = 0;i < list.size(); i++){
			Size size = list.get(i);
		%>
		<option value="<%=size.getSizeName() %>"
		 data-stock="<%=size.getStock() %>" 
		 data-list-price ="<%=size.getPrice()%>"
		  data-price="<%=size.getUnitPrice()%>">
		  <%=size.getSizeName() %>,<%=size.getStock() %>
		  </option>
		<%} %>
	<%}else{ %>
	<option value="">無尺寸</option>
	<%} %>
   <!-- ajax get_cpu_size.jsp -->