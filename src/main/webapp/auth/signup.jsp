<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${initParam['path']}/static/css/header.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/footer.css" rel="stylesheet">
<link href="${initParam['path']}/static/css/signup.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
<script src="${initParam['path']}/static/js/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/4e5b2f86bb.js" crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="${contextParam['path']}/common/header.jsp"></jsp:include>
	<section id="content">
		<div id="container">
			<h3>회원가입</h3>
			<form class="signup-form" action="" method="post">
				<div class="right-align"><span>*</span> 은 필수 입력 항목입니다.</div>
				<div class="fieldset">
					<label for="name">이름 <span>*</span></label>
					<input type="text" class="form-control" id="nickname" name="nickname">
				</div>
				<div class="fieldset">
					<label for="username">아이디 <span>*</span></label>
					<input type="text" class="form-control" id="username" name="username">
					<div id="duplication">
						<button type="button" class="btn" id="duplication_btn">중복확인</button>
					</div>
				</div>
				<div class="username-content">
					<div class="blank"> </div>
					<p>(4자~12자리의 영문자, 숫자 / @,#$등 특수문자는 제외)</p>
				</div>
				<div class="fieldset">
					<label for="password">비밀번호 <span>*</span></label>
					<input type="password" class="form-control" id="password" name="password">
				</div>
				<div class="fieldset">
					<label for="password_chk">비밀번호 확인 <span>*</span></label>
					<input type="password" class="form-control" id="password_chk" name="password_chk">
				</div>
				<div class="fieldset">
					<label for="phone">휴대전화</label>
					<input type="password" class="form-control" id="phone" name="phone">
				</div>
				<div class="fieldset">
					<label for="gender">성별</label>
					<div class="gender-buttons">
					    <button type="button" class="btn" id="maleBtn">남성</button>
					    <button type="button" class="btn" id="femaleBtn">여성</button>
					</div>
				</div>
				<div class="agreement-content">
					<div>
					    <input type="checkbox" class="form-check-input" id="agreeAll">
					    <label for="agreeAll">&nbsp;모든 약관에 동의합니다</label>
					</div>
					<div>
				    	<input type="checkbox" class="form-check-input" id="agreeTerms">
				    	<label for="agreeTerms">&nbsp;[필수] 이용약관에 동의합니다</label>
					</div>
					<div>
				    	<input type="checkbox" class="form-check-input" id="agreePrivacy">
				    	<label for="agreePrivacy">&nbsp;[선택] 개인정보 처리방침에 동의합니다</label>
				    </div>
				</div>
				<div class="form-buttons">
					<button type="button" class="btn" id="prevBtn">이전으로</button>
					<input type="submit" class="btn" id="signupBtn" value="회원가입하기">
				</div>
			</form>
		</div>
	</section>
	<jsp:include page="${contextParam['path']}/common/footer.jsp"></jsp:include>
	
	<script>
	    const maleBtn = document.getElementById('maleBtn');
	    const femaleBtn = document.getElementById('femaleBtn');
	
	    maleBtn.addEventListener('click', () => {
	    	if (!maleBtn.classList.contains('selected')) {
	            maleBtn.classList.add('selected');
	            femaleBtn.classList.remove('selected');
	        } else {
	        	maleBtn.classList.remove('selected');
	        }
	    });
	
	    femaleBtn.addEventListener('click', () => {
	        if (!femaleBtn.classList.contains('selected')) {
	            femaleBtn.classList.add('selected');
	            maleBtn.classList.remove('selected');
	        } else {
	        	femaleBtn.classList.remove('selected');
	        }
	    });
	</script>
	<script>
	    const agreeAllCheckbox = document.getElementById('agreeAll');
	    const individualCheckboxes = document.querySelectorAll('.agreement-content input[type="checkbox"]:not(#agreeAll)');
	
	    agreeAllCheckbox.addEventListener('change', () => {
	        const isChecked = agreeAllCheckbox.checked;
	
	        individualCheckboxes.forEach(checkbox => {
	            checkbox.checked = isChecked;
	        });
	    });
	
	    individualCheckboxes.forEach(checkbox => {
	        checkbox.addEventListener('change', () => {
	            const allChecked = Array.from(individualCheckboxes).every(cb => cb.checked);
	            agreeAllCheckbox.checked = allChecked;
	        });
	    });
	</script>
</body>
</html>