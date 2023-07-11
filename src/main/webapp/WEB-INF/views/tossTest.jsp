<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토스 결제 테스트</title>
  <script src="https://js.tosspayments.com/v1/payment-widget"></script>

</head>
<body> 	
	<!-- 결제 방법 영역-->
	<div class="title">결제 방법</div>
	<div id="payment-method"></div>
	<div id="agreement"></div>

	<!-- 결제 버튼 -->
	<button id="payment-button">결제하기</button>
	
	<script>
    const clientKey = 'test_ck_7XZYkKL4Mrjnv7vJl1ar0zJwlEWR';
    const customerKey = 'yunjeong1234'; 
    const paymentWidget = PaymentWidget(clientKey, customerKey);  // 결제위젯 초기화
    
    
    $("#payment-button").on("click", function(e){
    	paymentWidget.renderPaymentMethods('#payment-method', 30000);
    	
    	paymentWidget.requestPayment({
      	  orderId: 10101010,
      	  orderName: '${detailMap.TOTAL_GOODS_NAME}',
      	  successUrl: 'http://localhost:8080/sk/reservationSuccess',
      	  failUrl: 'http://localhost:8080/sk',
      	  customerEmail: 'dbswjd8178@naver.com', 
      	  customerName: '김윤정'
      	});
    	
    	//fn_paymentKeyTransmit();
   
    });
    
    <%-- function fn_paymentKeyTransmit(){
		
		var formData = new FormData();
		var paymentKey = <%=request.getParameter("paymentKey")%>
		
		formData.append("paymentKey", paymentKey);
		
		$.ajax({
			type : 'post',
			url : '/sk/reservationSuccess',
			data : formData,
			processData : false,
			contentType : false,
			 success : function(data){
				alert(paymentKey);
			},
			error : function(){
				alert("오류 발생");
			}
			
		});
		
	}  --%>
   
   
    
   
    
  </script>
  
</body>
</html>