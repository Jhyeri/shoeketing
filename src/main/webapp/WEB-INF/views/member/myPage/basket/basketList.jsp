<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function fn_chkDelete(num) { //상품 삭제 함수
	//함수 호출 시 파라미터 num이 들어오면 개별삭제버튼을 클릭한 것이고, 파라미터가 들어오지 않으면 전체 삭제버튼을 클릭한 것
	var basketNum = $("#chk").val(); 
	var goodsArr = [];
	var list = $("input[name='chk']");
	
	if(num == null || num == 0) { //파라미터가 없으면
		for(var i=0; i<list.length; i++) { //체크박스의 개수만큼 반복
				if(list[i].checked) { //체크되어 있으면
					goodsArr.push(list[i].value); //배열에 value(basket_num)을 넣음
			}
		}
	} else {//파라미터가 있으면
		goodsArr.push(num); //파라미터로 온 basket_num 하나를 배열에 저장
	}
		
		if(goodsArr.length == 0) {
			alert("선택된 상품이 없습니다.");
		} else {
			if(confirm("상품을 장바구니에서 제거하시겠습니까?")) {
				$.ajaxSettings.traditional = true;
				$.ajax({
				url:"/sk/basket/basketDelete",
				type:'post',
				contentType:"application/json; charset=UTF-8",
				data:JSON.stringify(goodsArr),
				success:function() {
					alert("상품을 장바구니에서 삭제하였습니다.");
					location.reload(); //페이지 새로고침
				},
				error:function() {
					alert("잠시 후 다시 시도해주세요.");
				}	
				});
				}
			}
	}
	
function fn_pickupDateone(name, model, shopName, size, num, shopNum) { //개별 예약 진행
	
	if(confirm("해당 상품의 픽업예약을 진행하시겠습니까?")) {
	
		var str = "";
	
		str += "<div class='row ms-3 me-3 mb-3 p-3' style='border: 1px solid rgba(0, 0, 0, 0.228); border-radius: 12px; background-color: rgba(0, 0, 0, 0.05);'>";
		str += "<div class='d-flex justify-content-between'>";
		str += "<h6>" + name + " / " + model + "</h6>";
		str += "<p class='mb-1'>" + size + "</p>";
		str += "</div>";
		str += "<p class='mb-2' style='font-size: small;'>" + shopName + "</p>";
		str += "<input class='form-control' type='date' id='date1' />";
		str += "</div>";
	
		$(".modal-body").html(str);
		
		$("#pickupDateModal").modal("show");
		
		document.querySelector('#payment-button').setAttribute("id", "payment-button1");
		
		$("#payment-button1").on("click", function(e) {
			let date = $("#date1").val();
			
			fn_paymentone(name, model, shopName, size, num, shopNum, date);
		});
		
	}
}

</script>

<!-- 토스 페이먼츠 API -->
<script src="https://js.tosspayments.com/v1/payment-widget"></script>

<script>

function fn_paymentone(name, model, shopName, size, num, shopNum, date) { //개별 결제 진행
	const clientKey = 'test_ck_7XZYkKL4Mrjnv7vJl1ar0zJwlEWR';
	const customerKey = 'user123'; 
	const paymentWidget = PaymentWidget(clientKey, customerKey);  // 결제위젯 초기화
	
	let max = "${orderId}"; //가장 최신의 주문번호를 가져옴

	if(max == 0) {
		max = 10000000;
	}
	
	let orderId = Number(max) + 124; //새로운 주문번호 생성
	
	var goodsNum = num;
	var goodsName = name;
	var shopNum = shopNum;
	var goodsSize = size;
	var pickupDate = date;
	
	// 등급별 픽업 예약금 
	if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "골드"){
		paymentWidget.renderPaymentMethods('#payment-method', 30000);
	}else if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "플래티넘"){
		paymentWidget.renderPaymentMethods('#payment-method', 27000);
	}else if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "다이아"){
		paymentWidget.renderPaymentMethods('#payment-method', 25000);
	}
  	
  	paymentWidget.requestPayment({
    	  orderId: orderId, 
    	  orderName: name,
    	  successUrl: 'http://localhost:8080/sk/tossPaymentsSuccess?goodsNum=' + goodsNum + '&shopNum=' + shopNum + '&goodsSize=' + goodsSize + '&pickupDate=' + pickupDate,
    	  failUrl: 'http://localhost:8080/sk',
    	  customerEmail: '${MEM_EMAIL}', 
    	  customerName: '${MEM_NAME}'
    	});
};
</script>

