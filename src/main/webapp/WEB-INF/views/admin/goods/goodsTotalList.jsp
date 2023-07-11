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
    <div class="col-10" style="margin-top: 0px">
      <div class="row d-flex mb-4">
        <div class="col-8">
          <h3 style="margin-left: 30px; color: black; font-weight: bolder">
            상품 관리
          </h3>
        </div>
        <div class="col input-group">
          <select
            class="form-select-sm"
            style="width: 6rem; border-color: rgba(0, 0, 0, 0.263)"
            id="searchType"
            name="searchType"
          >
            <option selected value="전체">전체</option>
            <option value="상품명">상품명</option>
            <option value="모델 번호">모델 번호</option>
            <option value="브랜드명">브랜드명</option>
          </select>
          <input type="text" class="form-control" name="keyword" id="keyword" />
          <button
            class="btn btn-outline-secondary"
            type="button"
            id="button-addon2"
            name="goodsSearch"
          >
            검색
          </button>
        </div>
      </div>

      <table class="table" style="width: 100%; margin-left: 30px">
        <tbody id="goodsListTbody" class="table-group-divider">
        <!-- 전체 상품 리스트 -->
        </tbody>
      </table>

      <hr class="my-4" style="margin-left: 30px; width: 100%" />
      
        <div class="row">
      	<!-- 페이징 화면 처리 부분 시작 -->
      	<div id="PAGE_NAVI"></div>
		<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
			<!-- 페이징 검색 조건 및 검색 키워드 input type hidden 시작 -->
			<input type="hidden" id="PAGE_SEARCHTYPE" name="PAGE_SEARCHTYPE"/>
			<input type="hidden" id="PAGE_KEYWORD" name="PAGE_KEYWORD"/>
			<!-- 페이징 검색 조건 및 검색 키워드 input type hidden 시작 -->
		<!-- 페이징 화면 처리 부분 끝 -->
		</div>
      
    </div>
  </body>
