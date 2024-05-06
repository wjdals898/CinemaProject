<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function signupBtnOnclick(){
		location.href="${initParam['path']}/auth/signup.jsp";
	}
	function loginBtnOnclick() {
		location.href="${initParam['path']}/auth/login.jsp";
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
		  <div class="parentBtn col-lg-6 col-sm-7">
		    <button type="button" class="btn" onclick="signupBtnOnclick();">회원가입</button>
		    <button type="button" class="btn" onclick="loginBtnOnclick();">로그인</button>
		  </div>
		</div>
	</div>
	
	<nav class="navbar navbar-expand-sm">
	  <div class="container-fluid">
	    <ul class="navbar-nav" id="navbar">
	      <li class="nav-item">
	        <a id="nav-menu" class="nav-link" href="#">전체영화</a>
	      </li>
	      <li class="nav-item">
	        <a id="nav-menu" class="nav-link" href="#">상영작</a>
	      </li>
	      <li class="nav-item">
	        <a id="nav-menu" class="nav-link" href="#">예매</a>
	      </li>
	      <li class="nav-item">
	      	<div id="search">
	      		<input type="text" class="form-control" placeholder="검색어를 입력하세요">
	      		<a><i class="fa-solid fa-magnifying-glass"></i></a>
	      	</div>
	      </li>
	    </ul>
	  </div>
	</nav>
</header>