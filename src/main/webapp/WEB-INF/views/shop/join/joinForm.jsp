<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<div class="container" style="width: 600px">
      <div class="box-shadow-full" style="margin-top: 100px">
        <form id="shopJoinForm" class="needs-validation" novalidate action="/sk/shop/joinSuccess" method="post">
          <div class="row mb-4 text-center">
            <h1>SHOEKETING</h1>
            <h6>(매장회원)</h6>
          </div>
          <div class="row">
            <div class="mb-3">
              <label
                for="SHOP_ID"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >아이디</label
              >
              <input
                class="form-control"
                type="text"
                id="SHOP_ID"
                name="SHOP_ID"
                required
              />
            </div>

            <div class="mb-3">
              <label
                for="SHOP_PW"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >비밀번호*</label
              >
              <input
                type="password"
                class="form-control"
                id="SHOP_PW"
                name="SHOP_PW"
                pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$"
              	placeholder="특수문자, 문자, 숫자 포함 형태의 8~16자리 이내"
                required
              />
            </div>

            <div class="mb-3">
              <label
                for="SHOP_PW2"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >비밀번호 확인*</label
              >
              <input
                type="password"
                class="form-control"
                id="SHOP_PW2"
                name="SHOP_PW2"
                pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$"
                required
              />
            </div>

			<div class="mb-3">
              <label
                for="SHOP_BRAND"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >브랜드이름</label
              >
              <input
                class="form-control"
                type="text"
                id="SHOP_BRAND"
                name="SHOP_BRAND"
                required
              />
            </div>
			
            <div class="mb-3">
              <label
                for="SHOP_NAME"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >지점명</label
              >
              <input
                class="form-control"
                type="text"
                id="SHOP_NAME"
                name="SHOP_NAME"
                required
              />
            </div>

            <div class="mb-3">
              <label
                for="SHOP_TEL"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >연락처</label
              >
              <input
                class="form-control"
                type="tel"
                id="SHOP_TEL"
                name="SHOP_TEL"
                placeholder="전화번호입력"
                pattern="^(02|0[3-9]{1}[0-9]{1})-[1-9]{1}[0-9]{2,3}-[0-9]{4}$"
                
                required
              />
            </div>

            <div class="mb-3">
              <label
                for="SHOP_START_TIME"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >매장 영업시간</label
              >
              <div class="d-flex">
              <input
                class="form-control me-3"
                type="time"
                id="SHOP_START_TIME"
                name="SHOP_START_TIME"
                placeholder="시작 시간"
                required
              />
                ~
              <input
                class="form-control ms-3"
                type="time"
                id="SHOP_END_TIME"
                name="SHOP_END_TIME"
                placeholder="마감 시간"
                required
              />
            </div>
            </div>

            <div class="mb-3">
              <label
                for="SHOP_ADD"
                class="form-label"
                style="font-size: large; font-weight: bolder"
                >매장 주소</label
              >
              <div class="d-flex">
	              <input
	                class="form-control"
	                type="text"
	                id="SHOP_ADD"
	                name="SHOP_ADD"
	                required
	              />
	              <button type="button" class="btn btn-outline-primary" style="width:8rem;" onclick="sample6_execDaumPostcode()">주소찾기</button>
              </div>
              <input type="hidden" id="SHOP_POS1" name="SHOP_POS1" value="" />
              <input type="hidden" id="SHOP_POS2" name="SHOP_POS2" value="" />
            </div>
            
            <div class="row">
		      	<div class="col-auto">
		      		<div id="map" style="width: 480px; height: 500px"></div>
		      	</div>
		      </div>
          </div>

          <hr class="my-4" />
          <button
            class="btn btn-primary btn-lg"
            style="margin-left: 30%; width: 45%"
            type="submit"
            id="shopJoin"
          	name="shopJoin"
          >
            가입하기
          </button>
        </form>
      </div>
    </div>
</body>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08e2c5126e1c7f5ac14b68c3f37365ad&libraries=services,clusterer,drawing"></script>

<script
    type="text/javascript"
    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=08e2c5126e1c7f5ac14b68c3f37365ad"
  ></script>
<script type="text/javascript">

    function sample6_execDaumPostcode() {
    	const shopName = $("#SHOP_NAME").val();
    	if(shopName == null || shopName == "") {
    		alert("지점명을 먼저 입력해주세요");
    		return false;
    	}
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
    
    
  //유효성검증
	(() => {
		  'use strict'

		  // Fetch all the forms we want to apply custom Bootstrap validation styles to
		  const forms = document.querySelectorAll('.needs-validation');

//Loop over them and prevent submission
Array.from(forms).forEach((form) => {
form.addEventListener('submit', (event) => {
    var pass = true;
    
    if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
        pass = false;
    }

    form.classList.add('was-validated');
    
  //비밀번호
    let pwdval = $('#SHOP_PW').val()
     let pwdokval = $('#SHOP_PW2').val()
     let pwdcheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
     
     if(pwdval == null || $.trim(pwdval) == "") {
   	  $("#pw-null").show();
		  $("#pw-type").hide();
	      $("#SHOP_PW").focus();
     } else if(!pwdcheck.test(pwdval)) {
   	  $("#pw-null").hide();
		  $("#pw-type").show();
	      $("#SHOP_PW").focus();
     } else {
   	  $("#pw-null").hide();
		  $("#pw-type").hide();
     }
     
     if(pwdokval == null || $.trim(pwdokval) == "") {
   	  $("#pw2-null").show();
		  $("#pw2-same").hide();
	      $("#SHOP_PW2").focus();
     } else if(pwdval!==pwdokval) {
   	  $("#pw2-null").hide();
		  $("#pw2-same").show();
	      $("#SHOP_PW2").focus();
     } 
     
   //전화번호
     var shopTel = $('#SHOP_TEL').val();
     var shopTelCheck = /^(02|0[3-9]{1}[0-9]{1})-[1-9]{1}[0-9]{2,3}-[0-9]{4}$/;
     
     if(!shopTelCheck.test(shopTel)){
   	  alert('잘못된 전화 번호입니다.');
   	  $('#SHOP_TEL').focus();
   	  
     }
    
});
});
})()
</script>

</html>