<style>
.container {
        width: 1200px; /*기본값 1500px*/
        max-width: none !important;
      }

</style>
</head>
<body>

<!-- 장바구니 픽업 시작 날짜 선택 모달 -->
<div class="modal fade" id="pickupDateModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">픽업 시작 날짜 선택</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       <!-- 상품 정보와 날짜선택부분이 추가될 부분  -->
      </div> 
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <!-- 토스 페이먼츠 API -->
        <div id="payment-method"></div>
        <button type="button" class="btn btn-primary" id="payment-button">예약하기</button> 
        <!-- 토스 페이먼츠 API 끝-->
      </div>
    </div>
  </div>
</div>

    <div class="container">
      <h3 class="mb-4 mt-5" style="font-weight: 700" data-num="${orderId}">장바구니</h3>

      <div class="row">
        <div class="form-check col ms-3 align-self-end">
          <input class="form-check-input" type="checkbox" id='selectAll' name="chkAll" onclick='checkAll();' checked/>
          <label class="form-check-label" for="selectAll">전체선택</label>
        </div>
        <div class="col text-end">
          <button class="btn btn-secondary" type="button" id="chkDelete" name="chkDelete">삭제</button>
        </div>
      </div>
      <hr class="mt-3" style="border: 1px solid black;"/>
      
      <!--장바구니 리스트 시작-->
      <div class="row justify-content-center" style="border: 1px solid rgba(0, 0, 0, 0.226)">
      
   	  <c:choose>
      <c:when test="${fn:length(list)>0}">
      <c:forEach items="${list}" var="basket" varStatus="status">
        <!--장바구니 데이터 한줄 시작-->
         <c:choose>
         <c:when test="${basket.SHOP_GOODS_AMOUNT == 0}"> 
	         <style>
				 .soldoutDiv_${basket.BASKET_NUM} {
					opacity:30%;
				}
			</style>
         </c:when>
         <c:when test="${basket.SHOP_GOODS_AMOUNT > 0}"> 
	         <style>
				 .soldoutDiv_${basket.BASKET_NUM} {
					opacity:100%;
				}
			</style>
         </c:when>
         </c:choose>
         <div class="row mt-4 mb-4">
          <div class="col-auto align-self-center ms-2 soldoutDiv_${basket.BASKET_NUM}">
            <div class="form-check">
            	<c:choose>
          			<c:when test="${basket.SHOP_GOODS_AMOUNT > 0}">
              			<input class="form-check-input" id='chk_${status.index }' name="chk" type="checkbox" value="${basket.BASKET_NUM}" data-name="${basket.TOTAL_GOODS_NAME}" data-num="${basket.TOTAL_GOODS_NUM}" data-model="${basket.TOTAL_GOODS_MODEL}"
                		data-shop="${basket.SHOP_NAME}" data-size="${basket.BASKET_SIZE}" data-shopnum="${basket.SHOP_NUM}"/>
            		</c:when>
            		<c:otherwise>
            			<input class="form-check-input" id='chk_${status.index }' name="soldout" type="checkbox" value="${basket.BASKET_NUM}" checked disabled> 
            		</c:otherwise>
         		 </c:choose>
            </div>
          </div>
          <div class="col-2 align-self-center soldoutDiv_${basket.BASKET_NUM}">
            <img
              src="/sk/image/display?fileName=${basket.GOODS_IMAGE_STD}"
              style="width: 10rem"
            />
          </div>
          <div class="col-4 soldoutDiv_${basket.BASKET_NUM}" data-num="${basket.BASKET_NUM}">
            <div class="ms-1 align-self-center" id="goodsInfo">
              <p class="mb-2" style="font-weight: 700">${basket.BRAND_NAME}</p>
              <p class="mb-2" style="font-weight: 700">
                <c:if test="${basket.SHOP_GOODS_AMOUNT > 0}">
                	<a href="#" id="goodsName"
                		>${basket.TOTAL_GOODS_NAME} / ${basket.TOTAL_GOODS_MODEL}</a> 
              	</c:if>
              	 <c:if test="${basket.SHOP_GOODS_AMOUNT == 0}">
              	 	${basket.TOTAL_GOODS_NAME} / ${basket.TOTAL_GOODS_MODEL}
             	</c:if>
              </p>
              <p class="mb-2"> ${basket.SHOP_NAME} - ${basket.SHOP_ADD}</p>
              <p class="mb-2"> ${basket.BASKET_SIZE}</p>
            </div>
          </div>
          <div
            class="col-auto align-self-center text-center soldoutDiv_${basket.BASKET_NUM}"
            style="width: 10rem"
          >
            <h5 class="mb-4">상품가격</h5>
            <div class="d-flex justify-content-center">
              <h5><label for="chk"><fmt:formatNumber type="number" maxFractionDigits="3" value="${basket.TOTAL_GOODS_PRICE}"/></label></h5>
              <h6 class="align-self-end">원</h6>
            </div>
          </div>
          <div
            class="col-auto align-self-center text-center soldoutDiv_${basket.BASKET_NUM}"
            style="width: 10rem"
          >
            <h5 class="mb-4">예약금</h5>
            <div class="d-flex justify-content-center">
              <c:set var="deposit" value="30000"/>	
               <h5 id="deposit"><fmt:formatNumber type="number" maxFractionDigits="3" value="${deposit}"/></h5>
              <h6 class="align-self-end">원</h6>
            </div>
          </div>
          <div
            class="col-auto d-flex align-self-center justify-content-center"
            style="flex-direction: column; width: 13rem"
            id="btnRow"
          >
          <c:choose>
          	<c:when test="${basket.SHOP_GOODS_AMOUNT > 0}">
	          	 <button
	              class="btn btn-sm btn-secondary mb-3 ms-5"
	              type="button"
	              style="width: 5rem"
	              name="pickup"
	              id="pickup"
	              onclick="fn_pickupDateone('${basket.TOTAL_GOODS_NAME}', '${basket.TOTAL_GOODS_MODEL}', '${basket.SHOP_NAME}', '${basket.BASKET_SIZE}', '${basket.TOTAL_GOODS_NUM}', '${basket.SHOP_NUM}');"
	            >
	              픽업예약
	            </button>
          	</c:when>
          	<c:otherwise>
          		<div class="d-flex justify-content-center soldoutDiv_${basket.BASKET_NUM}">
          			 <h6 class="align-self-end" id="notification">재고가 없습니다.</h6>
          		</div>
          	</c:otherwise>
          </c:choose>
	            <button
	              class="btn btn-sm btn-secondary ms-5"
	              type="button"
	              style="width: 5rem;"
	              name="delete"
	              id="delete"
	              onclick="fn_chkDelete(${basket.BASKET_NUM});"
	            >
	              삭제
	            </button>
          </div>
        </div>
        <!--장바구니 데이터 한줄 끝-->
        </c:forEach>
        </c:when>
        <c:otherwise>
          장바구니에 담긴 상품이 없습니다.
          </c:otherwise>
        </c:choose> 
        
      <!--예약금액, 할인금액, 결제금액 시작-->
      <div
        class="row pt-3 pb-3 mb-5"
        style="
          background-color: rgba(0, 0, 0, 0.128);
          border: 1px solid rgba(0, 0, 0, 0.226);
        "
      >
        <div class="col-3 align-self-center text-center">
          <p class="mb-1">예약금액</p>
          <div class="d-flex justify-content-center">
         	 <c:set var="totalDeposit" value="${fn:length(list)*totalDeposit}"/>
            <h4 id="totalDeposit"></h4>
            <h5 class="align-self-end ms-1">원</h5>
          </div>
        </div>

        <div class="col-auto align-self-center">
          <i class="bi bi-dash-circle fs-3"></i>
        </div>

        <div class="col-3 align-self-center text-center">
          <p class="mb-1">할인금액</p>
          <div class="d-flex justify-content-center">
            <c:choose>
          		<c:when test="${session_MEM_INFO.MEM_GRADE=='플래티넘'}">
          			<c:set var="sale" value="3000"/>
            			<h4 id="sale"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sale}"/></h4>
            	</c:when>
            	<c:when test="${session_MEM_INFO.MEM_GRADE=='다이아'}">
            		<c:set var="sale" value="5000"/>
            			<h4 id="sale"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sale}"/></h4>
            	</c:when>
            	<c:otherwise>
            		<h4 id="sale">0</h4>
            	</c:otherwise>
            </c:choose>
           				<h5 class="align-self-end ms-1">원</h5>
          </div>
        </div>

        <div class="col-auto align-self-center">
          <i class="bi bi-chevron-double-right fs-3"></i>
        </div>

        <div class="col-3 align-self-center text-center">
          <p class="mb-1">결제금액</p>
          <div class="d-flex justify-content-center">
            <h4 class="fw-bold" id="finalPrice"></h4>
            <h4 class="align-self-end ms-1 fw-bold">원</h4>
          </div>
        </div>

        <div class="col-auto align-self-center text-center">
          <button
              class="btn btn-sm btn-secondary ms-2"
              type="button"
              style="width: 5rem"
              id="reservationBtn"
            >
            선택 예약
            </button>
        </div>
      </div>
      <!--예약금액, 할인금액, 결제금액 끝-->
    </div>
   </div> 
  </body>
  
