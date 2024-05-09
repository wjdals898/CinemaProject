<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화선택</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/reservation.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/selectMovie.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${initParam['path']}/static/js/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/4e5b2f86bb.js" crossorigin="anonymous"></script>
<script>
	$(function(){
		$(".movieDiv").on("click", f_movie_select);
		$("#initBtn").on("click", f_initBtn_click);
		$("#nextBtn").on("click", f_nextBtn_click);
	});
	
	function f_nextBtn_click() {
		var selectMovieId = $("#selectMovieId").val();
		console.log("selectMovieId="+selectMovieId);
		location.href="theater?movieId="+selectMovieId;
	}
	
	function f_initBtn_click() {
		var beforeClickCss = {"background-color": "white", "color": "black"};
		$(".movieDiv").css(beforeClickCss);
		$("#nextBtn").attr("disabled", "disabled");
		$("#initBtn").attr("disabled", "disabled");
		$("#selectMovieId").removeAttr("value");
	}
	
	function f_movie_select() {
		var beforeClickCss = {"background-color": "white", "color": "black"};
		var afterClickCss = {"background-color": "rgba(78,81,116,0.8)", "color":"white"};
		$(".movieDiv").css(beforeClickCss);
		$(this).css(afterClickCss);
		$("#nextBtn").removeAttr("disabled");
		$("#initBtn").removeAttr("disabled");
		$("#nextBtn").css("background-color", "#C75353");
		$("#selectMovieId").val($(this).find($(".movieId")).val());
	}
</script>
</head>
<body>
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<div class="reservation-wrap">
		      	<h3>영화선택</h3>
		      	<div class="movieOuterWrap justify-content-center">
		      		<div class="movieInnerWrap">
						<c:forEach items="${movielist}" var="movie">
							<div class="movieDiv mb-4">
								<img alt="${movie.title}" src="${initParam['path']}/static/images/movie/${movie.poster}">
								<div class="movie-sub-wrap">
									<p class="movieTitle">${movie.title}</p>
									<p class="theater_count">상영관수 ${movie.theaters_count}</p>
								</div>
								<input type="hidden" class="movieId" value="${movie.id}">
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="buttonsWrap">
					<button type="button" class="btn" id="initBtn" disabled="disabled">
						<i class="fa-solid fa-arrow-rotate-right"></i>&nbsp;초기화
					</button>
					<button type="button" class="btn" id="nextBtn" disabled="disabled">상영관선택</button>
					<input type="hidden" id="selectMovieId">
				</div>
	      	</div>
	    </div>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
</body>
</html>