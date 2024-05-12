<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.cinema.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		f_set_theater();
		$(".date-content").on("click", f_date_select);
		$("#initBtn").on("click", f_initBtn_click);
		$("#nextBtn").on("click", f_nextBtn_click);
		$(".screening-time p").on("click", f_time_select);
		
	});
	
	function f_time_select() {
		var initCss = {"margin": 0, "background-color": "white", "color": "black"};
		var selectCss = {"margin": 0, "background-color": "#4E5174", "color": "white"};
		console.log($(this).parent().find(".selectTheater").val());
		$("#selectTheaterId").val($(this).parent().find(".selectTheater").val());
		$(".screening-time p").css(initCss);
		$(this).css(selectCss);
		$("#nextBtn").removeAttr("disabled");
		$("#initBtn").removeAttr("disabled");
		$("#nextBtn").css("background-color", "#C75353");
	}
	
	function f_nextBtn_click() {
		var selectTheaterId = $("#selectTheaterId").val();
		var movieId = ${selectMovie.id};
		console.log("selectTheaterId="+selectTheaterId);
		var loginUser=$("#user").val();
		console.log(loginUser);
		
		if(loginUser == null || loginUser == "") {
			console.log(loginUser);
			alert("로그인이 필요합니다.");
			location.href=`${initParam['path']}/auth/login.do`;
		} else {
			location.href="seat?theaterId="+selectTheaterId+"&movieId="+movieId;
		}
	}
	
	function f_initBtn_click() {
		var beforeClickCss = {"margin": 0, "background-color": "white", "color": "black"};
		$(".screening-time p").css(beforeClickCss);
		$("#nextBtn").attr("disabled", "disabled");
		$("#initBtn").attr("disabled", "disabled");
		$("#selectTheaterId").removeAttr("value");
	}
	
	function f_date_select() {
		var selectDateIndex = $(this).find("+input").val();
		console.log(selectDateIndex);
		var initCss = {"background-color": "white", "color": "black"};
		var selectCss = {"background-color": "#C75353", "color": "white", "border-radius": "10px"};
		$(".date-content > p:first-child").css(initCss);
		$(this).find($(".date-content > p:first-child")).css(selectCss);
		
		f_set_theater(selectDateIndex);	
		f_initBtn_click();
        
        <%-- var theaterlist = <%=request.getAttribute("theaterlist") %>;
        
        theaterlist.forEach((theater, index)=>{
        	var screeningDate = new Date(theater.screeningDate);
            // 날짜가 일치하는 경우 해당 상영 시간 요소를 보여줌
            if (selectedDate.toDateString() === screeningDate.toDateString()) {
                var screeningTimeElement = theaterWrap.find('div[data-theater-id="' + theater.theaterId + '"]');
                // 해당 상영 시간 요소가 없는 경우 새로 생성
                if (!screeningTimeElement.length) {
                    screeningTimeElement = $('<div class="screening-time" data-theater-id="' + theater.theaterId + '"></div>');
                    theaterWrap.append(screeningTimeElement);
                }
                screeningTimeElement.html('<p>' + theater.startTime + '~' + theater.endTime + '</p><p><span>' + theater.remainingSeatsCount + '</span>/60</p>').show();
            }
        }); --%>
        
        // theaterlist를 순회하면서 선택된 날짜와 상영 날짜가 일치하는 데이터만 보여줌
        /* $.each(${theaterlist}, function(index, theater) {
            var screeningDate = new Date(theater.screeningDate);
            // 날짜가 일치하는 경우 해당 상영 시간 요소를 보여줌
            if (selectedDate.toDateString() === screeningDate.toDateString()) {
                var screeningTimeElement = theaterWrap.find('div[data-theater-id="' + theater.theaterId + '"]');
                // 해당 상영 시간 요소가 없는 경우 새로 생성
                if (!screeningTimeElement.length) {
                    screeningTimeElement = $('<div class="screening-time" data-theater-id="' + theater.theaterId + '"></div>');
                    theaterWrap.append(screeningTimeElement);
                }
                screeningTimeElement.html('<p>' + theater.startTime + '~' + theater.endTime + '</p><p><span>' + theater.remainingSeatsCount + '</span>/60</p>').show();
            }
        }); */
		
		/* console.log(${theaterlist}); */
		
		/* var selectedDate;f_request_date(selectDateIndex);
		console.log(selectedDate); */
		
		/*$.each(${theaterlist}, function(index, theater) {
            var screeningDate = theater.screeningDate;
            console.log(selectedDate);
            // 날짜가 일치하는 경우 해당 상영 시간 요소를 보여줌
            if (selectedDate === screeningDate.toString()) {
                var screeningTimeElement = theaterWrap.find('.screening-time:nth-of-type('+(index+1)+')');
                // 해당 상영 시간 요소가 없는 경우 새로 생성
                if (!screeningTimeElement.length) {
                    screeningTimeElement = $('<div class="screening-time" data-theater-id="' + theater.theaterId + '"></div>');
                    theaterWrap.append(screeningTimeElement);
                }
                screeningTimeElement.html('<p>' + theater.startTime + '~' + theater.endTime + '</p><p><span>' + theater.remainingSeatsCount + '</span>/60</p>').show();
            }
        });*/
		
	}
	function f_set_theater(selectDateIndex) {
		var today = new Date();
    	var month = today.getMonth() + 1; // 월은 0부터 시작하므로 1을 더합니다.
    	var year = today.getFullYear();
    	var day = today.getDate();
    		
		if (month < 10) {
		    month = '0' + month;
		}
		if (day < 10) {
		    day = '0' + day;
		}
		if(selectDateIndex != null) {
			day = selectDateIndex;
		}
		var selectDate = year + '-' + month + '-' + day;
		console.log(selectDate);
		/*var selectedDate;*/
	    /* selectedDate.setDate(selectedDate.getDate() + parseInt(selectDateIndex));
	    console.log(selectedDate); */
	    
	    var theaterWrap = $('.select-theater-wrap');
        // 모든 상영 시간 요소를 숨김
        theaterWrap.find('.screening-time').hide();
        theaterWrap.find('.no-theater-message').show();
        
        $.each($(".screening-time"), function(index, theater) {
        	var $theater = $(theater);
        	var screeningDate = $theater.find(".screeningDate").val();
        	console.log(screeningDate);
        	if(screeningDate == selectDate) {
        		theaterWrap.find('.no-theater-message').hide();
        		$(".select-theater-wrap > ."+screeningDate).show();
        	}
        });
	}
	/* function f_request_date(selectDateIndex){
		var selectedDate;
		$.ajax({
			url: `${initParam['path']}/reservation/theater`,
			type: "post",
			async: "true",
			data: {"movieId": ${selectMovie.id}, "selectDateIdx": selectDateIndex},
			success: function(responseData){
				console.log(responseData);
				selectedDate = responseData;
			}
		});
		return selectedDate;
	} */
	
</script>
</head>
<body>
	<c:set var="today" value="<%=new Date()%>" />
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<div class="reservation-wrap">
				<input type="hidden" id="user" value="${loginUser}">
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
								<%-- <input type="hidden" class="date" value="${index}"> --%>
								<input type="hidden" class="date" value="${datelist[index]}">
							</c:forEach>
						</div>
						<div class="select-theater-wrap">
							<p class="no-theater-message">상영관이 없습니다.</p>
							<c:forEach var="theater" items="${theaterlist}">
								<div class="screening-time ${theater.screeningDate}">
									<input type="hidden" class="screeningDate" value="${theater.screeningDate}">
									<p class="time">${theater.startTime}~${theater.endTime}</p>
									<p><span>${theater.remainingSeatsCount}</span>/60</p>
									<input type="hidden" class="selectTheater" value="${theater.id}">
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