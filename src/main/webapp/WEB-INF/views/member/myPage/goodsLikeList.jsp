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
        <div class="col-8" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;" data-num="${sessionScope.session_MEM_INFO.MEM_NUM}">찜 목록</h3>
            <div class="d-grid gap-2 d-flex justify-content-start mt-4">
                <h6 style="margin-left: 30px; color: black; font-weight: bolder;">전체</h6>        
                <h6 style="color: black; font-weight: bolder;">총</h6>
                <h6 style="color: rgb(255, 183, 0); font-weight: bolder;">${goodsLikeCount}</h6>
                <h6 style="color: black; font-weight: bolder;">개</h6>
            </div>
            
            <br>

                		<div class="row row-cols-5 g-5" style="margin-left: 6px;" id="goodsLikeListDiv">
                			<c:forEach var="list" items="${goodsLikeList}">
	                    		<div class="col">
			                 		 <div class="card shadow-sm">
			                 		 	<a href="#" id="goodsImg"><img src="/sk/image/display?fileName=${list.GOODS_IMAGE_STD}" height="150" width="150" id="like" data-num="${list.TOTAL_GOODS_NUM}" /></a>
					                    <div class="card-body">
					                      <p class="card-text mb-1">${list.BRAND_NAME}</p>
					                      <p class="card-text mb-1" style="font-size: x-small; color: rgb(94, 95, 95);" ><a href="#" id="goodsName">${list.TOTAL_GOODS_NAME}</a></p>
					                      <p class="card-text mb-1" style="font-size: x-small; color: rgb(94, 95, 95); overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${list.TOTAL_GOODS_MODEL}</p>
					                      <p class="card-text" style="font-size: medium; color: rgb(0, 0, 0); font-weight: bolder;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.TOTAL_GOODS_PRICE}"/>원</p>
					                    </div>
					                  </div>
					             </div>
							</c:forEach>
						</div>
         </div>    
             <!-- 페이징 화면 처리 부분 시작 -->
	      	<div id="PAGE_NAVI"></div>
			<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
			<!-- 페이징 화면 처리 부분 끝 -->
			
			
</body>
<script type="text/javascript">

$(document).ready(function() {
		const goodsNum = $('img').attr("data-num");
		
		fn_selectGoodsLikeList(1);
		
		$("a[id='goodsImg']").on("click", function(e) { //상품 이미지를 클릭하면
			 e.preventDefault();
			 fn_unlike(goodsNum);
		});
		
		$("a[id='goodsName']").on("click", function(e) { //상품명을 클릭하면
			 e.preventDefault();
			location.href="/sk/goods/goodsDetail?TOTAL_GOODS_NUM="+goodsNum;
		});

		function fn_unlike(goodsNum) { //찜 취소 처리
			
			if(confirm("해당 상품을 찜 목록에서 삭제하시겠습니까?")) {
				$.ajax({
					url:"/sk/myPage/goodsUnlike",
					method:'get',
					contentType:"application/json; charset=utf-8",
					data:{TOTAL_GOODS_NUM : goodsNum},
					success:function() {
						alert("상품이 삭제되었습니다.");
						location.reload();
					},
					error:function() {
						alert("잠시 후 다시 시도해주세요.");
					}	
				});
			} else { return false; }
		}
});



function fn_selectGoodsLikeList(pageNo) { //페이징 함수
	 var comAjax = new ComAjax();
	comAjax.setUrl("/sk/myPage/goodsLikeList/paging");
	comAjax.setCallback("fn_selectGoodsLikeListCallback");
	comAjax.addParam("PAGE_INDEX", pageNo);
	comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시물의 개수
	comAjax.addParam("MEM_NUM", $('h3').attr("data-num"));
	
	comAjax.ajax();
}

//페이징 콜백함수
function fn_selectGoodsLikeListCallback(data) { //컨트롤러 요청으로 가져온 값이 data
	var total = data.TOTAL;
	var body = $("#goodsLikeListDiv");

	body.empty(); //현재 페이지의 게시물을 지우고 알맞은 페이지의 내용을 채워넣기 위해

	if(total == 0) {
		var str = "<div class='col' style='margin:auto;'>" +
		 "<h6 class='text-center' style='margin-left: 30px; color: black; font-weight: bolder;'> 찜한 상품이 존재하지 않습니다.</h6>" +
		"</div>";
		
		body.append(str);
	} else {
		var params = {
			divId : "PAGE_NAVI",
			pageIndex : "PAGE_INDEX",
			totalCount : total,
			recordCount : 10,
			eventName : "fn_selectGoodsLikeList"
		};
		gfn_renderPaging(params);
		
		var str = "";
		
		$.each(data.goodsLikeList, function(key, value) {
			str += 	"<div class='col'>";
			str += 		"<div class='card shadow-sm'>"
			str += 			"<a href='#' id='goodsImg'>"
			str += 				"<img src='/sk/image/display?fileName="+ value.GOODS_IMAGE_STD +"' height='150px' width='150px' id='like' data-num='"+value.TOTAL_GOODS_NUM+"'/>";
			str += 			"</a>";
			str += 				"<div class='card-body'>";
			str += 						"<p class='card-text mb-1'>"+value.BRAND_NAME+"</p>";
			str += 						"<p class='card-text mb-1' style='font-size: x-small; color: rgb(94, 95, 95); overflow: hidden; text-overflow: ellipsis; white-space: nowrap; '><a href='#' id='goodsName'>"+ value.TOTAL_GOODS_NAME+"</a></p>";
			str += 						"<p class='card-text mb-1' style='font-size: x-small; color: rgb(94, 95, 95);'>"+value.TOTAL_GOODS_MODEL+"+</p>";
			str += 						"<p class='card-text' style='font-size: medium; color: rgb(0, 0, 0); font-weight: bolder;'>"+ value.TOTAL_GOODS_PRICE+"원</p>";
			str += 				"</div>";
			str += 		"</div>";
			str += "</div>";
			
		});
		
		body.append(str);
	}

}

</script>  
</html>
