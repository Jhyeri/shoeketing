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
 <div class="col-9" style="margin-top: 0px;">
 	<form id="shopInfoForm">
		<input type="hidden" id="SHOP_NUM" name="SHOP_NUM" value="">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">입점 가입 승인</h3>

              <table class="table" style="width: 100%; margin-left: 30px;">
                <tbody id="shopRequestListTbody" class="table-group-divider">
                 <c:choose>
                  	<c:when test="${fn:length(shopRequestList) > 0 }">
						<c:forEach items="${shopRequestList}" var="shop">   
		                  <tr id="joinBtnTr_${shop.SHOP_NUM}">
		                    <th scope="rowspan-3" style="width: 25%; text-align: center;">
		                        <a href="#" name="shopLocationInfo" data-shopNum="${shop.SHOP_NUM}"><h5 style="margin-top: 18%;">${shop.SHOP_NAME}</h5></a>
		                    </th>
		                    <td style="text-align: left;margin-bottom: 1; width: 200px;">
		                        <p style="font-weight: bolder;">전화번호</p>
		                        <p style="font-weight: bolder;">주소</p>
		                        <p style="font-weight: bolder;">영업시간</p>
		                    </td>
		                    <td style="text-align: left;">
		                        <p style="font-size: medium;">${shop.SHOP_TEL}</p>
		                        <p style="font-size: medium;">${shop.SHOP_ADD}</p>
		                        <p style="font-size: medium;">${shop.SHOP_START_TIME} ~ ${shop.SHOP_END_TIME}</p>
		                    </td>
		
		                    <td style="font-weight: bolder; text-align: center; width: 200px;">
		                   		<br>
		                        <p></p>
	                            <button type="button" class="btn btn-primary btn-md" name="shopJoinApprove" data-shopNum1="${shop.SHOP_NUM}">승인</button>
	                            <button type="button" class="btn btn-secondary btn-md" name="shopJoinReject" data-shopNum2="${shop.SHOP_NUM}">거부</button>
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
          	</form>
            </div>
          
    <!--카카오 지도 API 적용 div-->
      <div class="row justify-content-center">
      	<div class="col-2"></div>
      	<div class="col-9" id="map2">
      		<div id="map" style="width: 1000px; height: 600px"></div>
      	</div>
      </div>
    <!--카카오 지도 API 적용 div 끝-->   
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08e2c5126e1c7f5ac14b68c3f37365ad"></script>
            
