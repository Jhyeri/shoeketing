<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>

<script>
// 전역변수 설정
var socket  = null;
var toastCnt = 0;
$(document).ready(function(){
    // 웹소켓 연결
    sock = new SockJS("<c:url value="/inform-ws"/>");
    socket = sock;
    
    // 데이터를 전달 받았을때 
    sock.onmessage = onMessage; // toast 생성
});

// toast생성 및 추가
function onMessage(evt){
    var data = evt.data;
    
    let str = '<div id="informToast_';
    str += toastCnt;
    str += '" class="toast" role="alert" aria-live="assertive" aria-atomic="true">';
    str += '<div class="toast-header">';
	str += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-alarm" viewBox="0 0 16 16">';
	str += '<path d="M8.5 5.5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5z"/>';
	str += '<path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07a7.001 7.001 0 0 0-3.273 12.474l-.602.602a.5.5 0 0 0 .707.708l.746-.746A6.97 6.97 0 0 0 8 16a6.97 6.97 0 0 0 3.422-.892l.746.746a.5.5 0 0 0 .707-.708l-.601-.602A7.001 7.001 0 0 0 9 2.07V1h.5a.5.5 0 0 0 0-1h-3zm1.038 3.018a6.093 6.093 0 0 1 .924 0 6 6 0 1 1-.924 0zM0 3.5c0 .753.333 1.429.86 1.887A8.035 8.035 0 0 1 4.387 1.86 2.5 2.5 0 0 0 0 3.5zM13.5 1c-.753 0-1.429.333-1.887.86a8.035 8.035 0 0 1 3.527 3.527A2.5 2.5 0 0 0 13.5 1z"/>';
	str += '</svg>';
	str += '<strong class="me-auto">알림</strong>';
	str += '<small>just now</small>';
	str += '<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>';
	str += '</div>';
	str += '<div class="toast-body">';
	str += data;
	str += '</div></div>';
	
	$(".toast-container").prepend(str);
	
	const informToast = document.getElementById('informToast_' + toastCnt);
    const toast = new bootstrap.Toast(informToast);
    toast.show();
	toastCnt = toastCnt + 1;
};	
</script>

	<div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="informOffcanvas" aria-labelledby="offcanvasWithBothOptionsLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasWithBothOptionsLabel">알림</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <!-- inform 내용 시작 -->
      <div class="offcanvas-body">
      </div>
      <!-- inform 내용 끝 -->
    </div>

