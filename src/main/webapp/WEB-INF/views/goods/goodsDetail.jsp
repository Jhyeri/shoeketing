<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="container">
      <!--상단 상품 정보 시작-->
      <div class="row mt-5 mb-5">
        <!--상품 썸네일-->
        <div class="col-6 ps-4 pe-4">
          <img
            src="/sk/image/display?fileName=${goodsImageList[0].GOODS_IMAGE_STD }"
            class="img-thumbnail"
          />
        </div>
        <!--상품 정보-->
        <div class="col-6 ps-5 pe-4 pt-5">
          <div class="d-flex align-self-center">
            <h6 class="mb-0 me-1" style="font-weight: 700">${goodsDetailList[0].BRAND_NAME }</h6>
            <p class="mb-0 ms-3" style="font-size: 12px; font-weight: 400">
              <a href="#">브랜드관 <i class="bi bi-chevron-right"></i></a>
            </p>
          </div>
          <h3 class="mt-3" style="font-weight: 700">
            ${goodsDetailList[0].TOTAL_GOODS_NAME } / ${goodsDetailList[0].TOTAL_GOODS_MODEL }
          </h3>
          <div class="d-flex mt-4">
            <h3 class="mb-0" style="font-weight: 700"><fmt:formatNumber value="${goodsDetailList[0].TOTAL_GOODS_PRICE }" type="currency" currencySymbol="" /></h3>
            <p class="mb-0 ms-1 align-self-end">원</p>
          </div>
          <div class="d-flex mt-5">
            <p class="mb-0 me-5 align-self-center" style="font-weight: 500">
              사이즈
            </p>
            <select id="goodsSizeSelect" class="form-select" style="width: 25rem">
              <option selected>사이즈 선택</option>
              <c:forEach items="${goodsDetailList}" var="goods">
              	<option value="${goods.GOODS_DETAIL_SIZE }">${goods.GOODS_DETAIL_SIZE }</option>
              </c:forEach>
            </select>
          </div>
          <div class="d-flex mt-4">
            <p class="mb-0 me-5 align-self-center">상품리뷰</p>
            <div class="mb-1">
              <span class="star">
                ★★★★★
                <span class="starView">★★★★★</span>
                <input
                  name="starPoint"
                  type="range"
                  value="${goodsDetailList[0].TOTAL_GOODS_SCORE }"
                  step="1"
                  min="0"
                  max="10"
                />
                <!-- value 값에 따라서 별점 표시 -->
              </span>
            </div>
            <p class="mb-0 align-self-center ms-2">${goodsDetailList[0].TOTAL_GOODS_SCORE_AVG }</p>
          </div>
          <div
          	id="goodsLikeBtnDiv"
            class="d-grid gap-2 col-5"
            style="margin-left: 8rem; margin-top: 2rem"
          >
          	<c:choose>
          		<c:when test="${checkGoodsLike == 0 }">
		            <button
		              class="btn btn-light mt-4 goodsLike"
		              style="
		                border: 1px solid rgba(0, 0, 0, 0.345);
		                border-radius: 15px;
		                height:3rem;
		              "
		              type="button"
		              id="goodsLikeBtn"
		            >
		              위시리스트 <svg id="heartIcon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
		                <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
		              </svg>
		            </button>
		    	</c:when>
		    	<c:when test="${checkGoodsLike == 1 }">
		            <button
		              class="btn btn-light mt-4 goodsLike"
		              style="
		                border: 1px solid rgba(0, 0, 0, 0.345);
		                border-radius: 15px;
		                height:3rem;
		              "
		              type="button"
		              id="goodsUnlikeBtn"
		            >
		              위시리스트 <svg id="heartIcon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-heart-fill" viewBox="0 0 16 16">
		                <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
		              </svg>
		            </button>
		    	</c:when>
	        </c:choose>
	        	<form id="stockSearchForm" action="/sk/goods/stockSearchForm" method="post">
	        		<input type="hidden" name="goodsName" value="${goodsDetailList[0].TOTAL_GOODS_NAME }"/>
	        		<input type="hidden" name="brandName" value="${goodsDetailList[0].BRAND_NAME }"/>
	        		<input type="hidden" name="goodsSize" value=""/>
	        	</form>
		            <button
		              class="btn btn-secondary mt-3"
		              style="border-radius: 15px; height:3rem;"
		              type="button"
		              id="stockSearchBtn"
		            >
		              재고찾기
		            </button>
          </div>
        </div>
      </div>
      <!--상단 상품 정보 끝-->

      <hr />

      <!--상품 상세 이미지-->
      <div class="row p-5" style="margin: 0 10rem 0 10rem">
	      <c:forEach begin="1" end="${fn:length(goodsImageList)-1 }" varStatus="status">
	        <img
	          src="/sk/image/display?fileName=${goodsImageList[status.current].GOODS_IMAGE_STD }"
	          class="img-thumbnail"
	        />
	      </c:forEach>
      </div>
      <!--상품 상세 이미지 끝-->

      <hr />

      <!--상품만족도 시작-->
      <div class="row pt-3 pb-3">
        <!--상품 별점-->
        <div class="col-3 text-center align-self-center">
          <p class="mb-2">상품만족도</p>
          <div class="d-flex justify-content-center">
            <h2 class="mb-1" style="font-weight: 700">${goodsDetailList[0].TOTAL_GOODS_SCORE_PERCENT }</h2>
            <h5 class="align-self-center mb-0">%</h5>
          </div>
          <div class="d-flex justify-content-center">
            <div>
              <span class="star star2">
                ★★★★★
                <span class="starView">★★★★★</span>
                <input
                  name="starPoint"
                  type="range"
                  step="1"
                  min="0"
                  max="10"
                />
                <!-- 상단 별점 value에 따라 똑같이 적용됨 -->
              </span>
            </div>
            <p class="mb-0 align-self-center ms-2">${goodsDetailList[0].TOTAL_GOODS_SCORE_AVG }</p>
          </div>
        </div>

        <!--사이즈 착화감 색상-->
        <div class="col-8">
          <div class="row justify-content-around">
            <div class="col-3">
              <h5 class="mb-4">사이즈</h5>
              <div class="d-flex justify-content-between">
                <p>정사이즈보다 작음</p>
                <p>${goodsReviewPercent.REVIEW_SIZE_PERCENT1 }%</p>
              </div>
              <div class="d-flex justify-content-between">
                <p>정사이즈</p>
                <p>${goodsReviewPercent.REVIEW_SIZE_PERCENT2 }%</p>
              </div>
              <div class="d-flex justify-content-between">
                <p>정사이즈보다 큼</p>
                <p>${goodsReviewPercent.REVIEW_SIZE_PERCENT3 }%</p>
              </div>
            </div>

            <div class="col-3">
              <h5 class="mb-4">착화감</h5>
              <div class="d-flex justify-content-between">
                <p>나쁨</p>
                <p>${goodsReviewPercent.REVIEW_COMFORT_PERCENT1 }%</p>
              </div>
              <div class="d-flex justify-content-between">
                <p>보통</p>
                <p>${goodsReviewPercent.REVIEW_COMFORT_PERCENT2 }%</p>
              </div>
              <div class="d-flex justify-content-between">
                <p>좋음</p>
                <p>${goodsReviewPercent.REVIEW_COMFORT_PERCENT3 }%</p>
              </div>
            </div>

            <div class="col-3">
              <h5 class="mb-4">색상</h5>
              <div class="d-flex justify-content-between">
                <p>화면보다 밝음</p>
                <p>${goodsReviewPercent.REVIEW_COLOR_PERCENT1 }%</p>
              </div>
              <div class="d-flex justify-content-between">
                <p>화면과 같음</p>
                <p>${goodsReviewPercent.REVIEW_COLOR_PERCENT2 }%</p>
              </div>
              <div class="d-flex justify-content-between">
                <p>화면보다 어두움</p>
                <p>${goodsReviewPercent.REVIEW_COLOR_PERCENT3 }%</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--상품만족도 끝-->
    </div>
  </body>
  
  <script>
 
    $(document).ready(function () {
      $("input[name='starPoint']").css('cursor','default');
    
      const starPoint = $("input[name='starPoint']").val() * 10;
      $(".starView").css('width', starPoint + '%');
      
      $("#goodsLikeBtnDiv").on("click", "#goodsLikeBtn", function(e) {
    	  $.ajax({
    		  url : '/sk/goods/goodsLike?GOODS_LIKE_PRONUM=' + ${goodsDetailList[0].GOODS_DETAIL_NUM},
    		  type : 'get',
    		  success : function(data) {
    			  if(data == "success") {
    				  $("#heartIcon").attr('fill', 'red');
    				  $('#goodsLikeBtnDiv').children('.goodsLike').attr('id', 'goodsUnlikeBtn');
    			  } else {
    				  alert("오류발생");
    			  }
    		  }
    	  });
      });
      
      $("#goodsLikeBtnDiv").on("click", "#goodsUnlikeBtn", function(e) {
    	  $.ajax({
    		  url : '/sk/goods/goodsUnlike?GOODS_LIKE_PRONUM=' + ${goodsDetailList[0].GOODS_DETAIL_NUM},
    		  type : 'get',
    		  success : function(data) {
    			  if(data == "success") {
    				  $("#heartIcon").attr('fill', 'currentColor');
    				  $('#goodsLikeBtnDiv').children('.goodsLike').attr('id', 'goodsLikeBtn');
    			  } else {
    				  alert("오류발생");
    			  }
    		  }
    	  });
      });
      
      $("#stockSearchBtn").on("click", function(e) {
    	  event.preventDefault();
    	  $("input[name='goodsSize']").val($("#goodsSizeSelect option:selected").val());
    	  $("#stockSearchForm").submit();
      });
    });
  </script>
</html>