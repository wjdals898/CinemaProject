<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/login.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
<script src="${initParam['path']}/static/js/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/4e5b2f86bb.js" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<h3>로그인</h3>
			<div class="login-form">
				<div class="username-group">
					<i class="fa-solid fa-user"></i>
					<input type="text" class="form-control" placeholder="아이디" name="username">
				</div>
				<div class="password-group">
					<i class="fa-solid fa-lock"></i>
					<input type="password" class="form-control" placeholder="비밀번호" name="password">
				</div>
				<div class="sub-option">
					<div class="auto-login">
					  <input class="form-check-input" type="checkbox" id="auto_login" name="auto_login" value="something">
					  <label for="auto_login" class="form-check-label">자동로그인</label>
					</div>
					<a class="find-auth" href="">아이디/비밀번호 찾기</a>
				</div>
				<button type="button" class="btn" id="loginBtn">로그인</button>
				<div class="social">
					<hr class="social-line"/>
					<p class="social-label">소셜로그인</p>
					<hr class="social-line"/>
				</div>
				<button type="button" class="btn" id="naverBtn"></button>
				<button type="button" class="btn" id="kakaoBtn"></button>
			</div>
		</div>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
</body>
</html>