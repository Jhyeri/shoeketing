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
<div class="container">
<div class="col-12 text-center" style="margin-top: 0px; margin-left: 0%">
    <div>
    	<img class="mb-2 mt-2 rounded" style="width: 100px; height: 100px; margin-right: 0%; " src="/sk/image/display?fileName=${brandPageInfoMap.BRAND_LOGO_FILE}">
    </div>
    <h1 class="display-5 fw-bold mt-2">${brandPageInfoMap.BRAND_NAME}</h1>
     	<div class="col-lg-6 mx-auto">
       		<p class="lead mb-4" style="text-align: left;">${brandPageInfoMap.BRAND_INFO}</p>
     	</div>
    <hr style="width: 70%; margin-left: 15%; margin-top: 5%;">
    </div>

      <h1 class="display-5 fw-bold mt-5" style="text-align: center;">NEW PRODUCT</h1>
       	<div class="row mt-5 justify-content-center">
        <c:choose>
			<c:when test="${fn:length(recentGoodsList) > 0 }">
				<c:forEach items="${recentGoodsList}" var="recentGoods" varStatus="status">
			        
			         <div class='card' style='width: 14rem; margin-left: 10px; margin-right: 10px; border-style: none;'>
					   <a href='/sk/goods/goodsDetail?TOTAL_GOODS_NUM=${recentGoods.TOTAL_GOODS_NUM}' name='title' data-num='${recentGoods.TOTAL_GOODS_NUM }'>
					     <img src='/sk/image/display?fileName=${recentGoodsThumbnailList[status.index].GOODS_IMAGE_STD}' style='width:13rem; height: 11rem' class='card-img-top' alt='<%=request.getContextPath() %>.'>
					     <div class='card-body' style='height:6rem;'>
					       <h6 class='card-title' style='font-size: 15px; font-weight: 700;'>${brandPageInfoMap.BRAND_NAME}</h6>
					       <p class='card-text' style='font-size: 13px;'>${recentGoods.TOTAL_GOODS_NAME}</p>
					       <p class='card-text' style='font-size: 13px;'>${recentGoods.TOTAL_GOODS_MODEL }</p>
					     </div>
					     <div class='card-body'>
					       <h6 class='card-title mb-0' style='font-size: 18px; font-weight: 700;'><fmt:formatNumber value='${recentGoods.TOTAL_GOODS_PRICE}' type='number'/>원</h6>
					     </div>
					   </a>
					 </div>
			         
		       	</c:forEach>
	       	</c:when>
       	</c:choose>
       	</div>

          <hr style="width: 70%; margin-left: 15%; margin-top: 5%;">
          <h1 class="display-5 fw-bold mt-5" style="text-align: center;">RANKING</h1>
          <div class="row mt-5 justify-content-center">
	     	<c:choose>
				<c:when test="${fn:length(rankingGoodsList) > 0 }">
					<c:forEach items="${rankingGoodsList}" var="rankingGoods" varStatus="status">
				        
				         <div class='card' style='width: 14rem; margin-left: 10px; margin-right: 10px; border-style: none;'>
						   <a href='/sk/goods/goodsDetail?TOTAL_GOODS_NUM=${rankingGoods.TOTAL_GOODS_NUM}' name='title' data-num='${rankingGoods.TOTAL_GOODS_NUM }'>
						     <img src='/sk/image/display?fileName=${rankingGoodsThumbnailList[status.index].GOODS_IMAGE_STD}' style='width:13rem; height: 11rem' class='card-img-top' alt='<%=request.getContextPath() %>.'>
						     <div class='card-body' style='height:6rem;'>
						       <h6 class='card-title' style='font-size: 15px; font-weight: 700;'>${brandPageInfoMap.BRAND_NAME}</h6>
						       <p class='card-text' style='font-size: 13px;'>${rankingGoods.TOTAL_GOODS_NAME}</p>
						       <p class='card-text' style='font-size: 13px;'>${rankingGoods.TOTAL_GOODS_MODEL }</p>
						     </div>
						     <div class='card-body'>
						       <h6 class='card-title mb-0' style='font-size: 18px; font-weight: 700;'><fmt:formatNumber value='${rankingGoods.TOTAL_GOODS_PRICE}' type='number'/>원</h6>
						     </div>
						   </a>
						 </div>
			        </c:forEach>
		        </c:when>
	        </c:choose>
          </div>
     <br>
     <br>
</div>
</body>
</html>