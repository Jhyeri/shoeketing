<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <style>
      .brandLogo {
        width: 150px;
        height: 120px;
        border: 1px solid rgba(0, 0, 0, 0.194);
      }

      .categoryMenu p {
        font-size: 14px;
      }
    </style>
    <div class="container">
      <!-- ======= Testimonials Section ======= -->
      <div class="testimonials paralax-mf pt-0 pb-0">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div
                class="testimonials-slider swiper"
                data-aos="fade-up"
                data-aos-delay="100"
              >
                <div class="swiper-wrapper">
                	<!-- 여기부터 시작 -->
                	<c:if test="${fn:length(brandList) > 0}">
	                	<c:forEach begin="1" end="${(fn:length(brandList)-1)/4+1 }" varStatus="num">
	                		<div class="swiper-slide">
			                    <div class="testimonial-box d-flex justify-content-between">
					                 <c:forEach begin="${num.index*4-3 }" end="${num.index*4 }" varStatus="status">
					                 	<c:choose>
						                 	<c:when test="${status.current > fn:length(brandList)}">
							                   	<div
												  class="author-test"
												  style="margin-left: 80px; margin-right: 80px; width: 150px; height: 120px;"
												>
												</div>
											</c:when>
											<c:otherwise>
												<div
												  class="author-test"
												  style="margin-left: 80px; margin-right: 80px"
												>
												  <a href="/sk/brand/main?BRAND_NUM=${brandList[status.current-1].BRAND_NUM }"
												    ><img
												      src="/sk/image/display?fileName=${brandList[status.current-1].BRAND_LOGO_FILE }"
												      class="rounded-circle b-shadow-a brandLogo"
												    />
												    <span
												      class="author"
												      style="font-size: 18px; margin-bottom: 0; color: black;"
												      >${brandList[status.current-1].BRAND_NAME }</span
												    ></a
												  >
												</div>
											</c:otherwise>
										</c:choose>
					                 </c:forEach>
			                    </div>
		                    </div>
	                	</c:forEach>
                	</c:if>
                </div>
                <div class="swiper-pagination"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- End Testimonials Section -->

      <div class="row g-3" style="margin-top: 3%">
        <div class="col-2 order-ms-last" style="margin-top: 0px">
        
          <!--카테고리 시작-->
          <div class="mb-5">
          	<div class="d-flex justify-content-between">
            	<h5 style="margin-left: 13%; color: black">카테고리</h5>
            	<a href="#" id="filterResetBtn" class="align-self-center" style="font-size:14px; color:rgba(0, 0, 0, 0.632); padding-right:2rem;"><i class="bi bi-arrow-clockwise"></i>전체해제</a>
            </div>
            <hr
              style="
                border: solid 1px rgb(73, 73, 73);
                width: 80%;
                margin-left: 5%;
              "
            />
            <ul>
              <li
                class="list-group-item d-flex justify-content-between lh-sm mt-4"
              >
                <div class="categoryMenu">
                  <p><a name="category" id="category" data-category="" href="#">전체</a></p>
                  <p><a name="category" id="category" data-category="S" href="#">스니커즈</a></p>
                  <p><a name="category" id="category" data-category="C" href="#">캔버스화</a></p>
                  <p><a name="category" id="category" data-category="R" href="#">러닝화</a></p>
                </div>
              </li>
            </ul>
          </div>
          <!--카테고리 끝-->

          <!--브랜드 시작-->
          <div>
            <h5 style="margin-left: 13%; color: black">필터</h5>
            <hr
              style="
                border: solid 1px rgb(73, 73, 73);
                width: 80%;
                margin-left: 5%;
              "
            />
            <h6 style="margin-left: 13%; color: black">브랜드</h6>
            <form>
              <div class="input-group mt-3" style="margin-left: 13%">
                <input
                  id="brandInput"
                  class="header-input"
                  style="
                    height: 30px;
                    width: 130px;
                    border-style: none;
                    border: solid 1px black;
                    border-right: none;
                    border-top-left-radius: 5px;
                    border-bottom-left-radius: 5px;
                  "
                  type="text"
                />
                <button
                  id="brandSearchBtn"
                  class="btn"
                  type="button"
                  style="
                    height: 30px;
                    background-color: white;
                    border: solid 1px black;
                    border-left: none;
                  "
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="12"
                    height="12"
                    fill="currentColor"
                    class="bi bi-search mb-2"
                    viewBox="0 0 16 16"
                  >
                    <path
                      d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"
                    />
                  </svg>
                </button>
              </div>
            </form>
            <ul>
              <li
                class="list-group-item d-flex justify-content-between lh-sm mt-3"
              >
                <div
                  id="brandListDiv"
                  class="categoryMenu"
                  style="
                    overflow: auto;
                    width: 170px;
                    height: 150px;
                    font-size: 14px;
                  "
                >
                  <!-- 브랜드 리스트 -->
                </div>
              </li>
            </ul>
          </div>
          <!--브랜드 끝-->

          <hr
            style="
              border: solid 1px rgba(73, 73, 73, 0.498);
              width: 80%;
              margin-left: 5%;
            "
          />

          <!--사이즈 시작-->
          <div class="mb-5 mt-4">
            <h6 style="margin-left: 13%; color: black">사이즈</h6>
            <ul>
              <li
                class="list-group-item d-flex justify-content-between lh-sm mt-3"
              >
                <div class="categoryMenu" style="font-size: 14px">
                  <div class="row" style="width: 190px">
                    <div class="form-check col-3 ps-0 pe-1">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_200"
                        autocomplete="off"
                        value="200"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_200"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          200
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_205"
                        autocomplete="off"
                        value="205"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_205"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          205
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_210"
                        autocomplete="off"
                        value="210"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_210"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          210
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_215"
                        autocomplete="off"
                        value="215"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_215"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          215
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_220"
                        autocomplete="off"
                        value="220"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_220"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          220
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_225"
                        autocomplete="off"
                        value="225"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_225"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          225
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_230"
                        autocomplete="off"
                        value="230"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_230"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          230
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_235"
                        autocomplete="off"
                        value="235"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_235"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          235
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_240"
                        autocomplete="off"
                        value="240"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_240"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          240
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_245"
                        autocomplete="off"
                        value="245"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_245"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          245
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_250"
                        autocomplete="off"
                        value="250"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_250"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          250
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_255"
                        autocomplete="off"
                        value="255"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_255"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          255
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_260"
                        autocomplete="off"
                        value="260"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_260"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          260
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_265"
                        autocomplete="off"
                        value="265"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_265"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          265
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_270"
                        autocomplete="off"
                        value="270"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_270"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          270
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_275"
                        autocomplete="off"
                        value="275"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_275"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          275
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_280"
                        autocomplete="off"
                        value="280"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_280"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          280
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_285"
                        autocomplete="off"
                        value="285"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_285"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          285
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_290"
                        autocomplete="off"
                        value="290"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_290"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          290
                        </p></label
                      >
                    </div>

                    <div class="form-check col-3 ps-0">
                      <input
                        type="radio"
                        class="btn-check"
                        name="sizeType"
                        id="size_295"
                        autocomplete="off"
                        value="295"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_295"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 5px; right: 2px">
                          295
                        </p></label
                      >
                    </div>
                  </div>
                </div>
              </li>
            </ul>
          </div>
          <!--사이즈 끝-->

          <hr
            style="
              border: solid 1px rgba(73, 73, 73, 0.498);
              width: 80%;
              margin-left: 5%;
            "
          />

          <!--가격대 시작-->
          <div class="mb-5 mt-4">
            <h6 style="margin-left: 13%; color: black">가격대</h6>
            <ul class="ps-3">
              <li class="list-group-item justify-content-between lh-sm mt-3">
                <div class="categoryMenu" style="font-size: 14px">
                  <select
                    class="form-select"
                    aria-label="Default select example"
                    id="priceType"
                    name="priceType"
                  >
                    <option selected>가격대</option>
                    <option value="A">0 ~ 100,000</option>
                    <option value="B">100,000 ~ 200,000</option>
                    <option value="C">200,000 ~ 300,000</option>
                    <option value="D">300,000 ~ 400,000</option>
                    <option value="E">400,000 ~ 500,000</option>
                    <option value="F">500,000 ~ 600,000</option>
                  </select>
                </div>
              </li>
            </ul>
          </div>
          <!--가격대 끝-->
        </div>

        <div class="col-10" style="margin-top: 0px">
          <hr
            style="
              border: solid 1px rgba(73, 73, 73, 0.498);
              margin-top: 3.2%;
            "
          />

          <!--정렬 기준 nav 시작-->
          <div class="row mb-3">
            <nav class="navbar" style="width:1200px">
              <ul class="navbar justify-content-end" style="width:1200px">
                <li class="nav-item pt-0">
                  <a class="nav-link" name="listType" id="listType" data-num="최신순" style="font-weight: 400; font-size: 15px;" href="#">최신순</a>
                </li>
                <li class="nav-item pt-0">
                  <a class="nav-link" name="listType" id="listType" data-num="낮은가격순" style="font-weight: 400; font-size: 15px;" href="#">낮은가격순</a>
                </li>
                <li class="nav-item pt-0">
                  <a class="nav-link" name="listType" id="listType" data-num="높은가격순" style="font-weight: 400; font-size: 15px;" href="#">높은가격순</a>
                </li>
                <li class="nav-item pt-0">
                  <a class="nav-link" name="listType" id="listType" data-num="별점순" style="font-weight: 400; font-size: 15px;" href="#">별점순</a>
                </li>
                <li class="nav-item pt-0">
                  <a class="nav-link" name="listType" id="listType" data-num="찜순" style="font-weight: 400; font-size: 15px;" href="#">찜순</a>
                </li>
              </ul>
            </nav>
          </div>
          <!--정렬 기준 nav 끝-->

          <div class="row" id="goodsListDiv">
          	<!-- 상품 리스트 -->
          </div>
          
          <div class="row">
      	<!-- 페이징 화면 처리 부분 시작 -->
      	<div id="PAGE_NAVI"></div>
			<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
			<!-- 페이징 검색 조건 및 검색 키워드 input type hidden 시작 -->
			<input type="hidden" id="PAGE_LISTTYPE" name="PAGE_LISTTYPE"/>
			<input type="hidden" id="PAGE_CATEGORY" name="PAGE_CATEGORY"/>
			<input type="hidden" id="PAGE_BRANDTYPE" name="PAGE_BRANDTYPE"/>
			<input type="hidden" id="PAGE_SIZETYPE" name="PAGE_SIZETYPE"/>
			<input type="hidden" id="PAGE_PRICETYPE" name="PAGE_PRICETYPE"/>
			<!-- 페이징 검색 조건 및 검색 키워드 input type hidden 시작 -->
		<!-- 페이징 화면 처리 부분 끝 -->
		</div>
		
        </div>
    </div>
  </body>
  
