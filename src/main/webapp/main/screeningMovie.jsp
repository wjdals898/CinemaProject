<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="container">
	<div class="title">
		<h3>상영작</h3>
		<a href="${initParam['path']}/movie/screening">
			<i class="fa-solid fa-plus"></i>&nbsp;더보기
		</a>
	</div>
	<div class="swiper movieOuterWrap">
		<div class="swiper-wrapper movieInnerWrap">
			<div class="swiper-slide movieDiv">
				<img alt="movie1" src="${initParam['path']}/static/images/movie/movie1.png">
				<p class="movieTitle">라라랜드</p>
				<p class="movieSub">
					<span>예매율20%</span>
					<span><i class="fa-regular fa-heart"></i></span>
				</p>
				<button type="button" class="btn">예매하기</button>
			</div>
			<div class="swiper-slide movieDiv">
				<img alt="movie1" src="${initParam['path']}/static/images/movie/movie2.png">
				<p class="movieTitle">파묘</p>
				<p class="movieSub">
					<span>예매율30%</span>
					<span><i class="fa-regular fa-heart"></i></span>
				</p>
				<button type="button" class="btn">예매하기</button>
			</div>
			<div class="swiper-slide movieDiv">
				<img alt="movie1" src="${initParam['path']}/static/images/movie/movie3.png">
				<p class="movieTitle">범죄도시4</p>
				<p class="movieSub">
					<span>예매율49%</span>
					<span><i class="fa-regular fa-heart likeIcon"></i></span>
				</p>
				<button type="button" class="btn">예매하기</button>
			</div>
			<div class="swiper-slide movieDiv">
				<img alt="movie1" src="${initParam['path']}/static/images/movie/movie4.png">
				<p class="movieTitle">쿵푸팬더4</p>
				<p class="movieSub">
					<span>예매율1.1%</span>
					<span><i class="fa-regular fa-heart"></i></span>
				</p>
				<button type="button" class="btn">예매하기</button>
			</div>
			<div class="swiper-slide movieDiv">
				<img alt="movie1" src="${initParam['path']}/static/images/movie/movie5.png">
				<p class="movieTitle">듄2</p>
				<p class="movieSub">
					<span>예매율20%</span>
					<span><i class="fa-regular fa-heart"></i></span>
				</p>
				<button type="button" class="btn">예매하기</button>
			</div>
			<div class="swiper-slide movieDiv">
				<img alt="movie1" src="${initParam['path']}/static/images/movie/movie6.png">
				<p class="movieTitle">서울의봄</p>
				<p class="movieSub">
					<span>예매율30%</span>
					<span><i class="fa-regular fa-heart"></i></span>
				</p>
				<button type="button" class="btn">예매하기</button>
			</div>
			<div class="swiper-slide movieDiv">
				<img alt="movie1" src="${initParam['path']}/static/images/movie/movie7.png">
				<p class="movieTitle">1987</p>
				<p class="movieSub">
					<span>예매율49%</span>
					<span><i class="fa-regular fa-heart"></i></span>
				</p>
				<button type="button" class="btn">예매하기</button>
			</div>
		</div>
	</div>
</div>

