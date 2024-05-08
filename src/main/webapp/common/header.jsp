<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	function signupBtnOnclick(){
		location.href="${initParam['path']}/auth/signup";
	}
	function loginBtnOnclick() {
		location.href="${initParam['path']}/auth/login.do";
	}
</script>
<header id="header">
	<div class="p-3 header">
		<div class="row">
		  <div id="img" class="col-lg-6 col-sm-5">
		  	<a href="${initParam['path']}/">
		    	<img alt="logo" src="${initParam['path']}/static/images/logo1_5x.png" id="logo">
		    </a>
		  </div>
		  <c:if test="${loginUser==null}">
			  <div class="parentBtn col-lg-6 col-sm-7">
			    <button type="button" class="btn" onclick="signupBtnOnclick();">회원가입</button>
			    <button type="button" class="btn" onclick="loginBtnOnclick();">로그인</button>
			  </div>
		  </c:if>
		  <c:if test="${loginUser!=null}">
		  	<div class="parentBtn col-lg-6 col-sm-7">
		  		<a class="user-menu-wrap" href="${initParam['path']}/auth/logout.do">
		  			<i class="fa-solid fa-arrow-right-from-bracket fa-2xl"></i>
		  			<span>로그아웃</span>
		  		</a>
		  		<a class="user-menu-wrap">
		  			<i class="fa-regular fa-user fa-2xl"></i>
		  			<span>마이페이지</span>
		  		</a>
		  	</div>
		  </c:if>
		</div>
	</div>
	
	<nav class="navbar navbar-expand-sm">
	  <div class="container-fluid">
	    <ul class="navbar-nav" id="navbar">
	      <li class="nav-item">
	        <a id="nav-menu" class="nav-link" href="${initParam['path']}/movie/all">전체영화</a>
	      </li>
	      <li class="nav-item">
	        <a id="nav-menu" class="nav-link" href="${initParam['path']}/movie/screening">상영작</a>
	      </li>
	      <li class="nav-item">
	        <a id="nav-menu" class="nav-link" href="${initParam['path']}/reservation/movie">예매</a>
	      </li>
	      <li class="nav-item">
	      	<form action="${initParam['path']}/movie/search">
	      		<div id="search">
	      			<input type="text" class="form-control" id="searchWord" name="searchWord" placeholder="검색어를 입력하세요">
	      			<button type="submit" class="btn" onclick="searchBtnOnclick();"><i class="fa-solid fa-magnifying-glass"></i></button>
	      		</div>
	      	</form>
	      </li>
	    </ul>
	  </div>
	</nav>
</header>