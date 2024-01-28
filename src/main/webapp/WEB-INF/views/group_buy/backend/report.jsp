<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>團購網-後台報表</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <%@include file="../header.jspf" %>
</head>
<body>
    <!-- menu -->
    <%@include file="../menu.jspf" %>

    <div class="container mt-3">
        <div class="row">
            <!-- 後台報表 -->
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-body">
                        <form class="pure-form">
                            <fieldset>
                                <legend>團購網-後台報表</legend>
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>序號</th>
                                            <th>UserID</th>
                                            <th>帳號</th>
                                            <th>金額</th>
                                            <th>明細</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ reports }" var="report" varStatus="status">
                                            <tr class="${ (status.count % 2) == 0 ? 'table-light' : 'table-dark' }">
                                                <td>${ status.count + 1 }</td>
                                                <td>${ report.userId }</td>
                                                <td>${ report.username }</td>
                                                <td>$${ report.total }</td>
                                                <td>
                                                    <a href="javascript:void(0);"
                                                        onClick="location.href='./report?userId=${ report.userId }';" 
                                                        class="btn btn-secondary">明細</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 結帳明細 -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <form class="pure-form">
                            <fieldset>
                                <legend>團購網- ${ reportUser.userId } ${ reportUser.username } 結帳明細</legend>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr><th>購物車序號</th><th>購物車日期</th><th>購物項目</th></tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${ carts }" var="cart">
                                            <tr>
                                                <td>${ cart.cartId }</td>
                                                <td>
                                                    <fmt:formatDate pattern="yyyy-MM-dd a hh:mm:ss E" value="${ cart.checkoutTime }" />
                                                </td>
                                                <td>
                                                    <table class="table">
                                                        <thead>
                                                            <tr><th>序號</th><th>品名</th><th>價格</th><th>單位</th><th>數量</th><th>小計</th></tr>
                                                        </thead>
                                                        <tbody>
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
                                                        </tbody>
                                                    </table>
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
    
    <!-- 使用 CDN 引入 jQuery 和 Bootstrap 的 JavaScript -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
