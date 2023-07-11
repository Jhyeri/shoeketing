<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="col-2 order-ms-last" style="margin-top: 0px;">
            <h3 style="margin-left: 13%; color: black;">My Page</h3>
            <hr style="border: solid 1px rgb(73, 73, 73); width: 80%; margin-left: 5%;">
          <ul>
            <li class="list-group-item d-flex justify-content-between lh-sm">
              <div>
                <h5><a href="/sk/brandPage/accountModifyForm" name="brandInfoModify">기본 정보 수정</a></h5> <!-- 추후 data-brandNum 세션에서 꺼낸 BRAND_NUM 값으로 전송 -->
                <small class="text-muted">  </small>
              </div>
            </li>
            <li class="list-group-item d-flex justify-content-between lh-sm mt-4">
              <div>
                <h5 class="my-0">상품 관리</h5>
                <br>
                <h6 class="text-muted" style="margin-left: 25px;"><a href="/sk/brandPage/goodsList">전체 상품 리스트</a></h6>
                <h6 class="text-muted" style="margin-left: 25px;"><a href="/sk/brandPage/goodsWriteForm">상품 등록</a></h6>
              </div>
            
            </li>

            <li class="list-group-item d-flex justify-content-between lh-sm mt-4">
              <div>
                <h5 class="my-0">매장 관리</h5>
                <br>
                <h6 class="text-muted" style="margin-left: 25px;"><a href="/sk/brandPage/shopList">입점 매장 리스트</a></h6>
                <h6 class="text-muted" style="margin-left: 25px;"><a href="/sk/brandPage/shopRequestList">매장 가입 승인</a></h6>
                </div>
            </li>
          </ul>
        </div>

<script type="text/javascript">
$(document).ready(function() {
	$("a[name='shopList']").on("click", function(e) {  // 브랜드 기본정보 수정
		e.preventDefault();
	
		const brandNum = $(this).attr("data-brandNum");
		location.href="/sk/brandPage/shopList?BRAND_NUM=" + brandNum;
		
		//fn_brandInfoModify(brandNum);
	});
	
});

</script>        
        
</body>
</html>