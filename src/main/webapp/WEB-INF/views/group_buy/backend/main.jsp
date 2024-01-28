<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sp" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>團購網-後臺商品維護</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/GroupBuy/css/group_buy.css">
    <%@include file="../header.jspf" %>
    <script type="text/javascript">
        function changeLaunch(productId, isLaunch) {
            location.href = './update_product_launch?productId=' + productId + '&isLaunch=' + isLaunch;
        }
    </script>
</head>
<body>
    <!-- menu -->
    <%@include file="../menu.jspf" %>

    <div class="container mt-3">
        <div class="row">
            <!-- 商品新增 -->
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-body">
                        <sp:form modelAttribute="product" method="post" action="./addProduct">
                            <fieldset>
                                <legend>團購網-商品新增</legend>
                                <div class="mb-3">
                                    <label for="productName" class="form-label">品名:</label>
                                    <sp:input path="productName" id="productName" class="form-control" value="水果茶" />
                                </div>
                                <div class="mb-3">
                                    <label for="price" class="form-label">價格:</label>
                                    <sp:input type="number" path="price" id="price" class="form-control" value="40" />
                                </div>
                                <div class="mb-3">
                                    <label for="unit" class="form-label">單位:</label>
                                    <sp:select path="unit" id="unit" class="form-select" items="${ units }" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-check-label">
                                        上架: <sp:checkbox path="isLaunch" class="form-check-input" />
                                    </label>
                                </div>
                                <div class="mb-3">
                                    <label for="csrf_token" class="form-label">CSRF token:</label>
                                    <input type="text" id="csrf_token" name="csrf_token" class="form-control" value="${ csrf_token }">
                                </div>
                                <button type="submit" class="btn btn-primary">新增</button>
                            </fieldset>
                        </sp:form>
                    </div>
                </div>
            </div>

            <!-- 後臺商品維護 -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <form>
                            <fieldset>
                                <legend>團購網-後臺商品維護</legend>
                                <table class="table table-bordered">
                                    <thead class="table-light">
                                        <tr><th>序號</th><th>ID</th><th>品名</th><th>價格</th><th>單位</th><th>上架</th></tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ products }" var="product" varStatus="status">
                                            <tr>
                                                <td>${ status.count+1 }</td>
                                                <td>${ product.productId }</td>
                                                <td>${ product.productName }</td>
                                                <td>${ product.price }</td>
                                                <td>${ product.unit }</td>
                                                <td>
                                                    <input 
                                                        onClick="changeLaunch(${ product.productId }, this.checked)"
                                                        type="checkbox" ${ (product.isLaunch) ? 'checked' : '' } 
                                                        value="true"> 上架
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <p />
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- slider js-->    
    <%@include file="../body.jspf" %>
    
</body>
</html>
