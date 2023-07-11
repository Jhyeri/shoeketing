<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08e2c5126e1c7f5ac14b68c3f37365ad&libraries=services,clusterer,drawing"></script>

<script
    type="text/javascript"
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08e2c5126e1c7f5ac14b68c3f37365ad"
  ></script>
<script>
    function sample6_execDaumPostcode() {
    
    	const shopName = $("#SHOP_NAME").val();
    	
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                
                const mapContainer = document.getElementById("map"), // 지도를 표시할 div
                mapOption = {
                  center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                  level: 3, // 지도의 확대 레벨
                };

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("SHOP_ADD").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("SHOP_ADD").focus();
                
                const address = $("#SHOP_ADD").val();

                // 지도를 생성합니다
                const map = new kakao.maps.Map(mapContainer, mapOption);

                // 주소-좌표 변환 객체를 생성합니다
                const geocoder = new kakao.maps.services.Geocoder();

                // 주소로 좌표를 검색합니다
                geocoder.addressSearch(
                  address,
                  function (result, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === kakao.maps.services.Status.OK) {
                      var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                      // 결과값으로 받은 위치를 마커로 표시합니다
                      var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                      });

                      // 인포윈도우로 장소에 대한 설명을 표시합니다
                      var infowindow = new kakao.maps.InfoWindow({
                    		  content:
                                  '<div style="width:150px; box-shadow: 2px 2px 2px 2px gray; text-align:center;padding:6px 0;">'+ shopName +'</div>',
                      });
                      infowindow.open(map, marker);

                      // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                      map.setCenter(coords);
                      
                      $("#SHOP_POS1").val(coords.La);
                      $("#SHOP_POS2").val(coords.Ma);
                      
                      console.log($("#SHOP_POS1").val());
                      console.log($("#SHOP_POS2").val());
                    }
                  }
                );
            }
        }).open();
    }
</script>

</head>
<body>

<div class="col-8" style="margin-top: 0px;">
          <h3 style="margin-left: 30px; color: black; font-weight: bolder;">회원 정보 수정</h3>
          <br>
			<form id="accountModifyForm" class="needs-validation" method="post" novalidate >
          <div class="row g-2">
              <div class="mb-3" style="width: 45%; margin-left: 30%;">
                  <label for="SHOP_ID" class="form-label" style="font-size: large; font-weight: bolder;">아이디</label>
                  <input class="form-control" type="text" id="SHOP_ID" name="SHOP_ID" value="${shopInfoMap.SHOP_ID}" aria-label="Disabled input example" disabled>
                </div>

                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                  <label for="SHOP_PW" class="form-label" style="font-size: large; font-weight: bolder;">비밀번호*</label>
                  <input type="password" name="SHOP_PW" class="form-control" id="SHOP_PW" name="SHOP_PW" 
                  	pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$"
              		placeholder="특수문자, 문자, 숫자 포함 형태의 8~16자리 이내" required>
              		<div id="pw-null" class="invalid-feedback">
				      비밀번호를 입력해주세요
				  	</div>
				  	<div id="pw-type" class="invalid-feedback">
				      비밀번호 형식이 올바르지 않습니다
				  	</div>
                </div>

                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                  <label for="SHOP_PW_CHECK" class="form-label" style="font-size: large; font-weight: bolder;">비밀번호 확인*</label>
                  <input type="password" id="SHOP_PW_CHECK" name="SHOP_PW_CHECK" class="form-control" 
                  pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" required>
                  <div id="pw2-null" class="invalid-feedback">
				      비밀번호 확인이 필요합니다
				  	</div>
		            <div id="pw2-same" class="invalid-feedback">
				      비밀번호가 일치하지 않습니다
				  	</div>
                </div>

                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                  <label for="SHOP_NAME" class="form-label" style="font-size: large; font-weight: bolder;">지점명</label>
                  <input class="form-control" type="text" id="SHOP_NAME" name="SHOP_NAME" value="${shopInfoMap.SHOP_NAME}" aria-label="Disabled input example" disabled>
                </div>

                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                  <label for="SHOP_TEL" class="form-label" style="font-size: large; font-weight: bolder;">연락처</label>
                  <input class="form-control" type="text" id="SHOP_TEL" name="SHOP_TEL" value="${shopInfoMap.SHOP_TEL}" aria-label="Disabled input example" >
                </div>

                <div class="mb-3" style="width: 45%; margin-left: 30%;">
                  <label for="SHOP_START_TIME" class="form-label" style="font-size: large; font-weight: bolder;">매장 영업 시간</label>
                  <table>
                  <tr>
                  <td>
                  <input type="text" name="SHOP_START_TIME" class="form-control" id="SHOP_START_TIME" style="width: 100%;" value="${shopInfoMap.SHOP_START_TIME}">
                  </td>
                  <td>
                    <label for="SHOP_END_TIME" class="form-label" style="font-size: large; margin-left: 25px;">~</label>
                  </td>
                  <td>
                  <input type="text" name="SHOP_END_TIME" class="form-control" id="SHOP_END_TIME" style="width: 80%; margin-left: 30px;" value="${shopInfoMap.SHOP_END_TIME}">
                </td>
                </tr>
                </table>
              </div>             
              
              <div class="mb-3" style="width: 45%; margin-left: 30%;">
                <label for="SHOP_ADD" class="form-label" style="font-size: large; font-weight: bolder;">매장 주소</label>
                <input type="text" name="SHOP_ADD" class="form-control" id="SHOP_ADD" value="${shopInfoMap.SHOP_ADD}">
                <button type="button" style="margin-top: 3%;" class="btn btn-primary" onclick="sample6_execDaumPostcode()">매장 위치 검색</button>
            	<input type="hidden" id="SHOP_POS1" name="SHOP_POS1" value="" />
              	<input type="hidden" id="SHOP_POS2" name="SHOP_POS2" value="" />
            </div> 
            
            <!-- 지도 표시 -->
            <div class="row justify-content-center">
		      		<div id="map" style="margin-left: 10%; width: 450px; height: 500px"></div>
		      	</div>
		      </div>
		      </form>
          </div>

              <hr class="my-4">
              <button class="btn btn-primary btn-lg" name="shopPageAccountModify" style="margin-left: 30%; width: 45%;" type="submit" data-shopNum="${shopInfoMap.SHOP_NUM}">회원 정보 수정하기</button>

