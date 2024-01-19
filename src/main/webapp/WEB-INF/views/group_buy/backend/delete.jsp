<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sp" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>團購網-後臺商品維護</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" crossorigin="anonymous">
		<link rel="stylesheet" href="/GroupBuy/css/group_buy.css">
		<%@include file="../header.jspf" %>
		
		<script type="text/javascript">
			function changeLaunch(productId, isLaunch) {
				//console.log(productId, isLaunch);
				location.href = './update_product_launch?productId=' + productId + '&isLaunch=' + isLaunch;
			}
		</script>
	</head>
	<body>
		<!-- menu -->
		<%@include file="../menu.jspf" %>
		
		<div style="padding: 15px">
			<form method="post" action="./deleteToCart" class="row g-3 needs-validation" novalidate>
				<fieldset>
					<legend>團購網 - 商品刪除</legend>
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
					<div class="col-12">
						<button type="submit" ${ (empty products)?'disabled':'' } class="btn btn-primary">刪除</button>
					</div>
				</fieldset>
			</form>
		</div>

		<!-- slider js-->	
		<%@include file="../body.jspf" %>
	</body>
</html>
