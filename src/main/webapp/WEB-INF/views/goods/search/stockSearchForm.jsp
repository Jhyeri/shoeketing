<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	.container {
        width: 1200px; /*기본값 1500px*/
        max-width: none !important;
      }
</style>
<body>
<!-- pickUpDateModal -->
    <div
      class="modal fade"
      id="pickUpDateModal"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">
              픽업 시작 날짜 선택
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
          <form id="">
            <input type="date" class="form-control" id="RESERVATION_PICKUP_DATE" name="RESERVATION_PICKUP_DATE"/>
          	<input type="hidden" id="RESERVATION_PRONUM" name="RESERVATION_PRONUM" value="">
          	<input type="hidden" id="TOTAL_GOODS_NAME" name="TOTAL_GOODS_NAME" value="">
          	<input type="hidden" id="RESERVATION_SHOP_NUM" name="RESERVATION_SHOP_NUM" value="">
        	<input type="hidden" id="RESERVATION_SIZE" name="RESERVATION_SIZE" value="">
          	
          </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              취소
            </button>
            <!-- 토스 페이먼츠 API -->
            <div id="payment-method"></div>
            <button type="button" class="btn btn-primary" id="payment-button">예약하기</button>
            <!-- 토스 페이먼츠 API 끝-->
          </div>
        </div>
      </div>
    </div>
    
    <!-- CSModal -->
    <div
      class="modal fade"
      id="CSModal"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">매장 문의</h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <form id="csForm">
              <div class="d-flex">
                <label
                  for="CS_TITLE"
                  class="form-label align-self-center mb-0"
                  style="width: 5rem; font-weight: 500"
                  >제목</label
                >
                <input
                  type="text"
                  class="form-control"
                  id="CS_TITLE"
                  name="CS_TITLE"
                  placeholder="제목을 입력해주세요"
                  required
                />
              </div>

              <hr/>

              <div class="d-flex">
                <label
                  for="CS_CONTENT"
                  class="form-label"
                  style="width: 5rem; font-weight: 500"
                  >내용</label
                >
                <textarea
                  class="form-control"
                  id="CS_CONTENT"
                  name="CS_CONTENT"
                  rows="8"
                  placeholder="내용을 입력해주세요"
                  required
                ></textarea>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              취소
            </button>
            <button type="button" id="csWriteBtn" class="btn btn-primary">문의작성</button>
          </div>
        </div>
      </div>
    </div>

    <div class="container">
      <div class="row mt-5">
      <form id="findStockForm">
        <h3 class="mb-4" style="font-weight: 700">실시간 재고 검색</h3>

        <div class="d-flex mb-4">
          <div class="col-3 d-flex me-5">
            <label
              for="BRAND_NAME"
              class="form-label align-self-center mb-0"
              style="width: 5rem; font-weight: 500"
              >브랜드</label
            >
            <input
              type="text"
              class="form-control"
              id="BRAND_NAME"
              name="BRAND_NAME"
              value="${brandName }"
              placeholder="브랜드명을 입력해주세요"
              required
            />
          </div>

          <div class="col-3 d-flex me-5">
            <label
              for="GOODS_NAME"
              class="form-label align-self-center mb-0"
              style="width: 5rem; font-weight: 500"
              >제품명</label
            >
            <input
              type="text"
              class="form-control"
              id="GOODS_NAME"
              name="GOODS_NAME"
              value="${goodsName }"
              placeholder="상품명을 입력해주세요"
              required
            />
          </div>

          <div class="col-3 d-flex me-5">
            <label
              for="GOODS_SIZE"
              class="form-label align-self-center mb-0"
              style="width: 5rem; font-weight: 500"
              >사이즈</label
            >
            <input
              type="text"
              class="form-control"
              id="GOODS_SIZE"
              name="GOODS_SIZE"
              value="${goodsSize }"
              placeholder="사이즈를 입력해주세요"
              required
            />
          </div>
        </div>

        <div class="d-flex">
          <div class="d-flex">
            <label
              for="SHOP_NAME"
              class="form-label align-self-center mb-0"
              style="width: 5rem; font-weight: 500"
              >매장</label
            >
            <input
              type="text"
              class="form-control"
              id="SHOP_NAME"
              name="SHOP_NAME"
              placeholder="매장명을 입력해주세요(선택)"
            />
            <button
              class="btn btn-secondary ms-3"
              name="searchShop"
              type="button"
              style="width: 8rem"
            >
              매장검색
            </button>
          </div>
        </div>
        </form>
      </div>

	<div id="shopListDiv">
      <!-- 검색한 매장 리스트 위치 -->
    </div>
    
    	<!-- 페이징 화면 처리 부분 시작 -->
    	<div class="row">
	      	<div id="PAGE_NAVI"></div>
			<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
		</div>
		<!-- 페이징 화면 처리 부분 끝 -->

      <!--카카오 지도 API 적용 div-->
      <div class="row justify-content-center">
      	<div id="map" style="width: 900px; height: 600px"></div>
      </div>
      <!--카카오 지도 API 적용 div 끝-->
    </div>
    
  </body>
  
  
  <script
    type="text/javascript"
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08e2c5126e1c7f5ac14b68c3f37365ad"
  ></script>
  
  <script>