<script type="text/javascript">

let pickupInfo = [];
let dateObj = [];

$(document).ready(function() {
	
	checkAll();
	fn_calcPrice();
	
	$("button[name='chkDelete']").on("click", function(e) { //전체 삭제 버튼 누르면
		 e.preventDefault();
		 fn_chkDelete();
	});
	
	$("a[id='goodsName']").on("click", function(e) { //상품명을 클릭하면 상품 상세보기 이동
		 e.preventDefault();
		let goodsNum = $("input[name='chk']").attr("data-num");
		location.href="/sk/goods/goodsDetail?TOTAL_GOODS_NUM="+goodsNum;
	});
	
	$("#reservationBtn").on("click", function(e) { //선택예약 버튼 누르면 
		e.preventDefault();
		fn_pickupDates(); //날짜 선택 모달 함수
	});
	
	
});


function checkAll() { //전체 체크 함수
	if($("#selectAll").is(':checked')) { //체크되어있으면
		$("input[name=chk]").prop("checked", true);
		fn_calcPrice();
	} else {
		$("input[name=chk]").prop("checked", false);
		fn_calcPrice();
	}
}

function fn_calcPrice() {
	var chks = document.getElementsByName("chk");
	var chksChecked = 0;
	
	for(var i=0; i<chks.length; i++) {
	var chk = chks[i];

		if(chk.checked) {
				chksChecked++; //체크된 체크박스의 개수 집계
		}
	}
	
	//예약금, 결제금액 계산 및 출력
	var deposit = ${deposit};
	var totalDeposit = deposit * chksChecked;
	var salePrice = $("#sale").val();
	var finalPrice = totalDeposit - salePrice;
	
	document.getElementById("totalDeposit").innerHTML=totalDeposit.toLocaleString();
	document.getElementById("finalPrice").innerHTML=finalPrice.toLocaleString();
	//금액부분에 연산된 값을 삽입

}