<script type="text/javascript">
$(document).ready(function() {
	
	//페이지 로딩 시 자동으로 1페이지 가져오기
	fn_totalGoodsList(1);
	searchBrand('');
	
	$("#goodsListDiv").on("click", "a[name='title']", function(e) {  // 공지사항 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
		location.href="/sk/goods/goodsDetail?TOTAL_GOODS_NUM=" + num;
	});
	
	$("#filterResetBtn").on("click", function(e) {
		e.preventDefault();
		$("#brandInput").val('');
		$("input:radio[name='brandType']").prop("checked", false);
		$("input:radio[name='sizeType']").prop("checked", false);
		$("#priceType").find("option:eq(0)").prop("selected", true);
		$("#PAGE_INDEX").val('');
		$("#PAGE_LISTTYPE").val('');
		$("#PAGE_CATEGORY").val('');
		$("#PAGE_BRANDTYPE").val('');
		$("#PAGE_SIZETYPE").val('');
		$("#PAGE_PRICETYPE").val('');
		fn_totalGoodsList(1);
		searchBrand('');
	});
	
	$("#brandSearchBtn").on("click", function(e) {
		e.preventDefault();
		var brandName = $("#brandInput").val();
		searchBrand(brandName);
	});
	
	function searchBrand(brandName) {
		var formData = new FormData();
		formData.append("BRAND_NAME", brandName);
		
		$.ajax({
			url : '/sk/goods/totalList/brandList',
			type : 'POST',
			data : formData,
			contentType : false,
			processData : false,
			success : function(data) {
				$("#brandListDiv").empty();
				var str = "";
				
				$.each(data.brandList, function(key, value){
					str += "<div class='form-check mb-2'>";
					str += "<input class='form-check-input' type='radio' name='brandType' id='brandName";
					str += key;
					str += "' value='";
					str += value;
					str += "'/>";
					str += "<label class='form-check-label' for='brandName";
					str += key;
					str += "'>";
					str += value;
					str += "</label>";
					str += "</div>";
				});
				$("#brandListDiv").append(str);
			}
		});
	};
});