$(document).ready(function() {
	$("button[name='searchShop']").on("click", function(e) {
		  fn_selectShopList(1);
	  });
	
	$("#shopListDiv").on("click", "a", function(e) {
		  e.preventDefault();
		  const shopNum = $(this).attr('data-num');
		  const goodsAmount = $(this).attr('data-amount');
		  const goodsNum = $(this).attr('data-goods_num');
		  const goodsName = $(this).attr('data-goods_name');
		  const goodsSize = $(this).attr('data-goods_size');
		  
		  $('#RESERVATION_PRONUM').val(goodsNum);
		  $('#TOTAL_GOODS_NAME').val(goodsName);
		  $('#RESERVATION_SHOP_NUM').val(shopNum);
		  $('#RESERVATION_SIZE').val(goodsSize);
		  
		  var formData2 = new FormData();
		  formData2.append("SHOP_NUM", shopNum);
		  
		  $.ajax({
				url : "/sk/goods/stockShopInfo",
				type : "post",
				data : formData2,
				contentType : false,
				processData : false,
				success : function(data) {
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
							// ####### 좌표 입력1 #########
					    center: new kakao.maps.LatLng(data.SHOP_POS2, data.SHOP_POS1), // 지도의 중심좌표 SHOP_POS2, SHOP_POS1 값 넣어주기
					    level: 3 // 지도의 확대 레벨
					};
					
					var map = new kakao.maps.Map(mapContainer, mapOption);
					
					//마커가 표시될 위치입니다 ####### 좌표 입력2 #########
					var markerPosition  = new kakao.maps.LatLng(data.SHOP_POS2, data.SHOP_POS1); //SHOP_POS2, SHOP_POS1 값 넣어주기
					
					//마커를 생성합니다
					var marker = new kakao.maps.Marker({
					  position: markerPosition
					});
					
					//마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					
					//############### 매장 정보가 들어갈 공간 ###################
					
					var iwContent;
					if(goodsAmount > 0){  // 재고 > 0 일경우 (재고가 있을경우 픽업예약버튼, 장바구니 버튼 표시O)
					iwContent = `<div
				        style="
				          padding: 15px 20px 20px 15px;
				          width: 400px;
				          height: 250px;
				          box-shadow: 2px 2px 2px 2px gray;
				          border: none;
				        "
				      >
				        <h4 class="mb-4" style="font-weight: 700">`+data.SHOP_NAME+`</h4>
				        <p class="mb-1">`+data.SHOP_ADD+`</p>
				        <p style="color: forestgreen">`+data.SHOP_TEL+`</p>
				        <h5 style="font-weight: 700">`+goodsName+` (`+goodsSize+`)</h5>
				        <h6 style="font-weight: 700">재고 : `+goodsAmount+`</h6>
				        <div class="d-flex justify-content-between">
				          <a href="#" class="align-self-center" data-bs-toggle="modal"
				              data-bs-target="#CSModal">문의하기</a>
				          <div>
				            <button
				              class="button"
				              type="button"
				              style="border: 1px solid rgba(0, 0, 0, 0.116)"
				              data-bs-toggle="modal" data-bs-target="#pickUpDateModal"
				              data-shop_num=
				            >
				              픽업예약
				            </button>
				            <button
				              id="basketBtn"
				              class="button"
				              type="button"
				              style="border: 1px solid rgba(0, 0, 0, 0.116)"
				            >
				              장바구니
				            </button>
				          </div>
				        </div>
				      </div>`
					} else{  // 재고 = 0 일경우 (재고가 없을경우 픽업예약버튼, 장바구니 버튼 표시X)
						iwContent = `<div
					        style="
					          padding: 15px 20px 20px 15px;
					          width: 400px;
					          height: 250px;
					          box-shadow: 2px 2px 2px 2px gray;
					          border: none;
					        "
					      >
					        <h4 class="mb-4" style="font-weight: 700">`+data.SHOP_NAME+`</h4>
					        <p class="mb-1">`+data.SHOP_ADD+`</p>
					        <p style="color: forestgreen">`+data.SHOP_TEL+`</p>
					        <h5 style="font-weight: 700">`+goodsName+` (`+goodsSize+`)</h5>
					        <h6 style="font-weight: 700">재고 : `+goodsAmount+`</h6>
					        <div class="d-flex justify-content-between">
					          <a href="#" class="align-self-center" data-bs-toggle="modal"
					              data-bs-target="#CSModal">문의하기</a>
					          <div>
					          </div>
					        </div>
					      </div>`
					}// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				      //####### 좌표 입력3 #########
					  iwPosition = new kakao.maps.LatLng(data.SHOP_POS2, data.SHOP_POS1); //인포윈도우 표시 위치입니다 SHOP_POS2, SHOP_POS1 값 넣어주기
					//############### 매장 정보가 들어갈 공간 끝 ###################
					
					//인포윈도우를 생성합니다
					var infowindow = new kakao.maps.InfoWindow({
					  position : iwPosition, 
					  content : iwContent 
					});
					
					//마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
					infowindow.open(map, marker);
				}
			 });
		  
	  });
	
	
});
  
	//페이징 함수
	function fn_selectShopList(pageNo){
		var comAjax = new ComAjax();
		comAjax.setUrl("/sk/goods/stockSearch");
		comAjax.setCallback("fn_selectShopListCallback");
		comAjax.addParam("PAGE_INDEX",pageNo);
		comAjax.addParam("PAGE_ROW", 9); //한 페이지에 보여줄 게시글 수 정하기
		comAjax.addParam("BRAND_NAME", $("#BRAND_NAME").val());
		comAjax.addParam("GOODS_NAME", $("#GOODS_NAME").val());
		comAjax.addParam("GOODS_SIZE", $("#GOODS_SIZE").val());
		comAjax.addParam("SHOP_NAME", $("#SHOP_NAME").val());
		comAjax.ajax();
	}
	
	// 페이징 콜백 함수
	function fn_selectShopListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
		var total = data.TOTAL;
		var body = $("#shopListDiv"); // 페이징 한 결과가 반영될 태그
		
		body.empty();
		var str = '<table class="table table-bordered text-center mt-5"';
		str += 'style="border-left-color: white; border-right-color: white">';
		str += '<thead><tr style="font-size: 12px; font-weight: 400">';
		str += '<th class="col-3" scope="col">매장명</th>';
		str += '<th class="col-1" scope="col" style="border-right-color: rgba(0, 0, 0, 0.121)">재고보유여부</th>';
		str += '<th class="col-3" scope="col">매장명</th>';
		str += '<th class="col-1" scope="col" style="border-right-color: rgba(0, 0, 0, 0.121)">재고보유여부</th>';
		str += '<th class="col-3" scope="col">매장명</th>';
		str += '<th class="col-1" scope="col">재고보유여부</th>';
		str += '</tr></thead><tbody class="table-group-divider">';
		
		if(total == 0){ // 결과가 없을 경우
			str += '<tr><td colspan="6">검색하신 재고를 보유하는 매장이 존재하지 않습니다.</td></tr></tbody></table>';
			body.append(str);
			$("#PAGE_NAVI").empty();
		} else { // 결과가 있을 경우
			var params = {
				divId : "PAGE_NAVI",
				pageIndex : "PAGE_INDEX",
				totalCount : total,
				recordCount : 9,
				eventName : "fn_selectShopList" // 페이징 함수이름 동일하게
			};
			gfn_renderPaging(params);
			
			for(var i=1; i<=(data.list.length-1)/3+1; i++) {
				str += '<tr>';
			
				for(var j=i*3-2; j<=i*3; j++) {
					var json = data.list[j-1];
					if(json == null) {
						break;
					}
					if(json.SHOP_NAME != null) {
						str += '<th scope="row">';
						str += '<a name="shopName" data-num="';
						str += json.SHOP_NUM;
						str += '" data-amount="';
						str += json.SHOP_GOODS_AMOUNT;
						str += '" data-goods_name="';
						str += json.TOTAL_GOODS_NAME;
						str += '" data-goods_size="';
						str += json.SHOP_GOODS_SIZE;
						str += '" data-goods_num="';
						str += json.TOTAL_GOODS_NUM;
						str += '" style="cursor:pointer;">';
						str += json.SHOP_NAME;
						str += ' (';
						str += json.TOTAL_GOODS_NAME;
						str += ')</a></th>';
					} else if(json.SHOP_NAME == null) {
						str += '<th scope="row"></th>';
					}
					
					if(json.SHOP_NAME != null) {
						if(json.SHOP_GOODS_AMOUNT == 0) {
							str += '<td style="border-right-color: rgba(0, 0, 0, 0.121)">X</td>';
						} else if(json.SHOP_GOODS_AMOUNT != 0) {
							str += '<td style="border-right-color: rgba(0, 0, 0, 0.121)">O</td>';
						}
					} else {
						str += '<td style="border-right-color: rgba(0, 0, 0, 0.121)"></td>';
					}
				}
				
				str += '</tr>';
			}
			
			body.append(str);
			
		}
	}
	
	$("#map").on("click", "#basketBtn", function(e) {
		
			var formData = new FormData();
			var TOTAL_GOODS_NUM = $('#RESERVATION_PRONUM').val();
			var SHOP_NUM = $('#RESERVATION_SHOP_NUM').val();
			var BASKET_SIZE = $('#RESERVATION_SIZE').val();
			
			formData.append("TOTAL_GOODS_NUM", TOTAL_GOODS_NUM);
			formData.append("SHOP_NUM", SHOP_NUM);
			formData.append("BASKET_SIZE", BASKET_SIZE);
			
			$.ajax({
				url : '/sk/basket/basketAdd',
				type : 'post',
				data : formData,
				contentType : false,
				processData : false,
				success : function(data) {
					if(data.result == 'success') {
						if(confirm('상품이 장바구니에 성공적으로 추가되었습니다.\n장바구니로 이동하시겠습니까?')){
							location.href='/sk/basket/basketList';
						}
					} else if(data.result == 'full') {
						alert('더이상 장바구에 상품을 추가할 수 없습니다.\n장바구니에는 상품을 최대 10개까지 추가할 수 있습니다.')
					} else {
						alert('상품을 장바구니에 추가하는 과정에서 오류가 발생했습니다.');
					}
				},
				fail : function() {
					alert("서버 오류");
				}
			});
		
	});
	
	$("#csWriteBtn").on("click", function(e) {
		var shopNum = $('#RESERVATION_SHOP_NUM').val();
		var formData = new FormData(document.getElementById('csForm'));
		formData.append("CS_SHOP_NUM", shopNum);
		
		$.ajax({
			url : '/sk/myPage/csWrite',
			type : 'post',
			data : formData,
			contentType : false,
			processData : false,
			success : function(data) {
				alert('매장 문의가 성공적으로 작성되었습니다.');
				$("#CSModal").modal('hide');
			}
		});
	});
	
