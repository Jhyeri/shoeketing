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
      매장회원 상세보기
    </h3>

    <hr/>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">회원번호</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_NUM }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">아이디</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_ID }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">브랜드명</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_BRAND }</p>
      </div>
    </div>

    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">지점명</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_NAME }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">연락처</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_TEL }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">매장주소</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_ADD }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">영업시간</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_START_TIME } ~ ${shopMap.SHOP_END_TIME }</p>
      </div>
    </div>
    
    <div class="row m-4" style="border-bottom: 1px solid rgba(0, 0, 0, 0.11);">
      <div class="col-3">
        <p class="ms-5 mb-0" style="font-weight: 700;">탈퇴여부</p>
      </div>
      <div class="col-9 text-start">
        <p style="font-weight: 500;">${shopMap.SHOP_DEL_GB }</p>
      </div>
    </div>
    
    <div class="row">
      <div class="col-12 text-end">
        <button type="button" id="deleteShopBtn" class="btn btn-danger" style="width:6rem">회원탈퇴</button>
        <button type="button" id="shopListBtn" class="btn btn-secondary" style="width:6rem">목록</button>
      </div>
    </div>
  </div>
</body>
<script>
$(document).ready(function() {
	$("#deleteShopBtn").on("click", function(e) {
		var formData = new FormData();
		formData.append("SHOP_NUM", ${shopMap.SHOP_NUM });
		
		$.ajax({
			url : '/sk/admin/shopDelete',
			type : 'POST',
			data : formData,
			contentType : false,
			processData : false,
			success : function(data) {
				if(data.result == 1) {
					alert("'" + "${shopMap.SHOP_NAME }" + "'" + " 님을 탈퇴하였습니다.");
					location.href = '/sk/admin/shopList';
				} else {
					alert("회원탈퇴 실패");
				}
			}
		});
	});
	
	$("#shopListBtn").on("click", function(e) {
		var page = ${page};
		var searchType = '${searchType}';
		var keyword = '${keyword}';
		location.href = '/sk/admin/shopList?page=' + page + '&searchType=' + searchType + '&keyword=' + keyword;
	});
});
</script>
</html>