<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container text-center justify-content-center align-self-center" style="width: 600px;">
        <div class="box-shadow-full" style="margin-top: 100px;">
            <div class="row mb-4">
                <h1>SHOEKETING</h1>
            </div>
            <div class="row mb-3">
                <ul class="nav nav-tabs justify-content-center">
                    <li class="nav-item">
                      <a class="nav-link text-dark" href="/sk/loginSelect/member">일반회원</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link active" href="/sk/loginSelect/shop">매장회원</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link text-dark" href="/sk/loginSelect/brand">브랜드회원</a>
                    </li>
                  </ul>
            </div>
            <div class="row">
                <form class="php-email-form needs-validation" id="loginForm" novalidate>
                    <div class="form-group mt-3 mb-3">
                        <input type="text" class="form-control" id="SHOP_ID" name="SHOP_ID" placeholder="id" required/>
                        <div class="invalid-feedback text-start">
				      		아이디를 입력해주세요
				    	</div>
                    </div>
                    <div class="form-group mb-3">
                        <input type="password" class="form-control" id="SHOP_PW" name="SHOP_PW" placeholder="password" required/>
                        <div class="invalid-feedback text-start">
				      		비밀번호를 입력해주세요
				    	</div>
                    </div>
                    <div class="form-group mb-3 text-left">
                        <input type="checkbox" value="autoLogin" id="autoLogin">
                        <label class="form-check-label" for="autoLogin">
                          자동로그인
                        </label>
                    </div>
                    <div class="form-group mt-5 mb-5">
                        <button type="submit" name="login" class="btn btn-dark" style="width: 300px; background-color:black;">로그인</button>
                    </div>
                    <div class="form-group mt-4 mb-3">
                        <button type="button" class="btn btn-dark" style="width: 100px;" onclick="location.href='/sk/shopJoinForm'">회원가입</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

<script type="text/javascript">
$(document).ready(function() {
	//유효성 검사
	(() => {
		  'use strict'
	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const form = document.querySelector('.needs-validation')
	  // Loop over them and prevent submission
	$("#loginForm").on("submit", function(e) { //등록 버튼 누르면
		e.preventDefault();
		$('#loginForm').addClass('was-validated');
		let SHOP_ID = $("#SHOP_ID").val();
		let SHOP_PW = $("#SHOP_PW").val();
		
		if($.trim(SHOP_ID) == '' || SHOP_ID == null) {
			return false;
		}
		
		if($.trim(SHOP_PW) == '' || SHOP_PW == null) {
			return false;
		}
		
		 fn_loginForm();
		});
	})()
	
	function fn_loginForm() {
		
		var formData = new FormData();
		var SHOP_ID = $('#SHOP_ID').val();
		var SHOP_PW = $('#SHOP_PW').val();
		
		formData.append("SHOP_ID", SHOP_ID);
		formData.append("SHOP_PW", SHOP_PW);
		
		$.ajax({
			url: '/sk/shopLogin',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function(data) {
				if(data == "idfail"){
					alert("존재하지 않는 아이디입니다.");
				}else if(data == "pwfail"){
					alert("비밀번호가 일치하지 않습니다.");
				}else if(data == "success"){
					location.href='/sk/main';
				}
			},
			error: function(xhr, status, error) {
				console.log('실패');
			}
		});
	};
});
</script>
</html>