</script>
	  
	   <!-- 토스 페이먼츠 API -->
	  <script src="https://js.tosspayments.com/v1/payment-widget"></script>
	  
	  <script>
	  
	  //토스 페이먼츠 결제  (추후 orderId, orderName, customerEmail, customerName 수정필요)
	  const clientKey = 'test_ck_7XZYkKL4Mrjnv7vJl1ar0zJwlEWR';
	  const customerKey = 'user123'; 
	  const paymentWidget = PaymentWidget(clientKey, customerKey);  // 결제위젯 초기화
	  
	  $("#payment-button").on("click", function(e){
		  
		var orderId = null;
		
		$.ajax({
			
		});
		  
		var goodsNum = $('#RESERVATION_PRONUM').val();
		var goodsName = $('#TOTAL_GOODS_NAME').val();
		var shopNum = $('#RESERVATION_SHOP_NUM').val();
		var goodsSize = $('#RESERVATION_SIZE').val();
		var pickupDate = $("#RESERVATION_PICKUP_DATE").val();
		
		// 등급별 픽업 예약금
		if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "골드"){
			paymentWidget.renderPaymentMethods('#payment-method', 30000);
		}else if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "플래티넘"){
			paymentWidget.renderPaymentMethods('#payment-method', 27000);
		}else if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "다이아"){
			paymentWidget.renderPaymentMethods('#payment-method', 25000);
		}
	  	
	  	paymentWidget.requestPayment({
	    	  orderId: 5675262,   // selectKey로 max 예약번호 가져와서 가져다쓰기!!!!! 구현필요
	    	  orderName: goodsName,
	    	  successUrl: 'http://localhost:8080/sk/tossPaymentsSuccess?goodsNum=' + goodsNum + '&shopNum=' + shopNum + '&goodsSize=' + goodsSize + '&pickupDate=' + pickupDate,
	    	  failUrl: 'http://localhost:8080/sk',
	    	  customerEmail: '${MEM_EMAIL}', 
	    	  customerName: '${MEM_NAME}'
	    	});


  });

	
  </script>
</html>