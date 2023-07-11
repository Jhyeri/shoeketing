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
	  <div class="col-10" style="margin-top: 0px">
        <h3 style="margin-left: 30px; color: black; font-weight: bolder">
          전체 상품 리스트
        </h3>
        <form id="searchForm" action="/sk/brandPage/goodsList">
        <div class="row mt-4">
        	<div class="col-8 align-self-center">
        		<h5 id="totalCount" style="margin-left: 30px;">전체 총 ${TOTAL } 개</h5>
        	</div>
	        <div class="col-4 d-flex align-self-center">
	            <div class="dropdown" style="width:10rem;">
	              <select
	                class="form-select"
	                style="border-color: rgba(0, 0, 0, 0.263)"
	                id="searchType"
	                name="searchType"
	              >
	                <option selected <c:out value="${searchType eq '모델명' ? 'selected' :''}"/>>모델명</option>
	                <option <c:out value="${searchType eq '모델 번호' ? 'selected' :''}"/>>모델 번호</option>
	              </select>
	            </div>
	            <div class="input-group">
	              <input
	                class="header-input"
	                style="
	                  height: 38px;
	                  border-style: none;
	                  border: solid 1px black;
	                  border-right: none;
	                  border-top-left-radius: 5px;
	                  border-bottom-left-radius: 5px;
	                "
	                id="keyword"
	                name="keyword"
	                type="text"
	                value="${keyword}"
	              />
	              <button
	                class="btn"
	                type="submit"
	                name="goodsSearch"
	                style="
	                  background-color: white;
	                  border: solid 1px black;
	                  height: 38px;
	                  border-left: none;
	                "
	              >
	                <svg
	                  xmlns="http://www.w3.org/2000/svg"
	                  width="15"
	                  height="15"
	                  fill="currentColor"
	                  class="bi bi-search"
	                  viewBox="0 0 16 16"
	                >
	                  <path
	                    d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"
	                  />
	                </svg>
	              </button>
	            </div>
	          </div>
	       </div>
        </form>
      
      <br />
      <div
        class="row"
        style="margin-left: 6px"
        id="goodsListDiv"
      >
        <c:forEach var="list" items="${list}">
          <div class="col-3">
            <a href="#" name="goodsImg" data-num="${list.TOTAL_GOODS_NUM}">
              <div class="card shadow-sm">
                  <img src="/sk/image/display?fileName=${list.GOODS_IMAGE_STD}"
                  class="bd-placeholder-img card-img-top"
                  width="150"
                  height="200" />
                <div class="card-body">
                  <p class="card-text mb-1" id="brandName">
                    ${list.BRAND_NAME}
                  </p>
                  <p
                    class="card-text mb-1"
                    style="font-size: x-small; color: rgb(94, 95, 95)"
                  >
                    ${list.TOTAL_GOODS_NAME}
                  </p>
                  <p
                    class="card-text mb-1"
                    style="font-size: x-small; color: rgb(94, 95, 95)"
                  >
                    ${list.TOTAL_GOODS_MODEL}
                  </p>
                  <p
                    class="card-text"
                    style="
                      font-size: medium;
                      color: rgb(0, 0, 0);
                      font-weight: bolder;
                    "
                  >
                    <fmt:formatNumber
                      type="number"
                      maxFractionDigits="3"
                      value="${list.TOTAL_GOODS_PRICE}"
                    />원
                  </p>
                </div>
              </div>
            </a>
          </div>
        </c:forEach>

      	</div>
      	
      	<!-- 페이징 화면 처리 부분 시작 -->
      	<div id="PAGE_NAVI"></div>
      	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX" />
      	<!-- 페이징 검색 조건 및 검색 키워드 input type hidden 시작 -->
		<input type="hidden" id="PAGE_SEARCHTYPE" name="PAGE_SEARCHTYPE"/>
		<input type="hidden" id="PAGE_KEYWORD" name="PAGE_KEYWORD"/>
		<!-- 페이징 검색 조건 및 검색 키워드 input type hidden 시작 -->
      	<!--  페이징 화면 처리 부분 끝 -->
      	
      </div>
      
<script type="text/javaScript">