let listType = null;
let category = null;

$("a[name='listType']").on("click", function(e) { // 정렬 검색
	e.preventDefault();
	listType = $(this).attr("data-num");
	const bName = $("input[type=radio][name=brandType]:checked").val();
	const size = $("input[type=radio][name=sizeType]:checked").val();
	const selectedOption = $('#priceType').val();
	$("#PAGE_INDEX").val(1);
	$('#PAGE_LISTTYPE').val(listType);
	fn_totalGoodsList(1, '', '', listType, category, bName, size, selectedOption);
});

$("a[name='category']").on("click", function(e) { // 정렬 검색
	e.preventDefault();
	category = $(this).attr("data-category");
	const bName = $("input[type=radio][name=brandType]:checked").val();
	const size = $("input[type=radio][name=sizeType]:checked").val();
	const selectedOption = $('#priceType').val();
	$("#PAGE_INDEX").val(1);
	$('#PAGE_CATEGORY').val(category);
	fn_totalGoodsList(1, '', '', listType, category, bName, size, selectedOption);
}); 

$("#brandListDiv").on("change", "input[name='brandType']", function(){
	const bName = $("input[type=radio][name=brandType]:checked").val();
	const size = $("input[type=radio][name=sizeType]:checked").val();
	const selectedOption = $('#priceType').val();
	$("#PAGE_INDEX").val(1);
	$('#PAGE_BRANDTYPE').val(bName);
	fn_totalGoodsList(1, '', '', listType, category, bName, size, selectedOption);
});

