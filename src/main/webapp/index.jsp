<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/mainContent.css" rel="stylesheet">
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
		<jsp:include page="${contextParam['path']}/main/allMovie.jsp"></jsp:include>
		<jsp:include page="${contextParam['path']}/main/screeningMovie.jsp"></jsp:include>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
	<script>
	var swiper = new Swiper('.movieOuterWrap', {
	    slidesPerView: 'auto', // 보여질 슬라이드 수를 자동으로 조정
	    spaceBetween: 0, // 슬라이드 간의 간격 설정
	    loop: false, // 무한 루프 설정
	    watchOverflow: true,
	    initialSlide: 0,
	    speed: 500,
	});
	$(function(){
		$(".movieSub span:nth-child(2)").on("click", likeIconClick);
	});
	
	function likeIconClick(){
		$(this).find('i.fa-heart').toggleClass('fa-solid fa-regular');
	}
</script>
</body>
</html>