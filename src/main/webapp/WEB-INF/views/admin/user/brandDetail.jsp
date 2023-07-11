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
      브랜드회원 상세보기
    </h3>

    <hr/>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">회원번호</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${brandMap.BRAND_NUM }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">아이디</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${brandMap.BRAND_ID }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">브랜드명</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${brandMap.BRAND_NAME }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">사업자 등록번호</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${brandMap.BRAND_BUSINESS_NUM }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">등록지 주소</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${brandMap.BRAND_ADD }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">계약일자</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${brandMap.BRAND_JOINDATE }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">탈퇴여부</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${brandMap.BRAND_DEL_GB }</p>
      </div>
    </div>

    
    <div class="row">
      <div class="col-12 text-end">
        <button type="button" id="deleteBrandBtn" class="btn btn-danger" style="width:6rem">회원탈퇴</button>
        <button type="button" id="brandListBtn" class="btn btn-secondary" style="width:6rem">목록</button>
      </div>
    </div>
  </div>
</body>
<script>
$(document).ready(function() {
	$("#deleteBrandBtn").on("click", function(e) {
		var formData = new FormData();
		formData.append("BRAND_NUM", ${brandMap.BRAND_NUM });
		
		$.ajax({
			url : '/sk/admin/brandDelete',
			type : 'POST',
			data : formData,
			contentType : false,
			processData : false,
			success : function(data) {
				if(data.result == 1) {
					alert("'" + "${brandMap.BRAND_NAME }" + "'" + " 님을 탈퇴하였습니다.");
					location.href = '/sk/admin/brandList';
				} else {
					alert("회원탈퇴 실패");
				}
			}
		});
	});
	
	$("#brandListBtn").on("click", function(e) {
		var page = ${page};
		var searchType = '${searchType}';
		var keyword = '${keyword}';
		location.href = '/sk/admin/brandList?page=' + page + '&searchType=' + searchType + '&keyword=' + keyword;
	});
});
</script>
</html>