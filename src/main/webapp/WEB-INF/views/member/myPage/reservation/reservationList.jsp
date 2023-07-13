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
 <body>
<!-- 모달 -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" style="width:600px; height: auto;">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">상품 후기 작성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="mt-4 ms-3 row-cols-md-1">
          <table>
          <tr>
            <td>
              <p style="font-weight: bolder; font-size: medium;">상품 만족도</p>
            </td>
            <td>
              <form class="mb-3" name="myform" id="myform" method="post">
                <fieldset>
                  <input type="radio" name="reviewStar" value="5" id="rate1"><label
                    for="rate1">★</label>
                  <input type="radio" name="reviewStar" value="4" id="rate2"><label
                    for="rate2">★</label>
                  <input type="radio" name="reviewStar" value="3" id="rate3"><label
                    for="rate3">★</label>
                  <input type="radio" name="reviewStar" value="2" id="rate4"><label
                    for="rate4">★</label>
                  <input type="radio" name="reviewStar" value="1" id="rate5"><label
                    for="rate5">★</label>
                </fieldset>
              </form>
            </td>
            <td></td>
            <td></td>
          </tr>

          <tr style="height: 70px;">
            <td>
              <fieldset>
              <p style="font-weight: bolder; font-size: medium; margin-bottom: 0;">사이즈</p>
            </td>
              <td>
                <input type="radio" name="size" value="0" id="size1" style="font-size: medium;"><span>  정사이즈보다 작음</span>
              </td>
              <td>  
              <input type="radio" name="size" value="1" id="size2"><span>  정사이즈</span>
              </td>
              <td>  
              <input type="radio" name="size" value="2" id="size3"><span>  정사이즈보다 큼</span>
              </td>
          </tr>

          <tr style="height: 70px;">
            <td>
              <p style="font-weight: bolder; font-size: medium; margin-bottom: 0;">착화감</p>
            </td>
            <td>
              <input type="radio" name="comfort" value="0" id="size1"><span>  나   쁨</span>
            </td>
            <td>  
            <input type="radio" name="comfort" value="1" id="size2"><span>  보   통</span>
            </td>
            <td>  
            <input type="radio" name="comfort" value="2" id="size3"><span>  좋   음</span>
            </td>
          </tr>

          <tr style="height: 70px;">
            <td>
              <p style="font-weight: bolder; font-size: medium; margin-bottom: 0;">색상</p>
            </td>
            <td>
              <input type="radio" name="color" value="0" id="size1" style="font-size: medium;"><span>  화면보다 어두움</span>
            </td>
            <td>  
            <input type="radio" name="color" value="1" id="size2"><span>  화면과 동일함</span>
            </td>
            <td>  
            <input type="radio" name="color" value="2" id="size3"><span>  화면보다 밝음</span>
            </td>
          </tr>
        </table>
          </div>
          <br>
          <div class="modal-footer">
          	<c:set var="totalGoodsNum" value="${pickup.TOTAL_GOODS_NUM}"/>
            <button type="button" class="btn btn-primary" data-bs-dismiss="modal" name="write" data-num="${totalGoodsNum}">후기 작성</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          </div>
      </div>
      </div>
    </div>
  </div>
  <!-- 모달 끝 -->
  
        <div class="col-9" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">픽업 예약 목록</h3>
              <table class="table" style="width: 100%; margin-left: 30px;">
                <tbody id="pickupListTbody" class="table-group-divider">
                 <!-- 나의 픽업 예약 리스트 -->
				<c:choose>
					<c:when test="${fn:length(pickupList) > 0 }">
						<c:forEach items="${pickupList}" var="pickup">
		                  	<tr>
			                    <th scope="rowspan-3" style="width: 25%;">
			                         <a href="#" name="goodsDetail" data-num="${pickup.RESERVATION_NUM}" data-status="${pickup.RESERVATION_STATUS}"><img src="/sk/image/display?fileName=${pickup.GOODS_IMAGE_STD}" height="120" width="120" /></a>
			                    </th>
			                    <td style="text-align: left; width: 45%; margin-left: 1;">
			                        <a href="#"><p style="font-size: small;">${pickup.BRAND_NAME}</p></a>
			                        <p style="font-weight: bolder; font-size: large;">${pickup.RESERVATION_SIZE}</p>
			                        <p style="font-weight: bolder;">${pickup.TOTAL_GOODS_NAME} / ${pickup.TOTAL_GOODS_MODEL}</p>
			                    </td>
			                    <td style="text-align: left; width: 20%; margin-bottom: 1; ">
			                        <p style="font-weight: bolder; font-size: large;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${pickup.TOTAL_GOODS_PRICE}"/>원</p>
			                        <div id="statusDiv_${pickup.RESERVATION_NUM}">
			                        <p style="font-size: medium;">${pickup.RESERVATION_STATUS}</p>
			                        </div>
			                        <p style="font-size: small;">픽업 지정날짜 : ${pickup.RESERVATION_PICKUP_DATE}</p>
			                    </td>
			                    <td style="font-weight: bolder; text-align: center;">
			                        <br>
			                        <p></p>
			                         <c:if test="${pickup.RESERVATION_STATUS == '예약 대기중' || pickup.RESERVATION_STATUS == '픽업 대기중'}">
			                         <div id="deleteBtnDiv_${pickup.RESERVATION_NUM}">
			                        <button type="button" name="reservationDelete" class="btn btn-secondary btn-sm" data-num="${pickup.RESERVATION_NUM}" data-status="${pickup.RESERVATION_STATUS}">취소</button>
			                        </div>
			                        </c:if>
			                         <c:if test="${pickup.RESERVATION_STATUS == '픽업 완료'}">
			                         <div id="deleteBtnDiv_${pickup.TOTAL_GOODS_NUM}">
			                        <button type="button" class="btn btn-secondary btn-sm" name="openForm" data-num="${pickup.TOTAL_GOODS_NUM}">리뷰<br/>작성</button>
			                        </div>
			                        </c:if>
			                        <br>
			                    </td>
		                  </tr>
						</c:forEach>
					</c:when>
				</c:choose>
                
                </tbody>
              </table>
              
            <!-- 페이징 화면 처리 부분 시작 -->
	      	<div id="PAGE_NAVI"></div>
			<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
			<!-- 페이징 화면 처리 부분 끝 -->

            </div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	// 페이지 로딩 시 자동으로 1페이지 가져오기
	fn_selectReservationList(1);
	
	 var star = "";
	 var size = "";
	 var comfort = "";
	 var color = "";
	 var goodsNum = "";
	
	// 토스 페이먼츠 결제 후, 픽업 예약 리스트 화면이 표시될 때 웹 스토리지에 paymentKey값 저장
	//주문번호 받아와서, 웹 스토리지에 key=주문번호, value=paymentKey로 저장
	var paymentKey = "${paymentKey}";
	var orderIdList = "${orderIdList}";
	var orderId = "${orderId}";
	
	 if(orderIdList != null) {
		 <c:forEach var="list" items="${orderIdList}">
			console.log("orderId : "+ "${list}");
			localStorage.setItem("${list}", paymentKey);
		 </c:forEach>
	} if(orderId != null) {
		localStorage.setItem("${orderId}", paymentKey);
	}
	
	
	$("#pickupListTbody").on("click", "a[name='goodsDetail']", function(e){ // 픽업 예약 상품 상세조회
		e.preventDefault();
		const reservationNum = $(this).attr("data-num");
		location.href="/sk/myPage/reservationDetail?RESERVATION_NUM=" + reservationNum;
	});
	
	$("#pickupListTbody").on("click", "button[name='reservationDelete']", function(e){  // 픽업 예약 취소
		e.preventDefault();
		
		const reservationNum = $(this).attr("data-num");
		const reservationStatus = $(this).attr("data-status");
	
		fn_reservationDelete(reservationNum, reservationStatus);
	});
	
	
	$("#pickupListTbody").on("click", "button[name='openForm']", function(e){ // 목록에서 리뷰 작성 버튼
		e.preventDefault();
		goodsNum = $(this).attr("data-num");
		$("button[name='write']").attr("data-num", goodsNum);
		
		checkReviewExists(goodsNum);
	});
	
	 $("button[name='write']").on("click", function(e) {  // 모달에서 리뷰 등록 버튼
		e.preventDefault();
		var goodsNum = $(this).attr("data-num");
		
		writeReview(goodsNum, star, size, comfort, color);
	});  
	 
	 $("label").on("click", function(e) { //별점 선택 시
		 star = $(this).prev("input").val(); //prev() : 이전 형제노드를 찾음
	 });
	 
	 $("input[name='size']").on("click", function(e) { //사이즈 후기 선택 시
		 size = $.trim($(this).next("span").text()); //선택한 문자열 가져옴
	 });
	 
	 $("input[name='comfort']").on("click", function(e) { //착화감 후기 선택 시
		var str = $(this).next("span").text(); //선택한 착화감 가져오기
	 	comfort = str.replaceAll(' ', ''); //문자열 사이 공백 제거
	 });
	  	
	 $("input[name='color']").on("click", function(e) { //색상 후기 선택 시
		 color = $.trim($(this).next("span").text());
	 });
	 
	 function checkReviewExists(goodsNum) { //리뷰 등록 전에 리뷰 작성 이력을 검사
			var jsonGoodsNum = {TOTAL_GOODS_NUM:goodsNum};
		
			$.ajax({
				type : 'post',
				url : '/sk/myPage/checkReviewExists',
				contentType:"application/json; charset=UTF-8",
				data:JSON.stringify(jsonGoodsNum),
				 success : function(data){
					 if(data > 0) { //리뷰가 존재하면
						 alert("이미 리뷰를 작성한 상품입니다!");
					 } else {
						 $('#reviewModal').modal('show'); //모달창 열기
					 }
				},
				error : function(){
					alert("잠시 후 다시 시도해주세요.");
				}
			});
		}
		
		function writeReview(goodsNum, star, size, comfort, color) { //리뷰 등록 처리
			var formData = new FormData();
			formData.append("TOTAL_GOODS_NUM", goodsNum);
			formData.append("REVIEW_SCORE", star);
			formData.append("REVIEW_SIZE", size);
			formData.append("REVIEW_COMFORT", comfort);
			formData.append("REVIEW_COLOR", color);
			
			
			if(confirm("리뷰를 등록하시겠습니까?")) {
				$.ajax({
				type : 'post',
				url : '/sk/myPage/reviewWrite',
				data : formData,
				processData : false,
				contentType : false,
				 success : function(data){
					 alert("리뷰가 등록되었습니다.");
					 location.reload();
				},
				error : function(){
					alert("잠시 후 다시 시도해주세요.");
				}
			});
			}
		}
		
	function fn_reservationDelete(reservationNum, reservationStatus){
		
		var formData = new FormData();
		formData.append("RESERVATION_NUM", reservationNum);
		formData.append("RESERVATION_STATUS", reservationStatus);
		formData.append("paymentKey", localStorage.getItem(reservationNum))
		
		if(confirm("예약을 취소하시겠습니까?")) {
			$.ajax({
			type : 'post',
			url : '/sk/tossPaymentsCancel',
			data : formData,
			processData : false,
			contentType : false,
			 success : function(data){
				 if(data.result == "pass"){
					 alert("픽업 예약이 취소되었습니다.");
					 $("#deleteBtnDiv_"+reservationNum).empty();
					 $("#statusDiv_"+reservationNum).empty();
					 str = '<p style="font-size: medium;">';
					 str += data.RESERVATION_STATUS;
					 str += '</p>';
					 $("#statusDiv_"+reservationNum).append(str);
				 }else if(data.result == "fail") {
					 alert("실패");
				 }
			},
			error : function(){
				alert("오류 발생");
			}
			
		});
		}
	}
	
	
});

