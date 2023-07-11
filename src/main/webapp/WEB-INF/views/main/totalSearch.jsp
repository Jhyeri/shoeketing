<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="container">
      <!--검색창 시작-->
      <div class="row mb-5 mt-5">
        <form id="totalSearchForm">
          <div class="input-group" style="justify-content: center">
            <input
              class="header-input"
              style="
                width: 28rem;
                height: 3rem;
                border-style: none;
                border-bottom: 3px solid black;
                font-size: 20px;
                font-weight: 700;
              "
              type="search"
              name="keyword"
              id="keyword"
              value="${keyword }"
              required
            />
            <button
              class="btn"
              type="submit"
              style="
                background-color: white;
                border-style: none;
                border-radius: 0;
                border-bottom: 3px thick black;
              "
              id="searchBtn"
              name="searchBtn"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
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
        </form>
      </div>
      <!--검색창 끝-->

      <!--검색 키워드 시작-->
      <div class="row mb-3" id="searchKeyword">
      	<h2 id='searchKeyword' style='font-weight: 700'>검색어: ${keyword }</h2>
      </div>
      <!--검색 키워드 끝-->

      <!--브랜드 검색 결과 시작-->
      <div id="bInfo" class="row ms-2 mb-5 d-flex">
      <c:forEach var="brand" items="${brandList}" varStatus="status">
           <div class="col-2 d-flex mb-2">
           <a href='#' class="d-flex" name='bDetail' data-num="${brand.BRAND_NUM}">
            <img
              src='/sk/image/display?fileName=${brand.BRAND_LOGO_FILE}'
              class="img-thumbnail"
              style="height: 5rem; width: 6rem"
            />
            <h6 class="ms-3 mb-0 align-self-center" style="font-weight: 700; font-size: 18px">
              ${brand.BRAND_NAME}<i class="bi bi-chevron-right" style="font-weight: 700"></i>
            </h6>
            </a>
          </div> 
      </c:forEach>
      </div>
      <!--브랜드 검색 결과 끝-->

      <!--상품 검색결과 리스트 시작-->
      <div class="row">
        <h5 class="mb-3" style="font-weight: 700">상품 검색결과</h5>
        <hr />

	<div id='gInfo' class="row">
	<c:forEach begin="0" end="3" var="goods" items="${goodsList}" varStatus="status">
         <div class="col-6 mt-4 mb-4 d-flex goodsCnt">
          <a href="#" class="d-flex" name='gDetail' data-num='${goods.TOTAL_GOODS_NUM}'>
            <img
              src='/sk/image/display?fileName=${goods.GOODS_IMAGE_STD}'
              style="width: 14rem"
            />
            <div class="ms-5 align-self-center">
              <p style="font-weight: 700">${goods.BRAND_NAME}</p>
              <p>${goods.TOTAL_GOODS_NAME} / ${goods.TOTAL_GOODS_MODEL}</p>
              <p style="font-weight: 700; font-size: large">${goods.TOTAL_GOODS_PRICE}</p>
            </div>
          </a>
        </div>
    </c:forEach>
    </div>

        <!--상품 검색결과 더보기 시작-->
        <div class="row">
		          <a href="#" class="ms-4" style="font-weight: 500" id="goodsMore">
		          	<p>검색결과 더보기<i class="bi bi-chevron-down ms-2"></i></p>
		          </a>
		        <div id="goodsNotFoundDiv">
			        <c:if test="${fn:length(goodsList) == 0 }">
					    <p class="ms-4" style="font-weight: 500">해당 상품 검색결과가 없습니다.</p>
					</c:if>
				</div>
          <hr/>
        </div>
        <!--상품 검색결과 더보기 끝-->
      </div>
      <!--상품 검색결과 리스트 끝-->

      <!--매장 검색결과 리스트 시작-->
      <div class="row mt-5">
        <h5 class="mb-3" style="font-weight: 700">매장 검색결과</h5>
        <hr />
        
