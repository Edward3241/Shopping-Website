<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>團購網-User Profile</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">    
		
		<%@include file="../header.jspf" %>	
	</head>
	<body>
	
		<!-- menu -->
		<%@include file="../menu.jspf" %>
		
		<div style="padding: 15px">
			<form class="row g-3 needs-validation" method="post" action="./change_password" novalidate>
				<fieldset>
					<legend>團購網-使用者密碼變更</legend>
					<div class="col-md-4">
						<label for="oldPassword" class="form-label">舊密碼:</label>
						<input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
					</div>
					<div class="col-md-4">
						<label for="newPassword" class="form-label">新密碼:</label>
						<input type="password" class="form-control" id="newPassword" name="newPassword" required>
					</div>
					<div class="col-md-4">
						<label for="confirmNewPassword" class="form-label">確認新密碼:</label>
						<input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
					</div>
					<div class="col-12">
						<button type="submit" class="btn btn-primary">密碼變更</button>
					</div>
					<div class="col-12">
						<div style="color: red">${ errorMessage }</div>
					</div>
				</fieldset>
			</form>
			
			<hr class="separator">
			
			<!-- 訂單查詢連結 -->
			<a href="./orders" class="btn btn-secondary">訂單查詢</a>
			
			<!-- 導出按鈕 -->
			<button type="button" class="btn btn-success" onclick="exportOrders()">導出訂單</button>

			<!-- 訂單查詢結果表格 -->	
			<h2>訂單查詢結果</h2>
			<div style="padding: 15px">
			    <table class="table table-bordered">
			        <thead class="thead-light">
			            <tr>
			                <th scope="col">項目</th>
			                <th scope="col">產品名稱</th>
			                <th scope="col">價格</th>
			                <th scope="col">單位</th>
			                <th scope="col">數量</th>
			                <th scope="col">總價</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach items="${ checkoutCarts }" var="cart">
			                <c:forEach items="${ cart.cartItems }" var="item">
			                    <tr>
			                        <td>${ item.itemId }</td>
			                        <td>${ item.product.productName }</td>
			                        <td>${ item.product.price }</td>
			                        <td>${ item.product.unit }</td>
			                        <td>${ item.quantity }</td>
			                        <td>${ item.product.price * item.quantity }</td>
			                    </tr>
			                </c:forEach>
			            </c:forEach>
			        </tbody>
			    </table>
			</div>

			<!-- 使用 CDN 引入 jQuery 和 Bootstrap 的 JavaScript -->
			<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

			<!-- 導出功能 -->
			<script>
				function exportOrders() {
					// 此處填入導出訂單的 JavaScript 邏輯
					// ...
				}
			</script>
		</div>
	</body>
</html>
