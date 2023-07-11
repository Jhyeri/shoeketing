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
	<form id="noticeSearchForm">
		<div class="row d-flex mb-4">
	        <div class="col-8">
		      <h3 style="margin-left: 30px; color: black; font-weight: bolder">
		        공지사항
		      </h3>
	      </div>
		     <div class="col input-group">
		         <select class="form-select-sm" style="width: 4rem; border-color: rgba(0, 0, 0, 0.263);" id="searchType" name="searchType">
		           <option selected value="total" <c:out value="${searchType eq 'total' ? 'selected' :''}"/>>전체</option>
		           <option value="title" <c:out value="${searchType eq 'title' ? 'selected' :''}"/>>제목</option>
		           <option value="content" <c:out value="${searchType eq 'content' ? 'selected' :''}"/>>내용</option>
		         </select>
		         <input type="text" class="form-control" name="keyword" id="keyword" value="${keyword }" />
		         <button
		           class="btn btn-outline-secondary"
		           type="button"
		           id="button-addon2"
		           name="noticeSearch"
		         >
		           검색
		         </button>
		     </div>
	    </div>
    </form>

      <table class="table" style="text-align: center">
        <thead>
          <tr>
            <th class="col-1">번호</th>
            <th class="col-9">제목</th>
            <th>게시일</th>
          </tr>
        </thead>
        <tbody class="table-group-divider" id="noticeListBody">
        	<!-- 공지사항 리스트 -->
        </tbody>
      </table>

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
	
	// 페이지 로딩 시 자동으로 1페이지 가져오기
	fn_selectNoticeList(${page}, '${searchType}', '${keyword}');

  $("#noticeListBody").on("click", "a[name='title']", function(e) {  // 공지사항 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
		var page = $('#PAGE_INDEX').val();
		var keyword = $('#keyword').val();
		var searchType = $('#searchType').val();
		location.href = "/sk/admin/noticeDetail?NOTICE_NUM=" + num  + "&page=" + page + "&keyword=" + keyword + "&searchType=" + searchType;
	});
});
  
  	/* 검색버튼 이벤트에 기존 ajax 함수 제거하고 페이징 함수 연결하기 */
	$("#noticeSearchForm").on("submit", function(e){  //공지사항 검색
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
		fn_selectNoticeList(1, searchType, keyword);
	});

	// 페이징 함수
	function fn_selectNoticeList(pageNo, searchType, keyword){ /* 매개변수 순서에 맞게 추가하기!! */
		var comAjax = new ComAjax();
		comAjax.setUrl("/sk/admin/noticeList/paging");
		comAjax.setCallback("fn_selectNoticeListCallback");
		comAjax.addParam("PAGE_INDEX",pageNo);
		comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시글 수 정하기
		
		/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 시작 */
		comAjax.addParam("keyword", keyword);
		comAjax.addParam("searchType", searchType);
		/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 끝 */
		
		comAjax.ajax();
	}
	
	// 페이징 콜백 함수
	function fn_selectNoticeListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
		var total = data.TOTAL;
		var body = $("#noticeListBody"); // 페이징 한 결과가 반영될 태그
		
		body.empty();
		
		if(total == 0){ // 결과가 없을 경우
			var str = "<tr>" + 
							"<td colspan='3'>조회된 결과가 없습니다.</td>" + 
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
				recordCount : 10,
				eventName : "fn_selectNoticeList" // 페이징 함수이름 동일하게
			};
			gfn_renderPaging(params);
			
			var str = "";
			$.each(data.noticeList, function(key, value){ // 가져온 게시글 수 만큼 반복 실행
				str += "<tr>" + 
							"<th scope='row'>" + value.NOTICE_NUM + "</td>" + 
							"<td style='text-overflow:ellipsis; overflow:hidden; white-space:nowrap; max-width:200px;'>" +
								"<a href='#' name='title' class='text-dark' data-num='" + value.NOTICE_NUM + "'>" + value.NOTICE_TITLE + "</a>" +
							"</td>" +
							"<td>" + value.NOTICE_DATE + "</td>" + 
						"</tr>";
			});
			body.append(str);
		}
	}

</script>
</html>