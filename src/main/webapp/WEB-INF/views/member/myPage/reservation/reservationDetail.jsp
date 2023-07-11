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
        <div class="col-8" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">픽업 예약 상세 정보</h3>
            <hr style="border: solid 1px rgb(0, 0, 0); width: 100%; margin-left: 30px">

            <div class="row align-items-stretch ps-5">
                <div class="col-4">
                  <div>
                    <div>
                        <a href="#"><img src="/sk/image/display?fileName=${pickupDetailMap.GOODS_IMAGE_STD}" height="300" width="300" /></a>
                    </div>
                  </div>
                </div>
            
                <div class="mt-4 ms-4 col-7">
                    <a href="#"><p style="font-size: small; margin-left: 10%;">예약 번호 : ${pickupDetailMap.RESERVATION_NUM}</p></a>
                    <p style="font-weight: bolder; font-size: x-large; margin-left: 10%;">${pickupDetailMap.TOTAL_GOODS_PRICE}원</p>
                    <p style="font-weight: bolder; font-size: x-large; margin-left: 10%;">${pickupDetailMap.SHOP_BRAND }</p>
                    <p style="font-weight: bolder; font-size: large; margin-left: 10%;">${pickupDetailMap.TOTAL_GOODS_NAME } / VN005U01K19DU</p>
					<p style="font-weight: bolder; font-size: large; margin-left: 10%;">사이즈 : ${pickupDetailMap.RESERVATION_SIZE }</p>
					<p style="font-weight: bolder; font-size: large; margin-left: 10%;">${pickupDetailMap.SHOP_NAME} - ${pickupDetailMap.SHOP_ADD }</p>
                                   
					<c:if test="${pickupDetailMap.RESERVATION_STATUS == '예약 대기중' || pickupDetailMap.RESERVATION_STATUS == '픽업 대기중'}">
                    <div class="d-grid gap-2 d-md-flex justify-content-md-start mt-3">
                    	
                        <h6 style="color: black; margin-left: 10%;">픽업 만료 기한</h6>
                        <p></p>   
                        <h6 style="color: black;">${pickupDetailMap.RESERVATION_EXP} ${pickupDetailMap.SHOP_END_TIME} </h6>
                    </div>
                    </c:if>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-start mt-3">
                        <h6 style="color: black; margin-left: 10%;">${pickupDetailMap.RESERVATION_STATUS}</h6>
                        <p></p>
                        <c:choose>
                        	<c:when test="${pickupDetailMap.RESERVATION_STATUS == '예약 대기중' || pickupDetailMap.RESERVATION_STATUS == '픽업 대기중'}">
                        	<h6 style="color: black;">&nbsp;&nbsp;&nbsp;&nbsp;${pickupDetailMap.RESERVATION_PICKUP_DATE}</h6>
                        </c:when>
                        	<c:otherwise>
                        	</c:otherwise>
                        </c:choose> 
                        <p></p>
                    </div>
                    <br>
                    <c:if test="${pickupDetailMap.RESERVATION_STATUS == '예약 대기중' || pickupDetailMap.RESERVATION_STATUS == '픽업 대기중'}">
                   	 <button style="margin-left: 80%;" type="button" name="reservationDelete" class="btn btn-danger btn-md" >취 소</button>
                    </c:if>
                </div>
             </div>  
        </div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$("button[name='reservationDelete']").on("click", function(e) {  // 픽업 예약 취소
		e.preventDefault();
		fn_reservationDelete();
	}); 
	
	function fn_reservationDelete(){
		
		var reservationNum = ${pickupDetailMap.RESERVATION_NUM};
		var reservationStatus = "${pickupDetailMap.RESERVATION_STATUS}";
		
		var formData = new FormData();
		formData.append("RESERVATION_NUM", reservationNum);
		formData.append("RESERVATION_STATUS", reservationStatus);
		formData.append("paymentKey", localStorage.getItem(reservationNum));
		
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
						 location.href="/sk/myPage/reservationList";
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
	
</script>
</html>