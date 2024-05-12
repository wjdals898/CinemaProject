<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석선택</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/reservation.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/selectSeat.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${initParam['path']}/static/js/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/4e5b2f86bb.js" crossorigin="anonymous"></script>
<script>
	var selectSeatList = [];
	$(function(){
		//f_soldout_seat_setting();
		$(".seat-item").on("click", f_seat_select);
		$("#initBtn").on("click", f_initBtn_click);
		$("#nextBtn").on("click", f_nextBtn_click);
		$("#cancelBtn").on("click", f_cancelBtn_click);
		$("#reservationBtn").on("click", f_reservationBtn_click);
	});
	
	/*function f_soldout_seat_setting(){
		var seatlist = <%=request.getAttribute("seatlist") %>;
		//$.each(${seatlist}, function(index, seat){
		seatlist.forEach((seat, index)=>{
			if(seat.isSoldout == 1) {
				var seatItem = $("#"+seat.seatNum);
				var soldoutCss = {
						"background-color": "rgba(120,120,120,0.3)", 
						"cursor":"default", 
						"box-shadow": "0 0 0 rgba(0, 0, 0, 0)"
				};
				seatItem.addClass("soldout");
				seatItem.text("");
				seatItem.css(soldoutCss);
			}
		});
	}*/
	
	function f_seat_select(){
		if($(this).text() == ""){
			return;
		}
		
		$(this).css("background-color", "#C75353");
		$("#nextBtn").css("background-color", "#C75353");
		var seatNum = $(this).find("+ .seat-num-value").val();
		console.log(seatNum);
		selectSeatList.push(seatNum);
		$("#selectSeatNum").text(selectSeatList.toString());
		$(".buttonsWrap button").removeAttr("disabled");
	}
	
	function f_nextBtn_click() {
		$(".seat-list").text(selectSeatList.toString());
		$(".modal_box").fadeIn(1000);
		$(".modal_bg").fadeIn(1000);
	}
	
	function f_initBtn_click() {
		var beforeClickCss = {"background-color": "#787878"};
		$(".seat-item").not(".soldout").css(beforeClickCss);
		$("#nextBtn").css(beforeClickCss);
		$("#nextBtn").attr("disabled", "disabled");
		$("#initBtn").attr("disabled", "disabled");
		selectSeatList.splice(0, selectSeatList.length);
		console.log(selectSeatList.toString);
		$("#selectSeatNum").text("");
		//$("#selectTheaterId").removeAttr("value");
	}
	
	function f_cancelBtn_click(){
		$(".modal_box").fadeOut();
		$(".modal_bg").fadeOut();
	}
	
	function f_reservationBtn_click() {
		var movieId = ${movie.id};
		var theaterId = ${theater.id};
		//var seatlist = JSON.stringify({"seatlist":selectSeatList});
		var seatlist = {"seatlist": selectSeatList};
		console.log(movieId);
		$.ajax({
			url: "seat",
			type: "post",
			data: {
				"theaterId": theaterId,
				"seatlist": selectSeatList
			},
			success: function(responseData){
				if(responseData === "-1") {
					alert("예매불가좌석");
					f_cancelBtn_click();
					f_initBtn_click();
				} else {
					alert("예매완료");
					location.href="complete.do?reservationId="+responseData;
				}
			}
		});
		
		//location.href = "complete?movieId="+movieId+"&theaterId="+theaterId+"&seatlist="+selectSeatList;
	}
</script>
</head>
<body>
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<div class="reservation-wrap">
				<input type="hidden" id="user" value="${loginUser}">
				<h3>좌석선택</h3>
				<div class="seatOuterWrap justify-content-center">
					<a href="javascript:window.history.back();">
						<i class="fa-solid fa-angle-left fa-lg"></i> 상영관선택
					</a>
					<div class="seat-container">
						<div class="seat-left-content">
							<div class="seat-table">
								<p>screen</p>
								<div class="seats-wrap">
									<div class="row-num">
										<c:forEach var="ch" items="A,B,C,D,E,F">
											<p>${ch}</p>
										</c:forEach>
									</div>
									<div class="seat-num">
										<c:forEach var="i" begin="0" end="5">
									        <div class="seat-row">
									            <c:forEach var="seat" items="${seatlist}" begin="${i*10}" end="${(i+1)*10-1}">
									            	<c:if test="${seat.soldout==true}">
									            		<p class="seat-item soldout"></p>
									            		<input type="hidden" class="seat-num-value" value="">
									            	</c:if>
									                <c:if test="${seat.soldout==false}">
									                	<c:set var="seatNumLength" value="${fn:length(seat.seatNum)}" />
									            		<p class="seat-item">${fn:substring(seat.seatNum, 1, seatNumLength)}</p>
									            		<input type="hidden" class="seat-num-value" value="${seat.seatNum}">
									            	</c:if>
									                
									            </c:forEach>
									        </div>
									    </c:forEach>
										
									</div>
								</div>
							</div>
						</div>
						<div class="seat-right-content">
							<div class="reservationInfo">
								<p class="movie-title">${movie.title}</p>
								<p class="remaining-seat">잔여좌석 <span>${theater.remainingSeatsCount}</span>/60</p>
								<p class="date">
									<fmt:formatDate value="${theater.screeningDate}" pattern="yyyy.MM.dd (E)"/>
									${theater.startTime}~${theater.endTime}
								</p>
								<p class="select-seat">선택좌석 : <span id="selectSeatNum"></span></p>
							</div>
							<div class="buttonsWrap">
								<button type="button" class="btn" id="initBtn" disabled="disabled">
									<i class="fa-solid fa-arrow-rotate-right"></i>&nbsp;초기화
								</button>
								<button type="button" class="btn" id="nextBtn" disabled="disabled">예매하기</button>
								<input type="hidden" id="selectSeatId">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
	<div class="modal_box">
		<p>예매정보 확인</p>
		<p>${movie.title}</p>
		<p>
			<fmt:formatDate value="${theater.screeningDate}" pattern="yyyy.MM.dd (E)"/>
			${theater.startTime}~${theater.endTime}
		</p>
		<p>좌석 : <span class="seat-list"></span></p>
		<div class="modal-button-group">
			<button type="button" class="btn" id="cancelBtn">취소</button>
			<button type="button" class="btn" id="reservationBtn">예매하기</button>
		</div>
		
	</div>
	<div class="modal_bg"></div>
</body>
</html>