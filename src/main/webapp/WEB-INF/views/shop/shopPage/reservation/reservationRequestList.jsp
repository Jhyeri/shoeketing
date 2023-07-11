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
<div class="col-10" style="margin-top: 0px;">
          <h3 style="margin-left: 30px; color: black; font-weight: bolder;">예약 관리</h3>
            <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
              <table id="reservationTable" class="table" style="width: 100%; margin-left: 30px;">
                <tbody id="reservationRequestListTbody">
                  <c:choose>
					<c:when test="${fn:length(reservationList) > 0 }">
						<c:forEach items="${reservationList}" var="reservation"> 
		                  <tr>
		                    <th scope="rowspan-3" style="width: 20%;">
		                        <a href="#"><img src="/sk/image/display?fileName=${reservation.GOODS_IMAGE_STD}" height="200" width="250"/></a>
		                    </th>
		                    <td style="text-align: left; width: 20%; vertical-align:middle;">
		                        <a href="#"><p style="font-size: small;">${reservation.RESERVATION_NUM}</p></a>
		                        <p style="font-weight: bolder; font-size: large;">${reservation.TOTAL_GOODS_NAME} / ${reservation.TOTAL_GOODS_MODEL}</p>
		                        <div class="row">
		                            <div class="col-md-6 themed-grid-col">${reservation.RESERVATION_SIZE}mm</div>
		                            <div class="col-md-6 themed-grid-col">${reservation.MEM_NAME} | ${reservation.RESERVATION_PHONE}</div>
		                          </div>
		                    </td>
		                    <td style="text-align: center; width: 10%; margin-bottom: 1; vertical-align: middle;">
		                        <p style="font-weight: bolder; font-size: large;">${reservation.TOTAL_GOODS_PRICE}원</p>
		                        <div id="statusDiv_${reservation.RESERVATION_NUM}">
		                        	<p style="font-size: medium;">${reservation.RESERVATION_STATUS}</p>
		                       	</div>
		                        <p style="font-size: medium;">${reservation.RESERVATION_DATE}</p>
		                    </td>
		                    <td style="font-weight: bolder; text-align: center; vertical-align:middle; width:10%;">
		                        <c:if test="${reservation.RESERVATION_STATUS == '픽업 대기중'}">
			                        <div id="cancelBtnDiv_${reservation.RESERVATION_NUM}" data-reservationStatus="${reservation.RESERVATION_STATUS}">
			                        	<button type="button"
			                        			class="btn btn-danger btn-sm"
			                        			name="reservationCancel"
			                        			data-reservationNum="${reservation.RESERVATION_NUM}"
			                        			data-shopNum="${reservation.RESERVATION_SHOP_NUM}"
			                        	        data-goodsNum="${reservation.RESERVATION_PRONUM}"
			                        	        data-goodsSize="${reservation.RESERVATION_SIZE}"
			                        	        data-reservationStatus="${reservation.RESERVATION_STATUS}"
			                        	        data-memNum="${reservation.MEM_NUM}"
			                        	        data-goodsName="${reservation.TOTAL_GOODS_NAME}"
			                        	        >픽업 취소</button>
			                        	<button type="button"
			                        			class="btn btn-success btn-sm"
			                        			name="pickUpSuccess"
			                        			data-reservationNum="${reservation.RESERVATION_NUM}"
			                        	        data-reservationStatus="${reservation.RESERVATION_STATUS}"
			                        	        data-memNum="${reservation.MEM_NUM}"
			                        	        data-goodsName="${reservation.TOTAL_GOODS_NAME}"
			                        	        >픽업 완료</button>
			                        </div>
		                        </c:if>
		                        <c:if test="${reservation.RESERVATION_STATUS == '예약 대기중'}">
		                       	 	<div id="approveBtnDiv_${reservation.RESERVATION_NUM}">
				                        <button type="button"
				                        		class="btn btn-primary btn-sm"
				                        		name="reservationApprove"
				                        		data-reservationNum="${reservation.RESERVATION_NUM}"
				                        		data-shopNum="${reservation.RESERVATION_SHOP_NUM}"
				                        		data-goodsNum="${reservation.RESERVATION_PRONUM}"
				                        		data-goodsSize="${reservation.RESERVATION_SIZE}"
				                        		data-memNum="${reservation.MEM_NUM}"
				                        		data-goodsName="${reservation.TOTAL_GOODS_NAME}"
				                        		>예약 승인
				                        </button>
		                           		<button type="button"
		                           				class="btn btn-secondary btn-sm"
		                           				name="reservationReject"
		                           				data-reservationNum="${reservation.RESERVATION_NUM}"
		                           				data-reservationStatus="${reservation.RESERVATION_STATUS}"
		                           				data-memNum="${reservation.MEM_NUM}"
		                           				data-goodsName="${reservation.TOTAL_GOODS_NAME}"
		                           				>예약 거부
		                           		</button>
			                        </div>
		                        </c:if>
		                    </td>
		                  </tr>
	                    </c:forEach>
                    </c:when>
                 </c:choose>
               </tbody>
             </table>

              <hr class="my-4" style="margin-left: 30px; width: 100%;">
              
			  <!-- 페이징 화면 처리 부분 시작 -->
		      <div id="PAGE_NAVI"></div>
			  <input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
			  <!-- 페이징 화면 처리 부분 끝 -->
			  
            </div>
