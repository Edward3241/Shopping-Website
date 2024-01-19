<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>團購網-購物車</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">    
		<link rel="stylesheet" href="/GroupBuy/css/group_buy.css">
		 <%@include file="../header.jspf" %>
		
		<script type="text/javascript">
			function updateItem(itemId) {
				var quantity = document.getElementById('item_' + itemId + '_quantity').value;
				window.location.href='./cart/update?itemId=' + itemId + '&quantity=' + quantity;
			}
			
			function deleteItem(itemId) {
				window.location.href='./cart/delete?itemId=' + itemId;
			}
		</script>
	</head>
	<body>
		<!-- menu -->
		<%@include file="../menu.jspf" %>
		
		<div style="padding: 15px">
			<form class="row g-3 needs-validation" novalidate>
				<fieldset>
					<legend>團購網-購物車</legend>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>序號</th>
								<th>品名</th>
								<th>價格</th>
								<th>單位</th>
								<th>數量</th>
								<th>小計</th>
								<th>修改數量</th>
								<th>刪除</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ cart.cartItems }" var="item">
								<tr>
									<td>${ item.itemId }</td>
									<td><a href="./product/details?productId=${item.product.productId}">${ item.product.productName }</a></td>
									<td>${ item.product.price }</td>
									<td>${ item.product.unit }</td>
									<td>
										<input type="number"
											   min="0"
											   onChange="updateItem(${ item.itemId })"	 
											   id="item_${ item.itemId }_quantity" value="${ item.quantity }" />
									</td>
									<td>${ item.product.price * item.quantity }</td>
									<td>
										<a href="javascript:void(0);" onClick="updateItem(${ item.itemId })" class="btn btn-success">Update</a>
									</td>	
									<td>
										<a href="javascript:void(0);" onClick="deleteItem(${ item.itemId })" class="btn btn-danger">Delete</a>
									</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="5" align="right">總計</td>
								<td>${ total }</td>
								<td colspan="2"></td>
							</tr>
						</tbody>
					</table>
					<p />
					<a href="javascript:void(0);" ${ cart.cartItems == '[]' ? 'disabled' : '' } class="btn btn-primary" onclick="location.href='./checkout';">結帳</a>
					<a href="./product/list" class="btn btn-secondary">繼續購物</a>
				</fieldset>
			</form>

			<hr class="separator">
			
			<h2>推薦商品</h2>
            <!-- 推薦商品的展示區域 -->
			<div class="row">
			    <!-- 推薦商品 1 -->
			    <div class="col-md-4">
			        <div class="product text-center">
			            <img src="/GroupBuy/img/coffee.png" alt="Coffee" class="img-fluid">
			            <p class="mb-0">Coffee</p>
			            <p>價格：100元</p>
			        </div>
			    </div>
			
			    <!-- 推薦商品 2 -->
			    <div class="col-md-4">
			        <div class="product text-center">
			            <img src="/GroupBuy/img/honey1.png" alt="Honey" class="img-fluid">
			            <p class="mb-0">Honey</p>
			            <p>價格：150元</p>
			        </div>
			    </div>
			
			    <!-- 推薦商品 3 -->
			    <div class="col-md-4">
			        <div class="product text-center">
			            <img src="/GroupBuy/img/sugar1.png" alt="Sugar" class="img-fluid">
			            <p class="mb-0">Sugar</p>
			            <p>價格：80元</p>
			        </div>
			    </div>
			</div>

    </div>
		
		 <!-- 使用 CDN 引入 jQuery 和 Bootstrap 的 JavaScript -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>	
	<%@include file="../body.jspf" %>	
	</body>
</html>
