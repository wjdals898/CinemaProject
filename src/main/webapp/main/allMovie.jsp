<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="container">
	<div class="title">
		<h3>전체영화</h3>
		<a href="${initParam['path']}/movie/all">
			<i class="fa-solid fa-plus"></i>&nbsp;더보기
		</a>
	</div>
	<div class="swiper movieOuterWrap">
		<div class="swiper-wrapper movieInnerWrap">
			<c:forEach items="${movielist}" var="movie">
				<div class="swiper-slide movieDiv">
					<img alt="${movie.title}" src="${initParam['path']}/static/images/movie/${movie.poster}">
					<p class="movieTitle">${movie.title}</p>
					<p class="movieSub">
						<span>예매율 ${movie.theaters_count}%</span>
						<span><i class="fa-regular fa-heart"></i></span>
					</p>
					<button type="button" class="btn">예매하기</button>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