$("input[name='sizeType']").change(function(){
	const bName = $("input[type=radio][name=brandType]:checked").val();
	const size = $("input[type=radio][name=sizeType]:checked").val();
	const selectedOption = $('#priceType').val();
	$("#PAGE_INDEX").val(1);
	$('#PAGE_SIZETYPE').val(size);
	fn_totalGoodsList(1, '', '', listType, category, bName, size, selectedOption);
});

$("select[name='priceType']").change(function(){
	const bName = $("input[type=radio][name=brandType]:checked").val();
	const size = $("input[type=radio][name=sizeType]:checked").val();
	const selectedOption = $('#priceType').val();
	$("#PAGE_INDEX").val(1);
	$('#PAGE_PRICETYPE').val(selectedOption);
	fn_totalGoodsList(1, '', '', listType, category, bName, size, selectedOption);
});


//페이징 함수
function fn_totalGoodsList(pageNo, searchType, keyword, listType, category, bName, size, selectedOption){
	var comAjax = new ComAjax();
	comAjax.setUrl("/sk/goods/totalList/paging");
	comAjax.setCallback("fn_totalGoodsListCallback");
	comAjax.addParam("PAGE_INDEX",pageNo);
	comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시글 수 정하기
	
	/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 시작 */
	comAjax.addParam("listType", listType);
	comAjax.addParam("categoryType", category);
	comAjax.addParam("brandType", bName);
	comAjax.addParam("sizeType", size);
	comAjax.addParam("priceType", selectedOption);
	/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 끝 */
	
	comAjax.ajax();
}

// 페이징 콜백 함수
function fn_totalGoodsListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
	var total = data.TOTAL;
	var body = $("#goodsListDiv"); // 페이징 한 결과가 반영될 태그
	
	body.empty();
	
	if(total == 0){ // 결과가 없을 경우
		var str = "등록된 상품이 없습니다.";
		body.append(str);
		$("#PAGE_NAVI").empty();
	} else { // 결과가 있을 경우
		var params = {
			divId : "PAGE_NAVI",
			pageIndex : "PAGE_INDEX",
			/* 페이징 검색 조건 및 검색 키워드 객체에 추가 시작 */
			listType : "PAGE_LISTTYPE",
			category : "PAGE_CATEGORY",
			brandType : "PAGE_BRANDTYPE",
			sizeType : "PAGE_SIZETYPE",
			priceType : "PAGE_PRICETYPE",
			/* 페이징 검색 조건 및 검색 키워드 객체에 추가 끝 */
			totalCount : total,
			recordCount : 10,
			eventName : "fn_totalGoodsList" // 페이징 함수이름 동일하게
		};
		gfn_renderPaging(params);
		
		var str = "";
		$.each(data.list, function(key, value){ // 가져온 게시글 수 만큼 반복 실행
			str += "<div class='card' style='width: 14rem; margin-left: 10px; margin-right: 10px; margin-bottom: 80px; border-style: none;'>" +
            "<a href='/sk/goods/goodsDetail?TOTAL_GOODS_NUM='" + value.TOTAL_GOODS_NUM+ "' name='title' data-num='" + value.TOTAL_GOODS_NUM + "'>" +
            "<img src='/sk/image/display?fileName=" + value.GOODS_IMAGE_STD + "' style='width:13rem; height: 11rem' class='card-img-top'>" +
            "<div class='card-body' style='height:6rem;'>" +
              "<h6 class='card-title' style='font-size: 15px; font-weight: 700;'>" + value.BRAND_NAME + "</h6>" +
              "<p class='card-text' style='font-size: 13px;'>" + value.TOTAL_GOODS_NAME + "/" +  value.TOTAL_GOODS_MODEL + "</p>" +
            "</div>" +
            "<div class='card-body'>" +
              "<h6 class='card-title mb-0' style='font-size: 18px; font-weight: 700;'>" + AddComma(value.TOTAL_GOODS_PRICE) + "원" +"</h6>" +
            "</div>" +
          "</a>" +
        "</div>"
		});
		body.append(str);
	}
}
</script>	
</html>