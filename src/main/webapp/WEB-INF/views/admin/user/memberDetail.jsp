<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="col-10" style="margin-top: 0px">
    <h3 style="margin-left: 30px; color: black; font-weight: bolder">
      일반회원 상세보기
    </h3>

    <hr/>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">회원번호</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${memberMap.MEM_NUM }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">아이디</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${memberMap.MEM_EMAIL }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">이름</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${memberMap.MEM_NAME }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">휴대전화</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${memberMap.MEM_PHONE }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">탈퇴여부</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${memberMap.MEM_DEL_GB }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">마케팅 수신 동의 여부</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${memberMap.MEM_INFORM_AGREE }</p>
      </div>
    </div>  

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">회원등급</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${memberMap.MEM_GRADE }</p>
      </div>
    </div>
    
    <div class="row">
      <div class="col-12 text-end">
        <button id="deleteMemberBtn" type="button" class="btn btn-danger" style="width:6rem">회원탈퇴</button>
        <button id="memberListBtn" type="button" class="btn btn-secondary" style="width:6rem">목록</button>
      </div>
    </div>
  </div>
</body>
<script>
$(document).ready(function() {
	$("#deleteMemberBtn").on("click", function(e) {
		var formData = new FormData();
		formData.append("MEM_NUM", ${memberMap.MEM_NUM });
		
		$.ajax({
			url : '/sk/admin/memberDelete',
			type : 'POST',
			data : formData,
			contentType : false,
			processData : false,
			success : function(data) {
				if(data.result == 1) {
					alert("'" + "${memberMap.MEM_NAME }" + "'" + " 님을 탈퇴하였습니다.");
					location.href = '/sk/admin/memberList';
				} else {
					alert("회원탈퇴 실패");
				}
			}
		});
	});
	
	$("#memberListBtn").on("click", function(e) {
		var page = ${page};
		var searchType = '${searchType}';
		var keyword = '${keyword}';
		location.href = '/sk/admin/memberList?page=' + page + '&searchType=' + searchType + '&keyword=' + keyword;
	});
});
</script>
</html>