$(document).ready(function() {
	
	$('#PAGE_INDEX').val(${page});
	$('#PAGE_KEYWORD').val('${keyword}');
	$('#PAGE_SEARCHTYPE').val('${searchType}');
   
   fn_selectGoodsList(${page}, '${searchType}', '${keyword}');
   
   /* 검색버튼 이벤트에 기존 ajax 함수 제거하고 페이징 함수 연결하기 */
	$("#searchForm").on("submit", function(e){  //공지사항 검색
		e.preventDefault();
		
		/* 페이징 검색 조건 및 검색 키워드 변수 초기화 시작 */
		var keyword = $('#keyword').val();
		var searchType = $('#searchType').val();
		/* 페이징 검색 조건 및 검색 키워드 변수 초기화 끝 */
		
		$('#PAGE_INDEX').val(1); /* 검색 시 1페이지로 */
		
		/* 페이징 검색 조건 및 검색 키워드 input type hidden에 값 넣어주기 시작 */
		$('#PAGE_KEYWORD').val(keyword);
		$('#PAGE_SEARCHTYPE').val(searchType);
		/* 페이징 검색 조건 및 검색 키워드 input type hidden에 값 넣어주기 끝 */
		
		/* 페이징 함수 매개변수에 맞게 함수 호출(매개변수 순서 및 위치 주의!!) */
		fn_selectGoodsList(1, searchType, keyword);
	});
   
   $("#goodsListDiv").on("click", "a[name='goodsImg']", function(e) { //상품 이미지를 클릭하면 상품 디테일로 이동
   	   e.preventDefault();
	   const brandName = $("#brandName").text();
	   const goodsNum = $(this).attr("data-num");

   	   location.href="/sk/goods/goodsDetail?TOTAL_GOODS_NUM=" + goodsNum;
   });  
   
   $("#goodsListDiv").on("click", "button[name='updateGoods']", function(e) { // 상품 수정
   	   e.preventDefault();
	   const goodsNum = $(this).attr("data-goodsNum");

   	   location.href="/sk/brandPage/goodsModifyForm?TOTAL_GOODS_NUM=" + goodsNum;
   });  
   
   $("#goodsListDiv").on("click", "button[name='deleteGoods']", function(e) { // 상품 삭제
   	   e.preventDefault();
	   const goodsNum = $(this).attr("data-goodsNum");

   	   fn_deleteGoods(goodsNum);
   });  
   
   function fn_deleteGoods(goodsNum){
	   
	   var page = $('#PAGE_INDEX').val();
	   var keyword = $('#keyword').val();
	   var searchType = $('#searchType').val();
	   
	   var formData = new FormData();
	   
	   formData.append("TOTAL_GOODS_NUM", goodsNum);
	   
	   $.ajax({
		 type : 'post',
		 url : "/sk/brandPage/goodsDelete",
		 data : formData ,
		 processData : false,
		 contentType : false,
		 success : function(data){
			if(data.result == "pass"){
				alert("상품이 정상적으로 삭제되었습니다.");
				var numItems = $('.goodsDiv').length
				if(numItems == 1) {
					$('#PAGE_INDEX').val(page-1);
					fn_selectGoodsList(page-1, searchType, keyword);
				} else {
					$('#PAGE_INDEX').val(page);
					fn_selectGoodsList(page, searchType, keyword);
				}
				
			};
		 },
		 error : function(request, status, error){
			console.log("code: " + request.status);
	        console.log("message: " + request.responseText);
	        console.log("error: " + error);
			alert("오류 발생");
		 }
		   
	   });
   }
      
});


 function fn_selectGoodsList(pageNo, searchType, keyword) { //페이징 함수
    var comAjax = new ComAjax();
    comAjax.setUrl("/sk/brandPage/goodsList/paging");
    comAjax.setCallback("fn_selectGoodsListCallback");
    comAjax.addParam("PAGE_INDEX", pageNo);
    comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시물의 개수
    comAjax.addParam("BRAND_NAME", $("#brandName").text());
    
    /* 페이징 검색 조건 및 검색 키워드 파라미터 추가 시작 */
	comAjax.addParam("keyword", keyword);
	comAjax.addParam("searchType", searchType);
	/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 끝 */
    
    comAjax.ajax();
 }
 
 function fn_selectGoodsListCallback(data) {
    var total = data.TOTAL; //게시물의 개수
    var totalDiv = $("#totalCount");
    var body = $("#goodsListDiv");
    
    body.empty(); //현재 페이지의 게시물을 지우고 알맞은 페이지의 내용을 집어넣기 위해
    totalDiv.empty();
    
    if(total == 0) {
       var str =  "<div class='row row-cols-12 g-5' style='margin-auto: 6px;'>" +
                "<span>아직 등록된 상품이 없습니다. 상품을 등록해주세요.</span>";
       body.append(str);
       totalDiv.append('전체 총 0개');
    } else {
        var params = {
       divId : "PAGE_NAVI",
       pageIndex : "PAGE_INDEX",
       /* 페이징 검색 조건 및 검색 키워드 객체에 추가 시작 */
       searchType : "PAGE_SEARCHTYPE",
       keyword : "PAGE_KEYWORD",
       /* 페이징 검색 조건 및 검색 키워드 객체에 추가 끝 */
       totalCount : total,
       recordCount : 10,
       eventName : "fn_selectGoodsList"
    };
    gfn_renderPaging(params);
    
    var str="";
    
    $.each(data.list, function(key, value) {
       
          str +=     "<div class='card goodsDiv' style='width: 14rem; margin-left: 10px; margin-right: 10px; margin-bottom: 80px; border-style: none;'>";
          str +=     "<a href='#' name='goodsImg' data-num='"+ value.TOTAL_GOODS_NUM +"' >";
          str +=     "<img src='/sk/image/display?fileName="+value.GOODS_IMAGE_STD + "' class='card-img-top' style='width:13rem; height: 11rem' />";
          str +=     "</a>";
          str +=     "<div class='card-body' style='height:6rem;'>";
          str +=     "<h6 class='card-title' id='brandName' style='font-size: 15px; font-weight: 700;'>"+value.BRAND_NAME+"</h6>";
          str +=     "<p class='card-text' style='font-size: 13px;'>"+value.TOTAL_GOODS_NAME+"</p>";
          str +=     "<p class='card-text' style='font-size: 13px;'>"+value.TOTAL_GOODS_MODEL+"</p>";
          str +=     "</div>";
          str +=     "<div class='card-body'>";
          str +=     "<div class='row'>";
          str += 	 "<div class='col-6 align-self-center'><h6 class='card-title mb-0' style='font-size: 16px; font-weight: 700;'>"+value.TOTAL_GOODS_PRICE+"원</h6></div>";
          str += 	 "<div class='col-6 ps-0 pe-0'><button type='button' class='btn btn-primary btn-sm me-1' name='updateGoods' data-goodsNum='"+ value.TOTAL_GOODS_NUM +"'>수정</button>";
          str +=	 "<button type='button' class='btn btn-danger btn-sm' name='deleteGoods' data-goodsNum='"+ value.TOTAL_GOODS_NUM +"'>삭제</button></div>";
          str +=     "</div></div>";
          str +=     "</div>";
          
         });
         body.append(str);
         totalDiv.append('전체 총 ' + total + '개');
    }
    
 }
 
    
      
</script>
</body>
</html>