$(document).on("click", "input:checkbox[name=chk]", function(e) { //개별 체크박스 클릭하면
	var chks = document.getElementsByName("chk");
	var chksChecked = 0; 
	
	for(var i=0; i<chks.length; i++) {
	var chk = chks[i];

	if(chk.checked) {
		chksChecked++; //체크된 체크박스의 개수 집계
		}
	}
	
	fn_calcPrice(chks, chksChecked); //체크박스를 클릭할 때마다 금액이 변동되도록 함수 호출
	
	if(chks.length == chksChecked){ //모든 체크박스가 체크되어있으면
		$("#selectAll").prop("checked", true); //전체선택 버튼을 true로
	}else{
		$("#selectAll").prop("checked",false); //전체선택 버튼 false로
	}
	
});


//픽업 날짜선택 함수 (여러개 예약)
function fn_pickupDates() { 

	let chks = document.getElementsByName("chk"); //체크박스 요소를 객체로 만듦
	let chksChecked = 0; //체크된 체크박스의 개수를 저장할 변수 
	let chk;
	
	let d_name = "";
	let d_model = ""; 
	let d_size = "";
	let d_shop = "";
	let d_num = "";
	let d_shopnum = "";
	
		//체크된 개수를 파악하기 위한 반복문
		for(var i=0; i<chks.length; i++) { //전체 체크박스 개수만큼 반복
			chk = chks[i]; //체크박스 하나를 변수에 저장
			
			if(chk.checked) { //체크 되어있으면
				chksChecked ++; //체크 개수 1 증가
			}
		}	
			
			if(chksChecked == 0) { //체크된 게 없으면
				alert("선택된 상품이 없습니다.");
				
			} else if(chksChecked > 5) { //5개 이상 체크했으면
				alert("1회 최대 5개의 상품만 예약하실 수 있습니다.");
				
			} else if(confirm("해당 상품의 픽업예약을 진행하시겠습니까?")) {
				
				$(".modal-body").empty(str);
				//이전에 선택했었던 상품이 모달창에 계속 뜨는 현상을 방지하기 위해
				//새로 체크한 상품들만 띄우도록 내용을 지움
				
				for(var i=0; i<chks.length; i++) { //전체 체크박스 개수만큼 반복
					chk = chks[i]; //체크박스 하나를 변수에 저장
					
					if(chk.checked) { //체크되어있으면
						
						//data속성에 저장했던 데이터들을 변수에 저장
						 d_name = chks[i].dataset.name;
						 d_model = chks[i].dataset.model;
						 d_size = chks[i].dataset.size;
						 d_shop = chks[i].dataset.shop;
						 d_num = chks[i].dataset.num;
						 d_shopnum = chks[i].dataset.shopnum;
						  
						//모달창에 추가될 상품 출력 부분
						var str = "";
						
						str += "<div class='row ms-3 me-3 mb-3 p-3' id='modalRow' style='border: 1px solid rgba(0, 0, 0, 0.228); border-radius: 12px; background-color: rgba(0, 0, 0, 0.05);'>";
						str += 	"<div class='d-flex justify-content-between'>";
						str += 		"<h6 id='name'>" + d_name + " / " + d_model + "</h6>";
						str += 		"<p class='mb-1' id='size'>" + d_size + "</p>";
						str += 	"</div>";
						str += 	"<p class='mb-2' style='font-size: small;' id='shop'>" + d_shop + "</p>";
						str += 		"<input class='form-control' type='date' id='date' />";
						str += 		"<input type='hidden' id='num' value='" + d_num + "' />";
						str += 		"<input type='hidden' id='shopNum' value='" + d_shopnum + "' />";
						str += "</div>";
					
						$(".modal-body").append(str);
						//여러개의 상품이 모달창에 계속 추가되어야 하기 때문에 append메소드 사용
						
							var pickupInfoObj = {
								goodsNum : d_num,
								goodsName : d_name,
								shopNum : d_shopnum,
								goodsSize : d_size
								};
						
							 pickupInfo.push(pickupInfoObj);
							 //객체의 인덱스가 비어있는 현상을 방지하기 위해 객체를 배열에 push하여 비어있는 인덱스가 없도록 함
						
					} //if문 end
					
				} //for문 end
								   	
					$("#pickupDateModal").modal("show");
					//모달이 자동으로 띄워지는 속성을 사용했을 때, confirm창에서 아니오를 선택해도
					//예약버튼을 누르면 무조건 모달이 나타나기 때문에 빈 모달창이 계속 띄워짐
					//data-bs ~ 속성을 지우고 필요한 상황에만 수동으로 띄움
		
					$("#payment-button").on("click", function(e) { //예약하기 버튼을 클릭하면
						e.preventDefault();
						
						var dates = $("#modalRow #date");
						
						var finalInfo = [];
						
						 for(var i=0; i<dates.length; i++) {
							
							var date = dates[i].value;
							
							  	dateObj[i] = {
									pickupDate : date
								}
							
							  	var result = {
										...pickupInfo[i],
										...dateObj[i]
										}
							  	
							finalInfo.push(result);
						}
					
						fn_payment(finalInfo); //결제 진행 함수 호출
					});
				}
}
</script>