//페이징 함수
function fn_selectReservationList(pageNo){
	var comAjax = new ComAjax();
	comAjax.setUrl("/sk/myPage/reservationList/paging");
	comAjax.setCallback("fn_selectReservationListCallback");
	comAjax.addParam("PAGE_INDEX",pageNo);
	comAjax.addParam("PAGE_ROW", 5); //한 페이지에 보여줄 게시글 수 정하기
	comAjax.ajax();
}

// 페이징 콜백 함수
function fn_selectReservationListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
	var total = data.TOTAL;
	var body = $("#pickupListTbody"); // 페이징 한 결과가 반영될 태그
	
	body.empty();
	
	if(total == 0){ // 결과가 없을 경우
		var str = "<tr>" + 
						"<td colspan='4'>조회된 결과가 없습니다.</td>" + 
					"</tr>";
		body.append(str);
	} else { // 결과가 있을 경우
		var params = {
			divId : "PAGE_NAVI",
			pageIndex : "PAGE_INDEX",
			totalCount : total,
			recordCount : 5,
			eventName : "fn_selectReservationList" // 페이징 함수이름 동일하게
		};
		gfn_renderPaging(params);
		
		var str = "";
		$.each(data.pickupList, function(key, value){  
			str += "<tr><th scope='rowspan-3' style='width: 25%;'><a href='#' name='goodsDetail' " +
				   "data-num='" + value.RESERVATION_NUM + "' data-status='" + value.RESERVATION_STATUS +
				   "'><img src='/sk/image/display?fileName=" + value.GOODS_IMAGE_STD + "' height='120' width='180' /></a>" +
				   "</th><td style='text-align: left; width: 45%; margin-left: 1;'><a href='#'><p style='font-size: small;'>" +
				   value.BRAND_NAME + "</p></a><p style='font-weight: bolder; font-size: large;'>" +
				   value.RESERVATION_SIZE + "</p><p style='font-weight: bolder;'>" + value.TOTAL_GOODS_NAME + " / " + value.TOTAL_GOODS_MODEL + "</p>" +
				   "</td><td style='text-align: left; width: 20%; margin-bottom: 1; '><p style='font-weight: bolder; font-size: large;'>" + 
				   AddComma(value.TOTAL_GOODS_PRICE) + "원</p>" +
				   "<div id='statusDiv_" + value.RESERVATION_NUM + "'> <p style='font-size: medium;'>" + value.RESERVATION_STATUS + "</p>" + 
				   "</div><p style='font-size: small;'>픽업 지정날짜 : " + value.RESERVATION_PICKUP_DATE + "</p></td>" + 
				   "<td style='font-weight: bolder; text-align: center;'><br><p></p>";
				   if(value.RESERVATION_STATUS == '예약 대기중' || value.RESERVATION_STATUS == '픽업 대기중') {
					   str += "<div id='deleteBtnDiv_" + value.RESERVATION_NUM + "'><button type='button' name='reservationDelete' class='btn btn-secondary btn-sm' " + 
					   "data-num='" + value.RESERVATION_NUM + "' data-status='" + value.RESERVATION_STATUS + "'>취소</button>" +
					   "</div>";
					   
				   }
				   if(value.RESERVATION_STATUS == '픽업 완료') {
					   str += "<div id='deleteBtnDiv_" + value.TOTAL_GOODS_NUM +
					   "'><button type='button' class='btn btn-secondary btn-sm' name='openForm' data-num='" + value.TOTAL_GOODS_NUM + "'>리뷰작성</button>" +
					   "</div>";
				   }
				   str += "<br></td></tr>"
		});
		body.append(str);
	}
}
</script>
</html>