<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>團購網-團購商品新增結果</title>
		<%@include file="../header.jspf" %>	
	</head>
	<body>
		<!-- menu -->
		<%@include file="../menu.jspf" %>
		
		<div style="padding: 15px">
			<form class="pure-form">
				<fieldset>
					<legend>團購網-團購商品新增結果</legend>
					品名: ${ product.productName }<p />
					價格: ${ product.price }<p />
					單位: ${ product.unit }
					上架: ${ (product.isLaunch) ? 'V' : 'X' }
					<p />	 
				</fieldset>
			</form>
		</div>
	
	<!-- slider js-->
    <%@include file="../body.jspf" %>
		
	</body>
</html>