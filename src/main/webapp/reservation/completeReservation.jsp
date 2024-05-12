<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매완료</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/completeReservation.css" rel="stylesheet">
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
			<h3>예매완료</h3>
			<div class="reservation-info-content">
				<p>예매번호</p>
				<p>${reservation.id}</p>
			</div>
			<div class="reservation-info-content">
				<p>예매일</p>
				<p>${reservation.reservationDate}</p>
			</div>
			<div class="reservation-info-content">
				<p>영화제목</p>
				<p>${reservation.movieTitle}</p>
			</div>
			<div class="reservation-info-content">
				<p>상영일</p>
				<p>${reservation.screeningDate}</p>
			</div>
			<div class="reservation-info-content">
				<p>상영시간</p>
				<p>${reservation.startTime}~${reservation.endTime}</p>
			</div>
			<div class="reservation-info-content">
				<p>좌석</p>
				<p>${reservation.seats}</p>
			</div>
			
		</div>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
</body>
</html>