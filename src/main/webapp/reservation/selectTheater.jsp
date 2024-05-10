<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영관선택</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/reservation.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/selectTheater.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${initParam['path']}/static/js/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/4e5b2f86bb.js" crossorigin="anonymous"></script>
<script>
	$(function(){
		$(".date-content").on("click", f_date_select);
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
	
	function f_date_select() {
		var selectDateIndex = $(this).find("+input").val();
		console.log(selectDateIndex);
		var initCss = {"background-color": "white", "color": "black"};
		var selectCss = {"background-color": "#C75353", "color": "white", "border-radius": "10px"};
		$(".date-content > p:first-child").css(initCss);
		$(this).find($(".date-content > p:first-child")).css(selectCss);
		
		/* console.log(${theaterlist}); */
		
		$.ajax({
			url: `${initParam['path']}/reservation/theater`,
			type: "post",
			data: {"movieId": ${selectMovie.id}, "selectDateIdx": selectDateIndex},
			success: function(responseData){
				console.log(responseData);
				
			}
		});
	}
	
</script>
</head>
<body>
	<c:set var="today" value="<%=new java.util.Date()%>" />
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<div class="reservation-wrap">
				<h3>상영관선택</h3>
				<div class="theaterOuterWrap justify-content-center">
					<div class="theater-left-content">
						<a href="javascript:window.history.back();">
							<i class="fa-solid fa-angle-left fa-lg"></i> 영화선택
						</a>
						<p>${selectMovie.title}</p>
						<img alt="${selectMovie.title}" src="${initParam['path']}/static/images/movie/${selectMovie.poster}">
					</div>
					<div class="theater-right-content">
						<p><fmt:formatDate value="${today}" pattern="yyyy.MM.dd (E)"/><span>오늘</span></p>
						<div class="select-date-wrap">
							<c:forEach var="index" begin="0" end="6" step="1">
								<div class="date-content">
									<p>${datelist[index]}</p>
									<p>${dayofweeklist[index]}</p>
								</div>
								<input type="hidden" class="date" value="${index}">
							</c:forEach>
						</div>
						<div class="select-theater-wrap">
							<c:forEach var="theater" items="${theaterlist}">
								<div class="screening-time">
									<p>${theater.startTime}~${theater.endTime}</p>
									<p><span>${theater.remainingSeatsCount}</span>/60</p>
								</div>
							</c:forEach>
						</div>
						<div class="buttonsWrap">
							<button type="button" class="btn" id="initBtn" disabled="disabled">
								<i class="fa-solid fa-arrow-rotate-right"></i>&nbsp;초기화
							</button>
							<button type="button" class="btn" id="nextBtn" disabled="disabled">좌석선택</button>
							<input type="hidden" id="selectTheaterId">
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
</body>
</html>