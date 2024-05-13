<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/movie.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/pagination.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${initParam['path']}/static/js/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/4e5b2f86bb.js" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<div class="title">
				<h3>마이페이지</h3>
			</div>
		</div>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
</body>
</html>