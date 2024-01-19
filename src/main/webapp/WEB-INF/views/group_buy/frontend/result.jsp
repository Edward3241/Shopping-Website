<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>團購網-新增結果</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">    
	</head>
	<body>
		<!-- menu -->
		<%@include file="../menu.jspf" %>
		
		<div style="padding: 15px">
			<form class="pure-form">
				<fieldset>
					<legend>團購網-新增結果</legend>
					商品: ${ product.productName } ( ${ product.price } 元 / ${ product.unit } )<p />
					數量: ${ quantity } ${ product.unit }<p />	 
				</fieldset>
			</form>
		</div>
		
		 <!-- 使用 CDN 引入 jQuery 和 Bootstrap 的 JavaScript -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>	
		
	</body>
</html>