</body>

<script type="text/javascript">
$(document).ready(function() {
	
	// 페이지 로딩 시 자동으로 1페이지 가져오기
	fn_selectReservationRequestList(1);
	
});
//페이징 함수
function fn_selectReservationRequestList(pageNo){
	var comAjax = new ComAjax();
	comAjax.setUrl("/sk/shopPage/reservationList/paging");
	comAjax.setCallback("fn_selectReservationRequestListCallback");
	comAjax.addParam("PAGE_INDEX",pageNo);
	comAjax.addParam("PAGE_ROW", 5); //한 페이지에 보여줄 게시글 수 정하기
	comAjax.ajax();
}

// 페이징 콜백 함수
function fn_selectReservationRequestListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
	var total = data.TOTAL;
	var body = $("#reservationRequestListTbody"); // 페이징 한 결과가 반영될 태그
	
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
			eventName : "fn_selectReservationRequestList" // 페이징 함수이름 동일하게
		};
		gfn_renderPaging(params);
		
		var str = "";
		$.each(data.reservationList, function(key, value){ // 가져온 게시글 수 만큼 반복 실행
			str += "<tr>" + 
				   "<th scope='rowspan-3' style='width: 20%;'>" +
				   "<a href='#'><img src='/sk/image/display?fileName=" + value.GOODS_IMAGE_STD + "' height='200' width='250'/></a>" + 
				   "</th>" + 
				   "<td style='text-align: left; width: 20%; vertical-align:middle;'>" + 
				   "<a href='#'><p style='font-size: small;'>" + value.RESERVATION_NUM + "</p></a>" + 
				   "<p style='font-weight: bolder; font-size: large;'>" + value.TOTAL_GOODS_NAME + " / " + value.TOTAL_GOODS_MODEL + "</p>" +
				   "<div class='row'>" + 
				   "<div class='col-md-6 themed-grid-col'>" + value.RESERVATION_SIZE + "mm</div>" + 
				   "<div class='col-md-6 themed-grid-col'>" + value.MEM_NAME + " | " + value.RESERVATION_PHONE + "</div>" +
				   "</div></td>" + 
				   "<td style='text-align: center; width: 10%; margin-bottom: 1; vertical-align: middle;'>" + 
				   "<p style='font-weight: bolder; font-size: large;'>" + value.TOTAL_GOODS_PRICE + "원</p>" + 
				   "<div id='statusDiv_" + value.RESERVATION_NUM + "'>" +
				   "<p style='font-size: medium;'>" + value.RESERVATION_STATUS + "</p>" +
				   "</div>" + 
				   "<p style='font-size: medium;'>" + value.RESERVATION_DATE + "</p>" +
				   "</td>" + 
				   "<td style='font-weight: bolder; text-align: center; vertical-align:middle; width:10%;'>";
				   if(value.RESERVATION_STATUS == '픽업 대기중'){
					   str += "<div id='cancelBtnDiv_" + value.RESERVATION_NUM + "' data-reservationStatus='" + value.RESERVATION_STATUS + "'>" +
				   			  "<button type='button' class='btn btn-danger btn-sm'" +
				   			  " name='reservationCancel'" +
				   			  " data-reservationNum='" + value.RESERVATION_NUM + "'" +
				   			  " data-shopNum='" + value.RESERVATION_SHOP_NUM + "'" +
				   			  " data-goodsNum='" + value.RESERVATION_PRONUM + "'" +
				   			  " data-goodsSize='" + value.RESERVATION_SIZE + "'" +
				   			  " data-reservationStatus='" + value.RESERVATION_STATUS + "'" +
				   			  " data-memNum='" + value.MEM_NUM + "'" +
				   			  " data-goodsName='" + value.TOTAL_GOODS_NAME + "'" +
				   			  ">픽업 취소</button> " + 
				   			  "<button type='button' class='btn btn-success btn-sm'" +
					   		  " name='pickUpSuccess'" +
					   		  " data-reservationNum='" + value.RESERVATION_NUM + "'" +
					   		  " data-reservationStatus='" + value.RESERVATION_STATUS + "'" +
					   		  " data-memNum='" + value.MEM_NUM + "'" +
					   		  " data-goodsName='" + value.TOTAL_GOODS_NAME + "'" +
					   		  ">픽업 완료</button></div>";
				   }
				   if(value.RESERVATION_STATUS == '예약 대기중'){
					   str += "<div id='approveBtnDiv_" + value.RESERVATION_NUM + "'>" +
				   			  "<button type='button' class='btn btn-primary btn-sm'" +
				   			  " name='reservationApprove'" +
				   			  " data-reservationNum='" + value.RESERVATION_NUM + "'" +
				   			  " data-shopNum='" + value.RESERVATION_SHOP_NUM + "'" +
				   			  " data-goodsNum='" + value.RESERVATION_PRONUM + "'" +
				   			  " data-goodsSize='" + value.RESERVATION_SIZE + "'" +
				   			  " data-memNum='" + value.MEM_NUM + "'" +
				   			  " data-goodsName='" + value.TOTAL_GOODS_NAME + "'" +
				   			  ">예약 승인</button>" +
				   			  "<button type='button' class='btn btn-secondary btn-sm'" +
					   		  " name='reservationReject'" +
					   		  " data-reservationNum='" + value.RESERVATION_NUM + "'" +
					   		  " data-reservationStatus='" + value.RESERVATION_STATUS + "'" +
					   		  " data-memNum='" + value.MEM_NUM + "'" +
					   		  " data-goodsName='" + value.TOTAL_GOODS_NAME + "'" +
					   		  ">예약 거부</button></div>";
				   }
			   str += "</td></tr>"
		});
		body.append(str);
		
		$("button[name='reservationApprove']").on("click", function(e){  // 예약 승인
			e.preventDefault();
			
			const reservationNum = $(this).attr("data-reservationNum");
			const goodsNum = $(this).attr("data-goodsNum");
			const shopNum = $(this).attr("data-shopNum");
			const goodsSize = $(this).attr("data-goodsSize");
			const reservationStatus = $(this).attr("data-reservationStatus");
			const memNum = $(this).attr("data-memNum");
			const goodsName = $(this).attr("data-goodsName");
			
			fn_reservationApprove(reservationNum, goodsNum, shopNum, goodsSize, reservationStatus, memNum, goodsName);
		
		});
		
		function fn_reservationApprove(reservationNum, goodsNum, shopNum, goodsSize, reservationStatus, memNum, goodsName){
			
			var formData = new FormData();
			formData.append("RESERVATION_NUM", reservationNum);
			formData.append("RESERVATION_PRONUM", goodsNum);
			formData.append("RESERVATION_SHOP_NUM", shopNum);
			formData.append("RESERVATION_SIZE", goodsSize);
			formData.append("RESERVATION_STATUS", reservationStatus);
			formData.append("paymentKey", localStorage.getItem(reservationNum));
			
			$.ajax({
				type : 'post',
				url : '/sk/shopPage/reservationApprove', 
				data : formData,
				processData : false,
				contentType : false,
				success : function(data){
					if(data.result == "pass"){
						alert("픽업 예약을 승인하였습니다.");
						$("#approveBtnDiv_"+reservationNum).empty();
						$("#statusDiv_"+reservationNum).empty();
						str = '<p style="font-size: medium;">';
						str += data.RESERVATION_STATUS;
						str += '</p>';
						
						$("#statusDiv_"+reservationNum).append(str);
						
						str2 = '<button type="button" class="btn btn-danger btn-sm" name="reservationCancel" ';
						str2 += 'data-reservationNum="';
						str2 += reservationNum;
						str2 += '" data-shopNum="';
						str2 += shopNum;
						str2 += '" data-goodsNum="';
						str2 += goodsNum;
						str2 += '" data-goodsSize="';
						str2 += goodsSize;
						str2 += '" data-reservationStatus="';
						str2 += data.RESERVATION_STATUS;
						str2 += '" data-memNum="';
						str2 += memNum;
						str2 += '" data-goodsName="';
						str2 += goodsName;
						str2 += '">픽업 취소</button>';
						str2 += '<button type="button" class="btn btn-success btn-sm" name="pickUpSuccess" ';
						str2 += 'data-reservationNum="';
						str2 += reservationNum;
						str2 += '" data-reservationStatus="';
						str2 += data.RESERVATION_STATUS;
						str2 += '" data-memNum="';
						str2 += memNum;
						str2 += '" data-goodsName="';
						str2 += goodsName;
						str2 += '">픽업 완료</button>';
						
						$("#approveBtnDiv_"+reservationNum).append(str2);
						
						socket.send("<%=session.getAttribute("session_SHOP_NAME")%>,"+memNum+",회원님께서 예약하신 '"+goodsName+"'의 예약 상태가 '픽업 대기중'으로 변경되었습니다.,/sk/myPage/reservationList");
					}else if(data.result == "fail"){
						alert("실패");
					}
					
				},
				error : function(){
					alert("오류 발생");
				}
			});
			
			$("#approveBtnDiv_"+reservationNum).on("click", "button[name='reservationCancel']", function(e){  // 픽업 취소 (예약 승인 후, 표시되는 픽업 취소버튼) 
				e.preventDefault();
		 		const reservationNum = $(this).attr("data-reservationNum");
		 		const reservationStatus = $(this).attr("data-reservationStatus");
		 		const memNum = $(this).attr("data-memNum");
				const goodsName = $(this).attr("data-goodsName");
		 		
				fn_reservationCancel(reservationNum, reservationStatus, memNum, goodsName);
				
			});
			
			$("#approveBtnDiv_"+reservationNum).on("click", "button[name='pickUpSuccess']", function(e){  // 픽업 완료 (예약 승인 후, 표시되는 픽업 완료버튼) 
				e.preventDefault();
		 		const reservationNum = $(this).attr("data-reservationNum");
		 		const reservationStatus = $(this).attr("data-reservationStatus");
		 		const memNum = $(this).attr("data-memNum");
				const goodsName = $(this).attr("data-goodsName");
		 		
				fn_pickUpSuccess(reservationNum, reservationStatus, memNum, goodsName);
				
			});
		}
		
		$("button[name='reservationReject']").on("click", function(e){  // 예약 거부 
			e.preventDefault();
		 	
	 		const reservationNum = $(this).attr("data-reservationNum");
	 		const reservationStatus = $(this).attr("data-reservationStatus");
	 		const memNum = $(this).attr("data-memNum");
			const goodsName = $(this).attr("data-goodsName");
	 		
			fn_reservationReject(reservationNum, reservationStatus, memNum, goodsName);
		});
		
		function fn_reservationReject(reservationNum, reservationStatus, memNum, goodsName){
			var formData = new FormData();
			
			formData.append("RESERVATION_NUM", reservationNum);
			formData.append("RESERVATION_STATUS", reservationStatus);
			formData.append("paymentKey", localStorage.getItem(reservationNum));
			
			
			if(confirm("픽업 예약을 거부하시겠습니까?")){
				$.ajax({
					type : 'post',
					url : '/sk/tossPaymentsCancel',
					data : formData,
					processData : false,
					contentType : false,
					success : function(data){
						if(data.result == "pass"){
							alert("픽업 예약이 거부되었습니다.");
							$("#approveBtnDiv_"+reservationNum).empty();
							$("#statusDiv_"+reservationNum).empty();
							str = '<p style="font-size: medium;">';
							str += data.RESERVATION_STATUS;
							str += '</p>';
							
							$("#statusDiv_"+reservationNum).append(str);
							socket.send("<%=session.getAttribute("session_SHOP_NAME")%>,"+memNum+",회원님께서 예약하신 '"+goodsName+"'의 예약 상태가 '예약 취소'로 변경되었으며 픽업 예약금도 함께 취소되었습니다.,/sk/myPage/reservationList");
						 }else if(data.result == "fail"){
							 alert("실패");
						 }
					},
					error : function(){
						alert("오류 발생");
					}
				});
				
			}
			
		} 
		
		$("button[name='reservationCancel']").on("click", function(e){  // 픽업 취소  
			e.preventDefault();
	 	
	 		const reservationNum = $(this).attr("data-reservationNum");
	 		const reservationStatus = $(this).attr("data-reservationStatus");
	 		const memNum = $(this).attr("data-memNum");
			const goodsName = $(this).attr("data-goodsName");
	 		
			fn_reservationCancel(reservationNum, reservationStatus, memNum, goodsName);
			
		});
		
		function fn_reservationCancel(reservationNum, reservationStatus, memNum, goodsName){
			var formData = new FormData();
			
			formData.append("RESERVATION_NUM", reservationNum);
			formData.append("RESERVATION_STATUS", reservationStatus);
			formData.append("paymentKey", localStorage.getItem(reservationNum));
			
			
			if(confirm("픽업 예약을 취소하시겠습니까?")){
				$.ajax({
					type : 'post',
					url : '/sk/tossPaymentsCancel',
					data : formData,
					processData : false,
					contentType : false,
					success : function(data){
						if(data.result == "pass"){
							alert("픽업 예약이 취소되었습니다.");
							$("#cancelBtnDiv_"+reservationNum).empty();
							$("#approveBtnDiv_"+reservationNum).empty();
							$("#statusDiv_"+reservationNum).empty();
							str = '<p style="font-size: medium;">';
							str += data.RESERVATION_STATUS;
							str += '</p>';
							
							$("#statusDiv_"+reservationNum).append(str);
							
							socket.send("<%=session.getAttribute("session_SHOP_NAME")%>,"+memNum+",회원님께서 예약하신 '"+goodsName+"'의 예약 상태가 '픽업 취소'로 변경되었으며 픽업 예약금도 함께 취소되었습니다.,/sk/myPage/reservationList");
						 }else if(data.result == "fail"){
							 alert("실패");
						 }
					},
					error : function(){
						alert("오류 발생");
					}
				});
			}
		} 
		
		$("button[name='pickUpSuccess']").on("click", function(e){  // 픽업 완료
			e.preventDefault();
	 	
	 		const reservationNum = $(this).attr("data-reservationNum");
	 		const reservationStatus = $(this).attr("data-reservationStatus");
	 		const memNum = $(this).attr("data-memNum");
			const goodsName = $(this).attr("data-goodsName");
	 		
			fn_pickUpSuccess(reservationNum, reservationStatus, memNum, goodsName);
			
		});
		
		function fn_pickUpSuccess(reservationNum, reservationStatus, memNum, goodsName){
			var formData = new FormData();
			
			formData.append("RESERVATION_NUM", reservationNum);
			formData.append("RESERVATION_STATUS", reservationStatus);
			formData.append("MEM_NUM", memNum);
			
			if(confirm("픽업 완료 처리 하시겠습니까?")){
				$.ajax({
					type : 'post',
					url : '/sk/shopPage/pickUpSuccess',
					data : formData,
					processData : false,
					contentType : false,
					success : function(data){
						if(data.result == "pass"){
							alert("픽업 완료 처리 되었습니다.");
							$("#cancelBtnDiv_"+reservationNum).empty();
							$("#approveBtnDiv_"+reservationNum).empty();
							$("#statusDiv_"+reservationNum).empty();
							str = '<p style="font-size: medium;">';
							str += data.RESERVATION_STATUS;
							str += '</p>';
							
							$("#statusDiv_"+reservationNum).append(str);
							
						 }else if(data.result == "fail"){
							 alert("실패");
						 }
					},
					error : function(){
						alert("오류 발생");
					}
				});
			}
		} 
		
	}
}


</script>
</html>