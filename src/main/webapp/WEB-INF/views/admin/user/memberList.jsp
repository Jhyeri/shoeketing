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
	    <div class="row d-flex mb-4 mt-5">
	        <div class="col-8">
	      <h3 style="margin-left: 30px; color: black; font-weight: bolder">
	        일반회원 관리
	      </h3>
		</div>
      	<div class="col input-group">
          <select class="form-select-sm" style="width: 4rem; border-color: rgba(0, 0, 0, 0.263);" id="searchType" name="searchType">
            <option selected value="total">전체</option>
            <option value="num">회원번호</option>
            <option value="email">아이디</option>
            <option value="name">이름</option>
            <option value="grade">회원등급</option>
            <option value="del_gb">탈퇴여부</option>
          </select>
          <input type="text" class="form-control" name="keyword" id="keyword" />
          <button
            class="btn btn-outline-secondary"
            type="button"
            id="memberSearch"
            name="memberSearch"
          >
            검색
          </button>
        </div>
      </div>

      <table class="table" style="text-align: center">
        <thead>
          <tr>
            <th class="col-1">회원번호</th>
            <th class="col-5">아이디</th>
            <th class="col-3">이름</th>
            <th class="col-2">회원등급</th>
            <th class="col-1">탈퇴여부</th>
          </tr>
        </thead>
        <tbody id="memberListBody" class="table-group-divider">
          <!-- 회원 리스트 -->
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
	if('${searchType}' != null && '${searchType}' != "") {
		$("#searchType").val("${searchType}").prop("selected", true);
	}
	if('${keyword}' != null && '${keyword}' != "") {
		$("#keyword").val('${keyword}');
	}
	
	
	// 페이지 로딩 시 자동으로 1페이지 가져오기
	fn_selectMemberList(${page}, '${searchType}', '${keyword}');

  $("#memberListBody").on("click", "a[name='title']", function(e) {  // 공지사항 상세보기
		e.preventDefault();
		const num = $(this).attr("data-num");  //a태그 name이 title 부분 속성의 data-num값 가져와서 변수 num에 저장
		var page = $('#PAGE_INDEX').val();
		var keyword = $('#keyword').val();
		var searchType = $('#searchType').val();
		location.href="/sk/admin/memberDetail?MEM_NUM=" + num + "&page=" + page + "&keyword=" + keyword + "&searchType=" + searchType;
	});
});
  
  	/* 검색버튼 이벤트에 기존 ajax 함수 제거하고 페이징 함수 연결하기 */
	$("button[name='memberSearch']").on("click", function(e){  //공지사항 검색
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
		fn_selectMemberList(1, searchType, keyword);
	});

	// 페이징 함수
	function fn_selectMemberList(pageNo, searchType, keyword){ /* 매개변수 순서에 맞게 추가하기!! */
		var comAjax = new ComAjax();
		comAjax.setUrl("/sk/admin/memberList/paging");
		comAjax.setCallback("fn_selectMemberListCallback");
		comAjax.addParam("PAGE_INDEX",pageNo);
		comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시글 수 정하기
		
		/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 시작 */
		comAjax.addParam("keyword", keyword);
		comAjax.addParam("searchType", searchType);
		/* 페이징 검색 조건 및 검색 키워드 파라미터 추가 끝 */
		
		comAjax.ajax();
	}
	
	// 페이징 콜백 함수
	function fn_selectMemberListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
		var total = data.TOTAL;
		var body = $("#memberListBody"); // 페이징 한 결과가 반영될 태그
		
		body.empty();
		
		if(total == 0){ // 결과가 없을 경우
			var str = "<tr>" + 
							"<td colspan='5'>조회된 결과가 없습니다.</td>" + 
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
				eventName : "fn_selectMemberList" // 페이징 함수이름 동일하게
			};
			gfn_renderPaging(params);
			
			var str = "";
			$.each(data.memberList, function(key, value){ // 가져온 게시글 수 만큼 반복 실행
				str += "<tr>" + 
							"<td>" + value.MEM_NUM + "</td>" + 
							"<td><a href='#' name='title' data-num='" + value.MEM_NUM + "'>" + value.MEM_EMAIL + "</a></td>" +
							"<td>" + value.MEM_NAME + "</td>" + 
							"<td>" + value.MEM_GRADE + "</td>" + 
							"<td>" + value.MEM_DEL_GB + "</td>" + 
						"</tr>";
			});
			body.append(str);
		}
	}

</script>  

</html>