<form id='sInfo'>  
	<c:forEach begin="0" end="3" var="shopList" items="${shopList}" varStatus="status">
          <div class="row mt-2 mb-2 shopCnt">
            <div class="col-2 align-self-center text-center">
              <p class="fw-semibold" style="font-size: large">${shopList.SHOP_NAME}</p>
            </div>
            <div class="col-10">
              <div class="row">
                <div class="col-2">
                  <p style="font-weight: 500">전화번호</p>
                </div>
                <div class="col-4">
                  <p>${shopList.SHOP_TEL}</p>
                </div>
                <div class="col-2">
                  <p style="font-weight: 500">영업시간</p>
                </div>
                <div class="col-4">
                  <p>${shopList.SHOP_START_TIME} ~ ${shopList.SHOP_END_TIME}</p>
                </div>
              </div>

              <div class="row mt-3">
                <div class="col-2">
                  <p style="font-weight: 500">주소</p>
                </div>
                <div class="col-4">
                  <p>${shopList.SHOP_ADD}</p>
                </div>
                <div class="col-2">
                  <p style="font-weight: 500">브랜드명</p>
                </div>
                <div class="col-4">
                  <p>${shopList.SHOP_BRAND}</p>
                </div>
              </div>
            </div>
          </div>
        <hr /> 
	</c:forEach>
</form>

        <!--매장 검색결과 더보기 시작-->
        <div class="row">
			       <a href="#" class="ms-4" style="font-weight: 500" id='shopMore'>
			          <p>검색결과 더보기<i class="bi bi-chevron-down ms-2"></i></p>
			       </a>
			     <div id="shopNotFoundDiv">
			     	<c:if test="${fn:length(shopList) == 0 }">
			     	     <p class="ms-4" style="font-weight: 500">해당 매장 검색결과가 없습니다.</p>
			     	</c:if>
			     </div>
          <hr />
        </div>
        <!--매장 검색결과 더보기 끝-->
      </div>
      <!--매장 검색결과 리스트 끝-->
    </div>
  </body>
  
