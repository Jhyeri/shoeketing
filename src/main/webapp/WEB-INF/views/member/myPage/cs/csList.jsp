<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <!-- 모달 -->
<div class="modal fade" id="csDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content" style="width:600px; height: auto;">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">매장 문의 상세 정보</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mt-4 ms-3 row-cols-md-1">
            <table>
            <tr>
                <p style="font-weight: bolder; font-size: medium; margin-bottom: 0;" class="d_title" id="d_title"></p>
            </tr>
  
            <tr style="height: 70px;">
                <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
            </tr>
            <tr style="height: 70px;">
                <p style="font-size: medium; margin-bottom: 0;" class="d_content" id="d_content"></p>
            </tr>  
            <tr>
                <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
            </tr>
            
            &nbsp;
            <tr>
                <p style="font-weight: bolder; font-size: medium; margin-bottom: 0;">문의 답변</p>
            </tr>
            <tr style="height: 70px;">
                <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
            </tr>
            <tr style="height: 70px;">
                <p style="font-size: medium; margin-bottom: 0;" class="d_reply" id="d_reply"></p>
            </tr>  
          </table>
            </div>
            <br>
            <div class="modal-footer">
              <button type="button" class="btn btn-danger" name="delete">삭제</button>
            </div>
        </div>
        </div>
      </div>
    </div>
    <!-- 모달 끝 -->

        <div class="col-10" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;" data-num="${sessionScope.session_MEM_INFO.MEM_NUM}">나의 문의 내역</h3>
            <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
            <table class="table table table-bordered" style="text-align: center;">
                <thead>
                  <tr style="width: 30%;">
                    <th>제목</th>
                    <th>작성 날짜</th>
                    <th>처리 상태</th>
                  </tr>
                </thead>
                <tbody id="csListTbody">
              		<c:forEach var="CS" items="${CSList}">
                  		<tr id="csListTr">
                    		<td style="width: 40%;"><a href="#" data-bs-toggle="modal" data-bs-target="#csDetail" name="title" data-num="${CS.CS_NUM}">${CS.CS_TITLE}</a></td>
                    		<td style="width: 30%;">${CS.CS_DATE}</td>
                    		<td style="width: 30%;">${CS.CS_STATUS}</td>
                  		</tr>
               		</c:forEach>
                </tbody>
            </table>
             
				 <!-- 페이징 화면 처리 부분 시작 -->
			      	<div id="PAGE_NAVI"></div>
					<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
				 <!-- 페이징 화면 처리 부분 끝 -->
			 </div>	 
</body>	
			 
<script type="text/javaScript">

$(document).ready(function() {
	
	fn_selectCSList(1);
	
	$("a[name='title']").on("click", function(e) { //목록에서 글 제목을 클릭하면
		e.preventDefault();
		var num = $(this).attr('data-num'); //string으로 가져옴. attr말고 data('num')으로 쓰면 실제 자료형으로 가져옴
	
	detail(num); //상세보기 함수 호출
	});
	
	$("button[name='delete']").on("click", function(e) { //모달에서 삭제 버튼을 누르면
		 e.preventDefault();
		var num = $("a[name='title']").attr('data-num');
		
		deleteCS(num); //삭제 함수 호출
	});
	
});


function detail(num) {
	$.ajax({
		url:"/sk/myPage/csDetail",
		type:'post',
		contentType:"application/json; charset=UTF-8",
		data:JSON.stringify({CS_NUM:num}),
		success:function(data) {
			$("#d_title").html(data.result.CS_TITLE);
			$("#d_content").html(data.result.CS_CONTENT);
			$("#d_reply").empty();
			$("#d_reply").html(data.result.CS_REPLY_CONTENT);
			
		},
		error:function() {
			alert("잠시 후 다시 시도해주세요.");
		}	
		});
}


function deleteCS(num) {
	if(confirm("문의 글을 삭제하시겠습니까?")) {
		$.ajax({
		url:"/sk/myPage/csDelete",
		type:'post',
		contentType:"application/json; charset=UTF-8",
		data:JSON.stringify({CS_NUM:num}),
		success:function() {
			alert("문의가 삭제되었습니다.");
			location.reload(); //페이지 새로고침
		},
		error:function() {
			alert("잠시 후 다시 시도해주세요.");
		}	
		});
	}
	
}

	function fn_selectCSList(pageNo) {//페이징 함수
		 var comAjax = new ComAjax();
		 comAjax.setUrl("/sk/myPage/csList/paging");
		 comAjax.setCallback("fn_selectCSListCallback");
		 comAjax.addParam("PAGE_INDEX", pageNo);
		 comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시물의 개수
		 comAjax.addParam("MEM_NUM", $('h3').attr("data-num"));
		 
		 comAjax.ajax();
	}

	function fn_selectCSListCallback(data) {
		var total = data.TOTAL; //게시물의 개수 
		var body = $("#csListTbody");
		
		body.empty();
		
		if(total == 0 ) {
			var str = "<div class='col style='margin:auto;'>" +
			"<h6 class='text-center' style='margin-left: 30px; color: black; font-weight: bolder;'" +
				">등록된 글이 없습니다.</h6>" +
			"</div>";
			
			body.append(str);
		} else {
			var params = {
					divId : "PAGE_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					recordCount : 10,
					eventName : "fn_selectCSList"
			};
			gfn_renderPaging(params);
			
			var str = "";
			
			$.each(data.CSList, function(key, value) {
				str +=		 "<tr id='csListTr'>";
				str +=       	"<td style='width: 40%;'><a href='#' data-bs-toggle='modal' data-bs-target='#csDetail' name='title' data-num='"+ value.CS_NUM + "'>"+ value.CS_TITLE +"</a></td>";
				str +=        	"<td style='width: 30%;'>"+ value.CS_DATE + "</td>";
				str +=        	"<td style='width: 30%;'>"+ value.CS_STATUS+"</td>";
				str +=      "</tr>";
			});
			body.append(str);
		}
	}
	
</script>
</body>
</html>