<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>團購網首頁</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
		<%@include file="../header.jspf" %>	
	</head>
	<body>
		<!-- menu -->
		<%@include file="../menu.jspf" %>
		<div style="padding: 15px">
			<form method="post" action="./addToCart" class="row g-3 needs-validation" novalidate>
				<fieldset>
					<legend>團購網首頁</legend>
					<div class="col-md-4">
						<label for="productId" class="form-label">商品:</label>
						<select id="productId" name="productId" class="form-select" required>
							<c:forEach items="${ products }" var="product" >
								<option value="${ product.productId }">
									${ product.productName }
									( ${ product.price } 元 / ${ product.unit } )
								</option>
							</c:forEach>
						</select>
						<div class="invalid-feedback">請選擇一個商品</div>
					</div>
					<div class="col-md-4">
						<label for="quantity" class="form-label">數量:</label>
						<input type="number" id="quantity" name="quantity" value="5" class="form-control" required>
						<div class="invalid-feedback">請輸入數量</div>
					</div>
					<div class="col-12">
						<button type="submit" ${ (empty products)?'disabled':'' } class="btn btn-primary">新增</button>
					</div>
				</fieldset>
			</form>
		</div>		
		
		<hr class="separator">
		
		<!-- 使用 CDN 引入 jQuery 和 Bootstrap 的 JavaScript -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>		
		<%@include file="../body.jspf" %>
	</body>
</html>
