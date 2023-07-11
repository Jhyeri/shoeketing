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
 <form id="modifyForm" name="modifyForm">
		            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">회원 정보 수정</h3>
		            <br>
		
		            <div class="row g-2">
		                <div class="mb-3" style="width: 45%; margin-left: 30%;">
		                    <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">아이디(이메일)</label>
		                    <input class="form-control" type="email" placeholder="${MEM_INFO.MEM_EMAIL}" aria-label="Disabled input example" disabled>
		                    <input type="hidden" name="MEM_NUM" value="${session_MEM_INFO.MEM_NUM}">
		                  </div>
		
		                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
		                    <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">비밀번호*</label>
		                    <input type="password" name="MEM_PW" class="form-control" id="exampleFormControlInput1">
		                  </div>
		
		                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
		                    <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">비밀번호 확인*</label>
		                    <input type="password" name="MEM_PW2" class="form-control" id="exampleFormControlInput1">
		                  </div>
		
		                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
		                    <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">이름</label>
		                    <input class="form-control" type="text" name="MEM_NAME" placeholder="${MEM_INFO.MEM_NAME}" aria-label="Disabled input example" disabled>
		                  </div>
		
		                  <div class="mb-3" style="width: 45%; margin-left: 30%;">
		                    <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">휴대전화</label>
		                    <input class="form-control" type="text" placeholder="${MEM_INFO.MEM_PHONE}" aria-label="Disabled input example" disabled>
		                  </div>
		
		                  <div class="form-check form-check-inline" style="width: 45%; margin-left: 30%;">
		                  	<c:choose>
		                  		<c:when test="${MEM_INFO.MEM_INFORM_AGREE=='Y'}">
		                  			<input class="form-check-input" type="checkbox" id="inlineCheckbox1" name="agreeCheck" checked>
		                  		</c:when>
		                  		<c:otherwise>
		                  			 <input class="form-check-input" type="checkbox" id="inlineCheckbox1" name="agreeCheck">
		                  		</c:otherwise>
		                  	</c:choose>
		                    <label class="form-check-label" for="inlineCheckbox1">(선택) 광고 메시지 수신을 동의합니다.</label>
		                  </div>
		              </div>
		
		              <h6 style="margin-left: 30%; margin-right: 25%; color: rgb(83, 83, 83);">네이버에서 제공하는 이벤트/혜택 등 다양한 정보를 휴대전화(네이버앱 알림 또는 문자), 이메일로 받아보실 수 있습니다. 일부 서비스(별도 회원 체계로 운영하거나 네이버 가입 이후 추가 가입하여 이용하는 서비스 등)의 경우, 개별 서비스에 대해 별도 수신 동의를 받을 수 있으며, 이때에도 수신 동의에 대해 별도로 안내하고 동의를 받습니다.</h6>
		              
		                <hr class="my-4">
		                <button class="btn btn-primary btn-lg" name="modify" style="margin-left: 30%; width: 45%;" type="submit">회원 정보 수정하기</button>
		         </form>
 </div>
        
<script type="text/javascript">

$(document).ready(function() {

	$("button[name='modify']").on("click", function(e) { //수정 버튼을 누르면
		 e.preventDefault();
		 if(confirm("회원정보를 수정하시겠습니까?")) {
			 fn_modify();
		 } else { return false; } 
	});


	function fn_modify() { //회원정보 수정처리
		var form = $("#modifyForm").serialize();
	
		$.ajax({
			url:"/sk/myPage/accountModify",
			type:'post',
			data:form,
			success:function() {
				alert("회원정보가 수정되었습니다.");
				 location.href="/sk/myPage";
			}
		});
	}
});
	
</script>
</body>
</html>