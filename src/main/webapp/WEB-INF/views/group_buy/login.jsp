<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Login</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
		<script type="text/javascript">
			function loginBackend() {
				var loginForm = document.getElementById('loginForm');
				loginForm.action = './login_backend'; // 後台登入路徑
				loginForm.submit();
			}
			
			function githubLoginBackend() {
				var loginForm = document.getElementById('loginForm');
				loginForm.action = '../secure/oauth2/login/github'; // Github 第三方登入路徑
				loginForm.submit();
			}
		</script>
	</head>
	<body style="padding: 15px">
		<div class="container">
			<div class="row justify-content-center align-items-center min-vh-100">
				<form id="loginForm" method="post" action="./login" class="col-12 col-sm-8 col-md-4 col-lg-3">
					<fieldset>
						<legend class="text-center">Cerousell購物網 登入</legend>
						<div class="mb-3">
							<label for="username" class="form-label">🚧 帳號:</label>
							<input type="text" class="form-control" id="username" name="username" placeholder="請輸入帳號" value="user123" required />
						</div>
						<div class="mb-3">
							<label for="password" class="form-label">🔑 密碼:</label>
							<input type="password" class="form-control" id="password" name="password" placeholder="請輸入密碼" value="pass123" required />
						</div>
						<div class="mb-3">
							<label for="code" class="form-label">🔐 驗證:</label>
							<input type="text" class="form-control" id="code" name="code" />
							<img src="./getcode" alt="驗證碼" class="mt-2" />
						</div>
						<div class="mb-3">
							<button type="submit" class="btn btn-dark w-100">前台登入</button>
						</div>
						<div class="mb-3">
							<button type="button" class="btn btn-dark w-100" onclick="githubLoginBackend()">🐈Github 登入</button>
						</div>
						<div class="mb-3">
							<button type="button" class="btn btn-dark w-100" onclick="loginBackend()">後台登入</button>
						</div>
					</fieldset>
					<div class="text-center" style="color: red">${ loginMessage }</div>
				</form>
			</div>
		</div>
		
		<!-- 使用 CDN 引入 jQuery 和 Bootstrap 的 JavaScript -->
    	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	</body>
</html>
