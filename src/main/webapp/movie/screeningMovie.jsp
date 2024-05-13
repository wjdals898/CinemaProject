<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체영화</title>
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
<script>
	$(function(){
		$("#reservationBtn").on("click", f_reservationBtn_click);
	});
	
	function f_reservationBtn_click(){
		var movieId = $(this).siblings(".movieId").val();
		location.href="../reservation/theater?movieId="+movieId;
	}
</script>
</head>
<body>
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<div class="title">
				<h3>상영작</h3>
				<p>${fn:length(movielist)}건</p>
			</div>
			<div class="sect-movie justify-content-center">
				<c:forEach items="${movielist}" var="movie">
					<div class="movieOuterDiv">
						<div class="movieDiv mb-4">
							<img alt="${movie.title}" src="${initParam['path']}/static/images/movie/${movie.poster}">
							<p class="movieTitle">${movie.title}</p>
							<p class="movieSub">
								<span>예매율 ${movie.theaters_count}%</span>
								<span><i class="fa-regular fa-heart"></i></span>
							</p>
							<button type="button" class="btn" id="reservationBtn">예매하기</button>
							<input type="hidden" class="movieId" value="${movie.id}">
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<jsp:include page="${contextParam['path']}/common/pagination.jsp"></jsp:include>
	</section>

	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
</body>
</html>