<script type="text/javascript">
$(document).ready(function(){
    // 매장 회원정보 수정 버튼 클릭 시 실행
    $("button[name='shopPageAccountModify']").on("click", function(e){
        e.preventDefault();
        const shopNum = $(this).attr("data-shopNum");
        if(isValidForm()){
            // 유효성 검사를 통과한 경우 매장 정보 수정 함수 호출
            fn_shopPageAccountModify(shopNum);    
        }
    });
	
 // 유효성 검사 함수
    function isValidForm() {
        var form = $(".needs-validation")[0];
        if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
            form.classList.add('was-validated');
            return false;
        }
        
		form.classList.add('was-validated');
		
		// 비밀번호 검사
        let pwdval = $('#SHOP_PW').val()
        let pwdokval = $('#SHOP_PW_CHECK').val()
        let pwdcheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
        
        if(pwdval == null || $.trim(pwdval) == "") {
            alert("비밀번호를 입력해주세요.");
            event.preventDefault();
            event.stopPropagation();
            return false;
        }
        
        if(pwdokval == null || $.trim(pwdokval) == "") {
            $("#pw2-null").show();
            $("#pw2-same").hide();
            $("#SHOP_PW_CHECK").focus();
            return false;
        } else if(pwdval!==pwdokval) {
            $("#pw2-null").hide();
            $("#pw2-same").show();
            $("#SHOP_PW_CHECK").focus();
            return false;
        }
        
        return true;
    }
    
 // 매장 정보 수정 함수
	function fn_shopPageAccountModify(shopNum){
		var formData = new FormData();
		
		var shopPw = $("#SHOP_PW").val();
		var shopTel = $("#SHOP_TEL").val();
		var shopStartTime = $("#SHOP_START_TIME").val();
		var shopEndTime = $("#SHOP_END_TIME").val();
		var shopAdd = $("#SHOP_ADD").val();
		var shopPos1 = $("#SHOP_POS1").val();
		var shopPos2 = $("#SHOP_POS2").val();
		
		formData.append("SHOP_NUM", shopNum);
		formData.append("SHOP_PW", shopPw);
		formData.append("SHOP_TEL", shopTel);
		formData.append("SHOP_START_TIME", shopStartTime);
		formData.append("SHOP_END_TIME", shopEndTime);
		formData.append("SHOP_ADD", shopAdd);
		formData.append("SHOP_POS1", shopPos1);
		formData.append("SHOP_POS2", shopPos2);
		
		$.ajax({
			type : 'post',
			url : '/sk/shopPage/accountModify',
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				if(data.modifyResult == "pass"){
					alert("매장 정보가 정상적으로 수정되었습니다.");
					location.href='/sk/shopPage';
				}else if(data.modifyResult == "fail"){
					alert("매장 정보가 수정되지 못했습니다.");
				}
			},
			error : function(){
				alert("오류 발생");
			}
		});		
	}
	
});


		//유효성검증
		//Example starter JavaScript for disabling form submissions if there are invalid fields
		(() => {
		'use strict'
		
		//Fetch all the forms we want to apply custom Bootstrap validation styles to
		// 모든 폼에 유효성 검사 스타일 적용
		const forms = document.querySelectorAll('.needs-validation')
		
		//Loop over them and prevent submission
		forms.forEach(form => {
		form.addEventListener('submit', event => {
			// 폼이 유효하지 않으면 기본 이벤트를 막고 스타일을 적용합니다.
		if (!form.checkValidity()) {
		 event.preventDefault()
		 event.stopPropagation()
		 form.classList.add('was-validated');
		} else {
		 form.classList.add('was-validated');
		}
		
		//비밀번호
		let pwdval = $('#SHOP_PW').val()
		let pwdokval = $('#SHOP_PW_CHECK').val()
		let pwdcheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
		
		if(pwdval == null || $.trim(pwdval) == "") {
			alert("비밀번호를 입력해주세요.");
			event.preventDefault();
			event.stopPropagation();
			return false;
			}
		
		if(pwdokval == null || $.trim(pwdokval) == "") {
			  $("#pw2-null").show();
				  $("#pw2-same").hide();
			      $("#SHOP_PW_CHECK").focus();
		} else if(pwdval!==pwdokval) {
			  $("#pw2-null").hide();
				  $("#pw2-same").show();
			      $("#SHOP_PW_CHECK").focus();
		}




}, false);
});
})();

</script>
</body>
</html>