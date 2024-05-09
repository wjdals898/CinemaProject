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
						<a>
							<i class="fa-solid fa-angle-left"></i> 영화선택
						</a>
						<p>${selectMovie.title}</p>
						<img alt="${selectMovie.title}" src="${initParam['path']}/static/images/movie/${selectMovie.poster}">
					</div>
					<div class="theater-right-content">
						<p><fmt:formatDate value="${today}" pattern="yyyy.MM.dd (E)"/><span>오늘</span></p>
						<div class="select-date-wrap">
							<%-- <c:forEach begin="">
								<div class="date">
								
								</div>
							</c:forEach> --%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
</body>
</html>