<script type="text/javascript">
$(document).ready(function() {
	
	// 페이지 로딩 시 자동으로 1페이지 가져오기
	fn_selectShopRequestList(1);
	
	$("button[name='shopJoinApprove']").on("click", function(e){  // 입점 요청 매장 승인하기
		e.preventDefault();
		const shopNum1 = $(this).attr("data-shopNum1");
		
		fn_shopJoinApprove(shopNum1);
	});
	
	$("button[name='shopJoinReject']").on("click", function(e){  // 입점 요청 매장 거부하기
		e.preventDefault();
		const shopNum2 = $(this).attr("data-shopNum2");
		
		fn_shopJoinReject(shopNum2);
	});
	
	
	function fn_shopJoinApprove(shopNum1){
		
		var formData = new FormData();
		formData.append("SHOP_NUM", shopNum1);
		
		$.ajax({
			type : 'post',
			url : '/sk/brandPage/shopJoinApprove',
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				 if(data.result == "pass"){
					//alert("해당 매장의 입점 요청을 승인하였습니다.");
					
					$("#joinBtnTr_"+shopNum1).remove();
					
					// 승인 후, 리스트에서 해당 매장이 사라지면 지도도 사라지도록 구현
					$("#map2").empty();
					str = "<div id='map' style='width: 1000px; height: 600px'></div>";
					$("#map2").append(str);
					
				 }else if(data.result == "fail") {
					 alert("해당 매장의 입점 요청을 승인하지 못했습니다.");
				 }
			},
			error : function(){
				alert("오류 발생");
			}
			
		});
		
	}
	
	function fn_shopJoinReject(shopNum2){
			
		var formData = new FormData();
		formData.append("SHOP_NUM", shopNum2);
		
		$.ajax({
			type : 'post',
			url : '/sk/brandPage/shopJoinReject',
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				 if(data.result == "pass"){
					//alert("해당 매장의 입점 요청을 거부하였습니다.");
					$("#joinBtnTr_"+shopNum2).remove();
					
					// 거부 후, 리스트에서 해당 매장이 사라지면 지도도 사라지도록 구현
					$("#map2").empty();
					str = "<div id='map' style='width: 1000px; height: 600px'></div>";
					$("#map2").append(str);
				 }else if(data.result == "fail") {
					 alert("해당 매장의 입점 요청을 거부하지 못했습니다.");
				 }
			},
			error : function(){
				alert("오류 발생");
			}
			
		});
		
	}
	
	$("a[name='shopLocationInfo']").on("click", function(e){  // 입점 요청 매장 위치 조회
		e.preventDefault();
		const shopNum = $(this).attr('data-shopNum');  // 매장번호 받아와서 shopNum에 저장
		$('#SHOP_NUM').val(shopNum);  // id가 SHOP_NUM인 부분(value 비어있음)에 shopNum 넣어주기
		
		var formData = new FormData(document.getElementById("shopInfoForm"));
		
		$.ajax({
			type : 'post',
			url : '/sk/brandPage/shopLocationInfo',
			data : formData,
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
				iwContent = `<div
			        style="
			          padding: 15px 20px 20px 15px;
			          width: 400px;
			          height: 180px;
			          box-shadow: 2px 2px 2px 2px gray;
			          border: none;
			        "
			      >
			        <h4 class="mb-4" style="font-weight: 700">`+data.SHOP_NAME+`</h4>
			        <p class="mb-1">`+data.SHOP_ADD+`</p>
			        <p style="color: forestgreen">`+data.SHOP_TEL+`</p>
			        <p>`+data.SHOP_START_TIME+` ~ `+data.SHOP_END_TIME+`</p>
			      </div>`
				// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
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
function fn_selectShopRequestList(pageNo){
	var comAjax = new ComAjax();
	comAjax.setUrl("/sk/brandPage/shopRequestList/paging");
	comAjax.setCallback("fn_selectShopRequestListCallback");
	comAjax.addParam("PAGE_INDEX",pageNo);
	comAjax.addParam("PAGE_ROW", 5); //한 페이지에 보여줄 게시글 수 정하기
	comAjax.ajax();
}

// 페이징 콜백 함수
function fn_selectShopRequestListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
	var total = data.TOTAL;
	var body = $("#shopRequestListTbody"); // 페이징 한 결과가 반영될 태그
	
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
			eventName : "fn_selectShopRequestList" // 페이징 함수이름 동일하게
		};
		gfn_renderPaging(params);
		
		var str = "";
		$.each(data.shopRequestList, function(key, value){ // 가져온 게시글 수 만큼 반복 실행
			str += "<tr id=joinBtnTr_" + value.SHOP_NUM + ">" + 
			 	   "<th scope='rowspan-3' style='width: 25%; text-align: center;'>" +
			 	   "<a href='#' name='shopLocationInfo' data-shopNum='" + value.SHOP_NUM + "'>" +
			 	   "<h5 style='margin-top: 18%;'>" + value.SHOP_NAME + "</h5></a></th>" + 
			 	   "<td style='text-align: left;margin-bottom: 1; width: 200px;'>" +
			 	   "<p style='font-weight: bolder;'>전화번호</p>" +
			 	   "<p style='font-weight: bolder;'>주소</p>" +
			 	   "<p style='font-weight: bolder;'>영업시간</p></td>" +
			 	   "<td style='text-align: left;'>" +
			 	   "<p style='font-size: medium;'>" + value.SHOP_TEL + "</p>" + 
			 	   "<p style='font-size: medium;'>" + value.SHOP_ADD + "</p>" +
			 	   "<p style='font-size: medium;'>" + value.SHOP_START_TIME + " ~ " + value.SHOP_END_TIME + "</p></td>" +
			 	   "<td style='font-weight: bolder; text-align: center; width: 200px;'><br><p></p>" +
			 	   "<button type='button' class='btn btn-primary btn-md' name='shopJoinApprove' " +
			 	   "data-shopNum1='" + value.SHOP_NUM + "'>승인</button>" + 
			 	   "<button type='button' class='btn btn-secondary btn-md' name='shopJoinReject' " + 
			 	   "data-shopNum2='" + value.SHOP_NUM + "'>거부</button></td></tr>"
		});
		body.append(str);
		
		
		// 게시글 클릭 시 작동될 함수 추가
		$("button[name='shopJoinApprove']").on("click", function(e){  // 입점 요청 매장 승인하기
			e.preventDefault();
			const shopNum1 = $(this).attr("data-shopNum1");
			
			fn_shopJoinApprove(shopNum1);
		});
		
		$("button[name='shopJoinReject']").on("click", function(e){  // 입점 요청 매장 거부하기
			e.preventDefault();
			const shopNum2 = $(this).attr("data-shopNum2");
			
			fn_shopJoinReject(shopNum2);
		});
		
		
		function fn_shopJoinApprove(shopNum1){
			
			var formData = new FormData();
			formData.append("SHOP_NUM", shopNum1);
			
			$.ajax({
				type : 'post',
				url : '/sk/brandPage/shopJoinApprove',
				data : formData,
				processData : false,
				contentType : false,
				success : function(data){
					 if(data.result == "pass"){
						alert("해당 매장의 입점 요청을 승인하였습니다.");
						$("#joinBtnTr_"+shopNum1).remove();
						
						// 승인 후, 리스트에서 해당 매장이 사라지면 지도도 사라지도록 구현
						$("#map2").empty();
						str = "<div id='map' style='width: 1000px; height: 600px'></div>";
						$("#map2").append(str);
						_movePage(1);
						total = total - 1;
						
						//alert(total);
						if(total == 0){
							$("#PAGE_NAVI").remove();
						}
						
					 }else if(data.result == "fail") {
						 alert("해당 매장의 입점 요청을 승인하지 못했습니다.");
					 }
				},
				error : function(){
					alert("오류 발생");
				}
				
			});
			
		}
		
		function fn_shopJoinReject(shopNum2){
				
			var formData = new FormData();
			formData.append("SHOP_NUM", shopNum2);
			
			$.ajax({
				type : 'post',
				url : '/sk/brandPage/shopJoinReject',
				data : formData,
				processData : false,
				contentType : false,
				success : function(data){
					 if(data.result == "pass"){
						alert("해당 매장의 입점 요청을 거부하였습니다.");
						$("#joinBtnTr_"+shopNum2).remove();
						
						// 거부 후, 리스트에서 해당 매장이 사라지면 지도도 사라지도록 구현
						$("#map2").empty();
						str = "<div id='map' style='width: 1000px; height: 600px'></div>";
						$("#map2").append(str);
						
						_movePage(1);
						total = total - 1;
						
						//alert(total);
						if(total == 0){
							$("#PAGE_NAVI").remove();
						}
						
					 }else if(data.result == "fail") {
						 alert("해당 매장의 입점 요청을 거부하지 못했습니다.");
					 }
				},
				error : function(){
					alert("오류 발생");
				}
				
			});
			
		}
		
		$("a[name='shopLocationInfo']").on("click", function(e){  // 입점 요청 매장 위치 조회
			e.preventDefault();
			const shopNum = $(this).attr('data-shopNum');  // 매장번호 받아와서 shopNum에 저장
			$('#SHOP_NUM').val(shopNum);  // id가 SHOP_NUM인 부분(value 비어있음)에 shopNum 넣어주기
			
			var formData = new FormData(document.getElementById("shopInfoForm"));
			
			$.ajax({
				type : 'post',
				url : '/sk/brandPage/shopLocationInfo',
				data : formData,
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
					iwContent = `<div
				        style="
				          padding: 15px 20px 20px 15px;
				          width: 400px;
				          height: 180px;
				          box-shadow: 2px 2px 2px 2px gray;
				          border: none;
				        "
				      >
				        <h4 class="mb-4" style="font-weight: 700">`+data.SHOP_NAME+`</h4>
				        <p class="mb-1">`+data.SHOP_ADD+`</p>
				        <p style="color: forestgreen">`+data.SHOP_TEL+`</p>
				        <p>`+data.SHOP_START_TIME+` ~ `+data.SHOP_END_TIME+`</p>
				      </div>`
					// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
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
	}
}


</script>       
</body>
</html>