<script type="text/javascript">
$(document).ready(function() {
	
	var values2 = ${goodsJson};
	var values3 = ${shopJson};
	
	console.log(values2);
	console.log(values3);
	
	var goodsLength = ${fn:length(goodsList)};
	var shopLength = ${fn:length(shopList)};
	
	if(goodsLength <= 4) {
		$("#goodsMore").hide();
	}
	
	if(shopLength <= 4) {
		$("#shopMore").hide();
	}
	
	$("a[name='bDetail']").on("click", function(e) {  //브랜드관으로 넘어가기
		e.preventDefault();
		const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
		fn_bDetail(num); //fn_bDetail()함수 매개변수로 num 전송
		location.href="/sk/brand/main?BRAND_NUM=" + num;
	});
	
	function fn_bDetail(num) {  //num 매개변수로 넣기
		  var formData = new FormData();
	      var BRAND_NUM = num;
	      formData.append("BRAND_NUM", BRAND_NUM);
	};
	
	$("#gInfo").on("click", "a[name='gDetail']", function(e) {  //상품 상세보기 페이지로 넘어가기
		e.preventDefault();
		const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
		fn_gDetail(num); //fn_gDetail()함수 매개변수로 num 전송
		location.href="/sk/goods/goodsDetail?TOTAL_GOODS_NUM=" + num;
	});
	
 	function fn_gDetail(num) {  //num 매개변수로 넣기
		  var formData = new FormData();
	      var TOTAL_GOODS_NUM = num;
	      formData.append("TOTAL_GOODS_NUM", TOTAL_GOODS_NUM);
	}; 
	
	$("#totalSearchForm").on("submit", function(e) {
		e.preventDefault();
		fn_searchBtn();
	});
	
	function fn_searchBtn() {
		var formData = new FormData();
		var keyword = $('#keyword').val();
		
		formData.append("keyword", keyword);
		
		$.ajax({
			url: '/sk/totalSearch_ajax',
			type: 'POST',
			data: formData,
			processData: false,
			contentType: false,
			success: function(data) {
				console.log(data);
				value = data.keyword;
				
				var str = "";
				str += "<h2 id='searchKeyword' style='font-weight: 700'>검색어: " +value+ "</h2>";
				$("#searchKeyword").empty();
				$("#searchKeyword").prepend(str);
				
				//각 vlalues에 가져온 list data넣어주기
				values = data.brandList;
				values2 = data.goodsList;
				values3 = data.shopList;
				
				console.log(values2);
				console.log(values3);
				
				//기존의 list 비우고
				$("#bInfo").empty();
				$("#gInfo").empty();
				$("#sInfo").empty();
				
				//index[0]부터 value 넣어서 반복문 돌려주기
				$.each(values, function(index, value) {
					var bNum = value.BRAND_NUM;
					var bName = value.BRAND_NAME;
					var bLogo = value.BRAND_LOGO_FILE;
					
					var b = "";
					b += "<div class='col-2 d-flex mb-2'>";
					b += "<a href='#' class='d-flex' name='bDetail' data-num='"+ bNum +"'>";
					b += "<img src='/sk/image/display?fileName=" + bLogo + "' class='img-thumbnail' style='height: 5rem; width: 6rem'/>";
					b += "<h6 class='ms-3 mb-0 align-self-center' style='font-weight: 700; font-size: 18px'>";
					b +=  bName + "<i class='bi bi-chevron-right' style='font-weight: 700'></i>";
					b += "</h6>";
					b += "</a>";
					b += "</div>";
	            
                $("#bInfo").prepend(b);
                
              //ajax로 검색할 경우 ajax내부에 클릭 함수를 넣어줘야됨
                $("a[name='bDetail']").on("click", function(e) {  //브랜드관으로 넘어가기
					e.preventDefault();
					const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
					fn_bDetail(num); //fn_bDetail()함수 매개변수로 num 전송
					location.href="/sk/brand/main?BRAND_NUM=" + num;
				});
              
				});
				
				//values2 배열?리스트?의 크기가 0,1,2,3으로 4개 이하면 더보기 버튼 숨기기
				if(values2.length <= 4) {
					$("#goodsMore").hide();
				} else { //5개 부터 더보기 버튼 보여주기
					$("#goodsMore").show();
				}
				
				
				if(values2.length == 0) {
					$("#goodsNotFoundDiv").empty();
					var strp = '<p class="ms-4" style="font-weight: 500">해당 상품 검색결과가 없습니다.</p>';
					$("#goodsNotFoundDiv").append(strp);
				} else {
					$("#goodsNotFoundDiv").empty();
					$.each(values2, function(index, value) {
		                console.log("GOODS " + index + " : " + value); //로그 한번 찍어주고 근데 값이 Object로 나옴..
		                
		                //value값에 맞는 변수명 설정해주고..
		                var gNum = value.TOTAL_GOODS_NUM;
						var bName = value.BRAND_NAME;
						var gImg = value.GOODS_IMAGE_STD;
						var gName = value.TOTAL_GOODS_NAME;
						var gModel = value.TOTAL_GOODS_MODEL;
						var gPrice = value.TOTAL_GOODS_PRICE;
						
						//위 변수 넣고 돌려
				        var g = "";
				            g +="<div class='col-6 mt-4 mb-4 d-flex goodsCnt'>";
				            g +=  "<a href='#' class='d-flex' name='gDetail' data-num='"+ gNum +"'>";
				            g += "<img src='/sk/image/display?fileName=" + gImg + "'";
				            g +=    "style='width: 14rem'/>";
				            g +=  "<div class='ms-5 align-self-center'>";
				            g +=   "<p style='font-weight: 700'>" + bName + "</p>";
				            g +=  "<p>" + gName + "/" + gModel + "</p>";
				            g +=  "<p style='font-weight: 700; font-size: large'>" + gPrice + "</p>";
				            g += "</div>";
				            g += "</a>";
				            g +="</div>";
				                
				            $("#gInfo").prepend(g);
				           	
				            //index가 0,1,2,3해서 4개만 출력하고 이 반복문이 빠져나오고 아래서 계속
				            if(index == 3) {
				                return false;
				             }
				            
				            $("#gInfo").on("click", "a[name='gDetail']", function(e) {  //상품 상세보기 페이지로 넘어가기
			            		e.preventDefault();
			            		const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
			            		fn_gDetail(num); //fn_gDetail()함수 매개변수로 num 전송
			            		location.href="/sk/goods/goodsDetail?TOTAL_GOODS_NUM=" + num;
			            	});
					});
				}
				//index[0]부터 value 넣어서 반복문 돌려주기
	            
	                
				//위 처럼 똑같이 버튼 숨기고 보여주고 하기
	            if(values3.length <= 4) {
					$("#shopMore").hide();
				} else {
					$("#shopMore").show();
				}    
                
				if(values3.length == 0) {
					$("#shopNotFoundDiv").empty();
					var strp2 = '<p class="ms-4" style="font-weight: 500">해당 매장 검색결과가 없습니다.</p>';
					$("#shopNotFoundDiv").append(strp2);
				} else {
					$("#shopNotFoundDiv").empty();
					$.each(values3, function(index, value) {
	                	console.log("SHOP " + index + " : " + value);
	                	
						var sBrand = value.SHOP_BRAND;
						var sName = value.SHOP_NAME;
						var sTel = value.SHOP_TEL;
						var sAdd = value.SHOP_ADD;
						var sOpen = value.SHOP_START_TIME;
	                    var sClose = value.SHOP_END_TIME;
	                
	                var s = "";
	                s+="<div class='row mt-2 mb-2 shopCnt'>";
	                s+="  <div class='col-2 align-self-center text-center'>";
	                s+="    <p class='fw-semibold' style='font-size: large'>"+sName+"</p>";
	                s+=" </div>";
	                s+="  <div class='col-10'>";
	                s+="    <div class='row'>";
	                s+="      <div class='col-2'>";
	                s+="        <p style='font-weight: 500'>전화번호</p>";
	                s+="   </div>";
	                s+="   <div class='col-4'>";
	                s+="     <p>"+sTel+"</p>";
	                s+="   </div>";
	                s+="   <div class='col-2'>";
	                s+="  <p style='font-weight: 500'>영업시간</p>";
	                s+="      </div>";
	                s+="   <div class='col-4'>";
	                s+="     <p>"+sOpen+ " ~ " +sClose+"</p>";
	                s+="   </div>";
	                s+="    </div>";
	                s+="    <div class='row mt-3'>";
	                s+="    <div class='col-2'>";
	                s+="     <p style='font-weight: 500'>주소</p>";
	                s+="   </div>";
	                s+="   <div class='col-4'>";
	                s+="     <p>"+sAdd+"</p>";
	                s+="   </div>";
	                s+="   <div class='col-2'>";
	                s+="     <p style='font-weight: 500'>브랜드명</p>";
	                s+="   </div>";
	                s+="   <div class='col-4'>";
	                s+="    <p>"+sBrand+"</p>";
	                s+="      </div>";
	                s+=" </div>";
	                s+="  </div>";
	                s+="</div>";
	                s+="<hr />";
	                
	                $("#sInfo").prepend(s);
		                if(index == 3) {
		                	return false;
		                }
					});
				}
                
			},
			error: function(jqXHR, textStatus, errorThrown) {
		        console.log('Ajax request failed: ' + textStatus + ', ' + errorThrown);
		    }
		});
	};
	
	$("#goodsMore").on("click", function(e) {
		e.preventDefault();
		fn_goodsMore();
	});
	
	function fn_goodsMore() {
		let startNum = $(".goodsCnt").length;
		 
	    console.log("'goodsMore' startNum", startNum);
	    
	    if(values2.length-startNum <= 4){
            $("#goodsMore").remove();   
        }
            for(var i=0; i<4; i++) {
            	var num = Number(startNum)+Number(i);
            	
            	var bName = values2[num].BRAND_NAME;
				var gImg = values2[num].GOODS_IMAGE_STD;
				var gName = values2[num].TOTAL_GOODS_NAME;
				var gModel = values2[num].TOTAL_GOODS_MODEL;
				var gPrice = values2[num].TOTAL_GOODS_PRICE;
				var g = ""; 
                g +="<div class='col-6 mt-4 mb-4 d-flex goodsCnt'>";
                g +=  "<a href='#' class='d-flex' name='gDetail' data-num='${goods.TOTAL_GOODS_NUM}'>";
                g += "<img src='/sk/image/display?fileName=" + gImg + "'";
                g +=    "style='width: 14rem'/>";
                g +=  "<div class='ms-5 align-self-center'>";
                g +=   "<p style='font-weight: 700'>" + bName + "</p>";
                g +=  "<p>" + gName + "/" + gModel + "</p>";
                g +=  "<p style='font-weight: 700; font-size: large'>" + gPrice + "</p>";
                g += "</div>";
                g += "</a>";
                g +="</div>";
                
                $("#gInfo").append(g);
            }
	}
	
	 $("#shopMore").on("click", function(e) {
		e.preventDefault();
		fn_shopMore();
	});
	
	function fn_shopMore() {
		let startNum = $(".shopCnt").length;
	    console.log("SHOPlist 크기", startNum);
	    
	    if(values3.length-startNum <= 4){
            $("#shopMore").remove();
        }
            for(let i=0; i<4; i++) {
            	var num = Number(startNum)+Number(i);
            	
            	var sBrand = values3[num].SHOP_BRAND;
            	var sName = values3[num].SHOP_NAME;
            	var sTel = values3[num].SHOP_TEL;
            	var sAdd = values3[num].SHOP_ADD;
            	var sOpen = values3[num].SHOP_START_TIME;
            	var sClose = values3[num].SHOP_END_TIME;
                
				var s = "";
	              s+="<div class='row mt-2 mb-2 shopCnt'>";
	              s+="  <div class='col-2 align-self-center text-center'>";
	              s+="    <p class='fw-semibold' style='font-size: large'>"+sName+"</p>";
	              s+=" </div>";
	              s+="  <div class='col-10'>";
	              s+="    <div class='row'>";
	              s+="      <div class='col-2'>";
	              s+="        <p style='font-weight: 500'>전화번호</p>";
	              s+="   </div>";
	              s+="   <div class='col-4'>";
	              s+="     <p>"+sTel+"</p>";
	              s+="   </div>";
	              s+="   <div class='col-2'>";
	              s+="  <p style='font-weight: 500'>영업시간</p>";
	              s+="      </div>";
	              s+="   <div class='col-4'>";
	              s+="     <p>"+sOpen+ " ~ " +sClose+"</p>";
	              s+="   </div>";
	              s+="    </div>";
	              s+="    <div class='row mt-3'>";
	              s+="    <div class='col-2'>";
	              s+="     <p style='font-weight: 500'>주소</p>";
	              s+="   </div>";
	              s+="   <div class='col-4'>";
	              s+="     <p>"+sAdd+"</p>";
	              s+="   </div>";
	              s+="   <div class='col-2'>";
	              s+="     <p style='font-weight: 500'>브랜드명</p>";
	              s+="   </div>";
	              s+="   <div class='col-4'>";
	              s+="    <p>"+sBrand+"</p>";
	              s+="      </div>";
	              s+=" </div>";
	              s+="  </div>";
	              s+="</div>";
	              s+="<hr />";
	              
              $("#sInfo").append(s);
            }
	}
});
</script>
</html>