<!-- 토스 페이먼츠 API -->
<script src="https://js.tosspayments.com/v1/payment-widget"></script>

<script>


function fn_payment(finalInfo) { //여러개 결제 진행
	//토스 페이먼츠 결제  
	const clientKey = 'test_ck_7XZYkKL4Mrjnv7vJl1ar0zJwlEWR';
	const customerKey = 'user123'; 
	const paymentWidget = PaymentWidget(clientKey, customerKey);  // 결제위젯 초기화
	
		let price = null;
		let amount = finalInfo.length; //예약할 상품의 개수
		let max = "${orderId}"; //가장 최신의 주문번호를 가져옴

		if(max == 0) {
			max = 10000000;
		}
		
		let orderId = Number(max) + 124; //새로운 주문번호 생성
		
		let jsonArray = [];
		let json = new Object();
		
		for (var i of finalInfo) {
			let goodsNum = i.goodsNum;
			let goodsName = i.goodsName;
			let shopNum = i.shopNum;
			let goodsSize = i.goodsSize;
			let pickupDate = i.pickupDate;
			
			json.goodsNum = goodsNum;
			json.goodsName = goodsName;
			json.shopNum = shopNum;
			json.goodsSize = goodsSize;
			json.pickupDate = pickupDate;
			
			jsonArray.push({...json});
		} //반복문	
		
		// 등급별 픽업 예약금	
		if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "골드"){
			price = 30000*amount;
			paymentWidget.renderPaymentMethods('#payment-method', price);
		}else if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "플래티넘"){
			price = 27000*amount;
			paymentWidget.renderPaymentMethods('#payment-method', price);
		}else if("<%=(String)session.getAttribute("session_MEM_GRADE")%>" === "다이아"){
			price = 25000*amount;
			paymentWidget.renderPaymentMethods('#payment-method', price);
		}
		
		var goodsInfo = JSON.stringify(jsonArray);
		
		let count = amount - 1;
		
		$.ajax({
			type : 'post',
			url : 'http://localhost:8080/sk/getGoodsInfo',
			data : goodsInfo,
			processData : false,
			contentType : 'application/json',
			success : function(data) {
				  paymentWidget.requestPayment({
				  	  orderId: orderId, 
				  	  orderName: finalInfo[0].goodsName + " 외 " + count + "건",
				  	  successUrl: 'http://localhost:8080/sk/tossPaymentsSuccessBundle',
				  	  failUrl: 'http://localhost:8080/sk',
				  	  customerEmail: '${MEM_EMAIL}', 
				  	  customerName: '${MEM_NAME}',
					});	 
			},
			error : function(){
				alert("잠시 후 다시 시도해주세요.");
			}
		});	  
		 
}

</script>
</html>