<script>
$(document).ready(function() {
	
	$('#PAGE_INDEX').val(${page});
	$('#PAGE_KEYWORD').val('${keyword}');
	$('#PAGE_SEARCHTYPE').val('${searchType}');
	if('${searchType}' != null && '${searchType}' != "") {
		$("#searchType").val("${searchType}").prop("selected", true);
	}
	if('${keyword}' != null && '${keyword}' != "") {
		$("#keyword").val('${keyword}');
	}
	
	// 페이지 로딩 시 자동으로 1페이지 가져오기
	fn_selectTotalGoodsList(${page}, '${searchType}', '${keyword}');

  $("#goodsListTbody").on("click", "a[name='goodsDetail']", function(e) {  // 상품 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");  //a태그 name이 goodsDetail 부분 속성의 data-num값 가져와서 변수 num에 저장
		location.href="/sk/goods/goodsDetail?TOTAL_GOODS_NUM=" + num;
  });
  
  $("#goodsListTbody").on("click", "button[name='goodsDelete']", function(e) {  // 상품 삭제하기
		e.preventDefault();
		const num = $(this).attr("data-num");  //button태그 name이 goodsDelete 부분 속성의 data-num값 가져와서 변수 num에 저장
		fn_deleteGoods(num);
  });
});

	function fn_deleteGoods(num) {
		var formData = new FormData();
		formData.append("TOTAL_GOODS_NUM", num);
		
		$.ajax({
			url : '/sk/admin/goodsDelete',
			type : 'POST',
			data : formData,
			contentType : false,
			processData : false,
			success : function(data) {
				if(data.result == "success") {
					alert("상품이 삭제되었습니다.");
					fn_selectTotalGoodsList($('#PAGE_INDEX').val(), "$('#PAGE_KEYWORD').val('${keyword}')", "$('#PAGE_SEARCHTYPE').val('${searchType}')");
				} else if(data.result == "fail") {
					alert("상품을 삭제하는 과정에서 오류가 발생했습니다.");
				}
			},
			error : function() {
				alert("상품 삭제 실패");
			}
		});
	};

	/* 검색버튼 이벤트에 기존 ajax 함수 제거하고 페이징 함수 연결하기 */
	$("button[name='goodsSearch']").on("click", function(e){  //공지사항 검색
		e.preventDefault();
		
		/* 페이징 검색 조건 및 검색 키워드 변수 초기화 시작 */
		var keyword = $('#keyword').val();
		var searchType = $('#searchType').val();
		/* 페이징 검색 조건 및 검색 키워드 변수 초기화 끝 */
		
		$('#PAGE_INDEX').val(1); /* 검색 시 1페이지로 */
		
		/* 페이징 검색 조건 및 검색 키워드 input type hidden에 값 넣어주기 시작 */
		$('#PAGE_KEYWORD').val(keyword);
		$('#PAGE_SEARCHTYPE').val(searchType);
		/* 페이징 검색 조건 및 검색 키워드 input type hidden에 값 넣어주기 끝 */
		
		/* 페이징 함수 매개변수에 맞게 함수 호출(매개변수 순서 및 위치 주의!!) */
		fn_selectTotalGoodsList(1, searchType, keyword);
	});

	// 페이징 함수
	function fn_selectTotalGoodsList(pageNo, searchType, keyword){ /* 매개변수 순서에 맞게 추가하기!! */
		var comAjax = new ComAjax();
		comAjax.setUrl("/sk/admin/goodsTotalList/paging");
		comAjax.setCallback("fn_selectTotalGoodsListCallback");
		comAjax.addParam("PAGE_INDEX",pageNo);
		comAjax.addParam("PAGE_ROW", 5); //한 페이지에 보여줄 게시글 수 정하기
		
		/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 시작 */
		comAjax.addParam("keyword", keyword);
		comAjax.addParam("searchType", searchType);
		/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 끝 */
		
		comAjax.ajax();
	}
	
	// 페이징 콜백 함수
	function fn_selectTotalGoodsListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
		var total = data.TOTAL;
		var body = $("#goodsListTbody"); // 페이징 한 결과가 반영될 태그
		
		body.empty();
		
		if(total == 0){ // 결과가 없을 경우
			var str = "<tr>" + 
							"<td colspan='4'>조회된 결과가 없습니다.</td>" + 
						"</tr>";
			body.append(str);
			$("#PAGE_NAVI").empty();
		} else { // 결과가 있을 경우
			var params = {
				divId : "PAGE_NAVI",
				pageIndex : "PAGE_INDEX",
				/* 페이징 검색 조건 및 검색 키워드 객체에 추가 시작 */
				searchType : "PAGE_SEARCHTYPE",
				keyword : "PAGE_KEYWORD",
				/* 페이징 검색 조건 및 검색 키워드 객체에 추가 끝 */
				totalCount : total,
				recordCount : 5,
				eventName : "fn_selectTotalGoodsList" // 페이징 함수이름 동일하게
			};
			gfn_renderPaging(params);
			
			var str = "";
			$.each(data.list, function(key, value){ // 가져온 게시글 수 만큼 반복 실행
				str += "<tr><th scope='rowspan-3' style='width: 25%'><a href='#' name='goodsDetail' data-num='"
					+ value.TOTAL_GOODS_NUM
					+ "'><image src='/sk/image/display?fileName="
					+ value.GOODS_IMAGE_STD
					+ "' height='120' width='120' style='margin-left: 20%' /></a></th>"
					+ "<td style='text-align: left; width: 35%; margin-left: 1; vertical-align: middle;'>"
					+ "<p class='mb-4' style='font-weight: bolder; font-size: large'>"
					+ value.BRAND_NAME
					+ "</p><p style='font-weight: bolder'>"
					+ value.TOTAL_GOODS_NAME
					+ " / "
					+ value.TOTAL_GOODS_MODEL
					+ "</p></td><td style='text-align: center; width: 20%; margin-bottom: 1; vertical-align: middle;'>"
					+ "<p class='mb-0' style='font-weight: bolder; font-size: large'>"
					+ value.TOTAL_GOODS_PRICE
					+ "원</p></td><td style='font-weight: bolder; text-align: center; vertical-align: middle;'>"
					+ "<div class='row justify-content-center'>"
					+ "<button class='btn btn-secondary' name='goodsDelete' data-num='"
					+ value.TOTAL_GOODS_NUM
					+ "' style='width:5rem;'>삭제</button>"
					+ "</div></td></tr>";
			});
			body.append(str);
		}
	}
</script>
</html>