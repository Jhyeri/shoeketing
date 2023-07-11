<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>

    <div class="col-10" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">매장 문의</h3>
            <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
            <table class="table table table-bordered" style="text-align: center;">
                <thead>
                  <tr style="width: 25%;">
                    <th>작성자</th>
                    <th>제목</th>
                    <th>작성 날짜</th>
                    <th>처리 상태</th>
                  </tr>
                </thead>
                <tbody id="shopCSListTbody">
             	   <c:choose>
						<c:when test="${fn:length(shopCSList) > 0 }">
							<c:forEach items="${shopCSList}" var="shopCS" varStatus="status">
			                  <tr>
			                    <td style="width: 25%;">${shopCS.MEM_EMAIL}</td>
			                    <td style="width: 45%;"><a href="#" name="shopCSDetail" id="shopCSDetail" data-csNum="${shopCS.CS_NUM}" data-csWriter="${shopCS.CS_WRITER}">${shopCS.CS_TITLE}</a></td>
			                    <td style="width: 15%;">${shopCS.CS_DATE}</td>
			                    <td style="width: 25%;" id="csReplyStatus_${shopCS.CS_NUM}">${csReplyStatusList[status.index].csReplyStatus}</td>
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
			
      </div>
      
      <!-- CS_TITLE 클릭 시 ajax 동작할 부분 -->
      <div id="csDetailBody">
     
      </div>
    
<script>
$(document).ready(function(){
	
	// 페이지 로딩 시 자동으로 1페이지 가져오기
	fn_selectShopCSList(1);
	
	$("#shopCSListTbody").on("click", "a[name='shopCSDetail']", function(e){  // 매장 문의 상세보기
		e.preventDefault();
		const csNum = $(this).attr("data-csNum");
		const csWriter = $(this).attr("data-csWriter");
		
		fn_shopCSDetail(csNum, csWriter);
	});
	
/* 	$("a[name='shopCSDetail']").on("click", function(e){   // 매장 문의 상세보기
		e.preventDefault();
		const csNum = $(this).attr("data-csNum");
		const csWriter = $(this).attr("data-csWriter");
		
		fn_shopCSDetail(csNum, csWriter);
	}); */
	
	function fn_shopCSDetail(csNum, csWriter){
		var formData = new FormData();
		
		formData.append("CS_NUM", csNum);
		formData.append("MEM_NUM", csWriter);
		
		$.ajax({
			type : 'post',
			url : '/sk/shopPage/csDetail_ajax',
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				$("#csDetailBody").empty();
				$('#csDetailBody')[0].innerHTML = data;
				$("#csDetail").modal('show');
			},
			error : function(xhr, status, error){
				console.log('실패');
			}
		});
	};
	
	 /* $("button[name='shopCSReplyWrite']").on("click", function(e){ */
	$("#csDetailBody").on("click", "#shopCSReplyWrite", function(e){  // 매장 문의 답변 작성하기
		e.preventDefault();
	
		const csReplyNum = $(this).attr("data-csNum");
		const csWriter = $(this).attr("data-csWriter");
		
		fn_shopCSReplyWrite(csReplyNum, csWriter);
		
	});
	
	function fn_shopCSReplyWrite(csReplyNum, csWriter){
		var formData2 = new FormData();
		
		var csReplyContent = $("#CS_REPLY_CONTENT").val();
		
		formData2.append("CS_REPLY_NUM", csReplyNum);
		formData2.append("CS_REPLY_CONTENT", csReplyContent);
		formData2.append("MEM_NUM", csWriter);
		
		$.ajax({
			type : 'post',
			url : '/sk/shopPage/csReplyWrite',
			data : formData2,
			processData : false,
			contentType : false,
			success : function(data){
				if(data.result == "pass"){
					alert("답변 작성이 완료되었습니다.");
					
					$("#csWrite").modal('hide');  // 답변 작성 후 모달창 숨기기
					$("#csReplyStatus_"+csReplyNum).empty();
					$("#csReplyStatus_"+csReplyNum).append("답변 완료");
					
					socket.send("<%=session.getAttribute("session_SHOP_NAME")%>,"+csWriter+",문의하신 글에 답변이 달렸습니다.,/sk/myPage/csList");	
					
				}else if(data.result == "fail"){
					alert("답변 작성이 실패했습니다.");
				}
			},
			error : function(xhr, status, error){
				console.log('실패');
			}
		});
	}; 
});

//페이징 함수
function fn_selectShopCSList(pageNo){
	var comAjax = new ComAjax();
	comAjax.setUrl("/sk/shopPage/csList/paging");
	comAjax.setCallback("fn_selectShopCSListCallback");
	comAjax.addParam("PAGE_INDEX",pageNo);
	comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시글 수 정하기
	comAjax.ajax();
}

// 페이징 콜백 함수
function fn_selectShopCSListCallback(data){ // 페이지 선택 시 화면에 보여줄 결과 콜백함수
	var total = data.TOTAL;
	var body = $("#shopCSListTbody"); // 페이징 한 결과가 반영될 태그
	
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
			recordCount : 10,
			eventName : "fn_selectShopCSList" // 페이징 함수이름 동일하게
		};
		gfn_renderPaging(params);
		
		var str = "";
		$.each(data.shopCSList, function(key, value){ // 가져온 게시글 수 만큼 반복 실행
			str += "<tr><td style='width: 25%;'>" + value.MEM_EMAIL + "</td>" +
				   "<td style='width: 45%;'><a href='#' name='shopCSDetail' id='shopCSDetail' " + 
				   "data-csNum='" + value.CS_NUM + "' data-csWriter='" + value.CS_WRITER +
				   "'>" + value.CS_TITLE + "</a></td><td style='width: 15%;'>" + 
				   value.CS_DATE + "</td><td style='width: 25%;' id='csReplyStatus_" + value.CS_NUM + "'>" +
				   data.csReplyStatusList[key].csReplyStatus + "</td></tr>"
		});
		body.append(str);

	}
}
	
	

</script>    
    