<!-- ======= Header ======= -->
<header id="header" class="ms-5 me-5 mt-2 mb-1">
  <div class="container d-flex align-items-center justify-content-between">
    <h1 class="logo fs-1"><a href="/sk/main">SHOEKETING</a></h1>

    <nav id="navbar" class="navbar justify-content-end">
      <ul>
      	<li>
	      <c:if test="${session_MEM_INFO.MEM_ADMIN == 'Y' }">
	      	<a class="nav-link scrollto" href="/sk/admin/noticeList" style="font-size: 13px">관리자</a>
	      </c:if>
      	</li>
        <li>
          <c:choose>
          	<c:when test="${session_MEM_ID != null and session_MEM_ADMIN == 'N'}">
          		<a class="nav-link scrollto" href="/sk/myPage" style="font-size: 13px">마이페이지</a>
			</c:when>
			<c:when test="${session_BRAND_ID != null}">
          		<a class="nav-link scrollto" href="/sk/brandPage" style="font-size: 13px">마이페이지</a>
			</c:when>
			<c:when test="${session_SHOP_ID != null}">
          		<a class="nav-link scrollto" href="/sk/shopPage" style="font-size: 13px">마이페이지</a>
			</c:when>
		  </c:choose>          
        </li>
        <li>
        <c:choose>
        <c:when test="${session_MEM_ID==null && session_BRAND_ID==null && session_SHOP_ID==null}">
          <a class="nav-link scrollto" href="/sk/loginSelect/member" style="font-size: 13px"
            >로그인</a
          >
         </c:when>
         <c:otherwise>
          <a class="nav-link scrollto" href="#" name="logout" style="font-size: 13px"
            >로그아웃</a>
          </c:otherwise>
          </c:choose>
        </li>
      </ul>
    </nav>
    <!-- .navbar -->
  </div>

  <div class="container d-flex align-items-center justify-content-between">
    <nav id="navbar" class="navbar">
      <ul>
        <li class="ps-0">
          <a class="nav-link scrollto" href="/sk/goods/totalList" style="font-size: 13px"
            >제품 보기</a
          >
        </li>
        <li>
          <a class="nav-link scrollto" href="/sk/goods/stockSearchForm" style="font-size: 13px"
            >제품 찾기</a
          >
        </li>
      </ul>
    </nav>
    <!-- .navbar -->

    <nav id="navbar" class="navbar justify-content-end">
      <ul>
        <li>
        	<c:if test="${session_MEM_ID != null}">
	          <a class="nav-link scrollto" href="/sk/basket/basketList"
	            ><svg
	              xmlns="http://www.w3.org/2000/svg"
	              width="20"
	              height="20"
	              fill="currentColor"
	              class="bi bi-basket"
	              viewBox="0 0 16 16"
	            >
	              <path
	                d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1v4.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 13.5V9a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h1.217L5.07 1.243a.5.5 0 0 1 .686-.172zM2 9v4.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V9H2zM1 7v1h14V7H1zm3 3a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 4 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 6 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 8 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 1 .5-.5zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 1 .5-.5z"
	              /></svg
	          ></a>
	        </c:if>
        </li>
        <li>
        	<c:if test="${session_MEM_ID != null}">
	          <a id="informA" class="nav-link scrollto" href="#inform" data-bs-toggle="offcanvas" data-bs-target="#informOffcanvas"
	            ><svg
	              xmlns="http://www.w3.org/2000/svg"
	              width="20"
	              height="20"
	              fill="currentColor"
	              class="bi bi-bell position-relative"
	              viewBox="0 0 16 16"
	            >
	              <path
	                d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"
	              />
	              	<c:if test="${informCount != 0}">
		              	<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
		                    ${informCount }
		                </span>
		            </c:if>
	              </svg
	          ></a>
	        </c:if>
        </li>
        <li>
          <form action="/sk/totalSearch" class="needs-validation">
                <div class="input-group">
                <label for="validationCustom01" class="form_label"></label>
                  <input
                    class="form_control"
                    style="
                      height: 39px;
                      border-style: none;
                      border: solid 1px black;
                      border-right: none;
                      border-top-left-radius: 5px;
                      border-bottom-left-radius: 5px;
                    "
                    type="text"
                    name='keyword'
                    id = "validationCustom01"
                    required
                  />
                  <button
                    class="btn"
                    type="submit"
                    style="
                      background-color: white;
                      border: solid 1px black;
                      border-left: none;
                    "
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="15"
                      height="15"
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
        </li>
      </ul>
    </nav>
    <!-- .navbar -->
  </div>
</header>
<hr>

<!-- toast 실시간 알림창 -->
<div class="toast-container position-fixed bottom-0 end-0 p-3"></div>

<script type="text/javascript">
$(document).ready(function() {
	
	$("a[name='logout']").on("click", function(e) { // 로그아웃
		e.preventDefault();
		fn_logout();
	});
	
	function fn_logout() {
		$.ajax({
			url:'/sk/logout',
			success: function() {
				location.href='/sk/main';
			}
		});
	};
	
	$("#informA").on("click", function(e) {
		$.ajax({
			url : '/sk/inform',
			success : function(data) {
				$(".offcanvas-body").empty();
				$(".offcanvas-body")[0].innerHTML = data;
			}
		});
	});
	
	$(".offcanvas-body").on("click", "a[name='informA']", function(e) {
		e.preventDefault();
		const informNum = {'INFORM_NUM':$(this).attr('data-num')};
		const target = $(this).attr('href');
		
		$.ajax({
			url : '/sk/inform/confirmUpdate',
			type : 'post',
			data : JSON.stringify(informNum),
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				location.href = target;
			}
		});
	});
});
</script>