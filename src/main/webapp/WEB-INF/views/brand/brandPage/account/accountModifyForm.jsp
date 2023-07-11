<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <div class="col-8" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">회원 정보 수정</h3>
            <br>
			<form id="accountModifyForm" class="needs-validation" method="post" novalidate >
            <div class="row g-2">
                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <label for="BRAND_ID" class="form-label" style="font-size: large; font-weight: bolder;">아이디(이메일)</label>
                    <input class="form-control" type="email" aria-label="Disabled input example" id="BRAND_ID" name="BRAND_ID" value="${brandInfoMap.BRAND_ID}" disabled>
                  </div>

                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <label for="BRAND_PW" class="form-label" style="font-size: large; font-weight: bolder;">비밀번호*</label>
                    <input type="password" class="form-control" id="BRAND_PW" name="BRAND_PW" 
                    pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$"
              		placeholder="특수문자, 문자, 숫자 포함 형태의 8~16자리 이내" required>
              		<div id="pw-null" class="invalid-feedback">
				      비밀번호를 입력해주세요
				  	</div>
				  	<div id="pw-type" class="invalid-feedback">
				      비밀번호 형식이 올바르지 않습니다
				  	</div>
                  </div>

                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <label for="BRAND_PW_CHECK" class="form-label" style="font-size: large; font-weight: bolder;">비밀번호 확인*</label>
                    <input type="password" class="form-control" id="BRAND_PW_CHECK" name="BRAND_PW_CHECK"
                    pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" required>
              		<div id="pw2-null" class="invalid-feedback">
				      비밀번호 확인이 필요합니다
				  	</div>
		            <div id="pw2-same" class="invalid-feedback">
				      비밀번호가 일치하지 않습니다
				  	</div>
                  </div>

                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <label for="BRAND_NAME" class="form-label" style="font-size: large; font-weight: bolder;">브랜드명</label>
                    <input class="form-control" type="text" aria-label="Disabled input example" id="BRAND_NAME" name="BRAND_NAME" value="${brandInfoMap.BRAND_NAME}" disabled>
                  </div>

                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <label for="BRAND_BUSINESS_NUM" class="form-label" style="font-size: large; font-weight: bolder;">사업자 등록 번호</label>
                    <input class="form-control" type="text" aria-label="Disabled input example" id="BRAND_BUSINESS_NUM" name="BRAND_BUSINESS_NUM" value="${brandInfoMap.BRAND_BUSINESS_NUM}" disabled>
                  </div>

                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <label for="BRAND_ADD" class="form-label" style="font-size: large; font-weight: bolder;">등록지 주소</label>
                    <input type="text" class="form-control" id="BRAND_ADD" name="BRAND_ADD" value="${brandInfoMap.BRAND_ADD}" >
                </div>             
                
                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <table>
                        <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">브랜드 대표 사진</label>
                        <tr>
                        <td style="width: 60%;">
                            <div class="mb-3">
                                <input class="form-control" name="BRAND_LOGO_FILE" type="file" id="formFile">${brandInfoMap.BRAND_LOGO_FILE}
                              </div>
                        </tr>
                    </table>
                </div>  
                
                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                    <label for="BRAND_INFO" class="form-label" style="font-size: large; font-weight: bolder;">브랜드 소개말</label>
                    <textarea class="form-control" id="BRAND_INFO" rows="10">${brandInfoMap.BRAND_INFO}</textarea>
                </div>    

                <hr class="my-4">
                <button class="btn btn-primary btn-lg" name="brandInfoModify" style="margin-left: 30%; width: 45%;" type="submit">회원 정보 수정하기</button>
            </div>
            </form>
        </div>
      
<script type="text/javascript">
$(document).ready(function() {
	$("button[name='brandInfoModify']").on("click", function(e){  // 브랜드 회원정보 수정
		e.preventDefault();
		if(isValidForm()){
		fn_brandInfoModify();
		}
	});
	
	function isValidForm() {
		var form = $(".needs-validation")[0];
		if (form.checkValidity() === false) {
			event.preventDefault();
			event.stopPropagation();
			form.classList.add('was-validated');
			return false;
		}
		form.classList.add('was-validated');
		return true;
	}
	
	function fn_brandInfoModify(){
		
		var formData = new FormData();
		
		var brandLogoFile = $("input[name='BRAND_LOGO_FILE']");
		var files = brandLogoFile[0].files;
		
		var brandPW = $("#BRAND_PW").val();
		var brandAdd = $("#BRAND_ADD").val();
		var	brandInfo = $("#BRAND_INFO").val();
		var brandNum = ${brandInfoMap.BRAND_NUM}; 
		
		// 파일 수정 안했을경우, 기존 파일이름 BRAND_LOGO_FILE로 넣어주기
		if(files.length == 0){
			formData.append("BRAND_LOGO_FILE", "${brandInfoMap.BRAND_LOGO_FILE}");
		}else{  // 파일 수정했을경우, 수정한 파일 BRAND_LOGO_FILE로 넣어주기
			formData.append("BRAND_LOGO_FILE", files[0]);
		}
		
		formData.append("BRAND_PW", brandPW);
		formData.append("BRAND_ADD", brandAdd);
		formData.append("BRAND_INFO", brandInfo);
		formData.append("BRAND_NUM", brandNum);
		
		$.ajax({
			type : 'post',
			url : '/sk/brandPage/accountModify',
			data : formData,
			processData : false,
			contentType : false,
			enctype : 'multipart/form-data',
			success : function(data){
				if(data.updateResult == "pass"){
					alert("브랜드 정보가 정상적으로 수정되었습니다.");
					location.href='/sk/brandPage';
				} else if(data.updateResult == "fail") {
					alert("브랜드 정보가 수정되지 못했습니다.");
				}
			},
			error : function(){
				alert("오류 발생");
			}
			
		});
	}
	
	
});

//유효성검증
// Example starter JavaScript for disabling form submissions if there are invalid fields
(() => {
'use strict'

// Fetch all the forms we want to apply custom Bootstrap validation styles to
const forms = document.querySelectorAll('.needs-validation')

// Loop over them and prevent submission
Array.from(forms).forEach(form => {
form.addEventListener('submit', event => {
  if (!form.checkValidity()) {
    event.preventDefault()
    event.stopPropagation()
    form.classList.add('was-validated');
  } else {
    form.classList.add('was-validated');
  }
  
//비밀번호
  let pwdval = $('#BRAND_PW').val()
   let pwdokval = $('#BRAND_PW_CHECK').val()
   let pwdcheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
   
   if(pwdval == null || $.trim(pwdval) == "") {
 	  $("#pw-null").show();
		  $("#pw-type").hide();
	      $("#BRAND_PW").focus();
   } else if(!pwdcheck.test(pwdval)) {
 	  $("#pw-null").hide();
		  $("#pw-type").show();
	      $("#BRAND_PW").focus();
   } else {
 	  $("#pw-null").hide();
		  $("#pw-type").hide();
   }
   
   if(pwdokval == null || $.trim(pwdokval) == "") {
 	  $("#pw2-null").show();
		  $("#pw2-same").hide();
	      $("#BRAND_PW_CHECK").focus();
   } else if(pwdval!==pwdokval) {
 	  $("#pw2-null").hide();
		  $("#pw2-same").show();
	      $("#BRAND_PW_CHECK").focus();
   }

  
  
  
}, false)
});
})()

</script>
</body>
</html>