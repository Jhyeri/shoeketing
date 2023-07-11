<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>
<c:forEach items="${informList }" var="inform">
  <c:choose>
   <c:when test="${inform.INFORM_TYPE == 1 }">
	<a href="/sk/myPage/reservationList" name="informA" data-num="${inform.INFORM_NUM }">
   </c:when>
   <c:when test="${inform.INFORM_TYPE == 2 }">
	<a href="/sk/myPage/reservationList" name="informA" data-num="${inform.INFORM_NUM }">
   </c:when>
   <c:when test="${inform.INFORM_TYPE == 3 }">
	<a href="/sk/myPage/csList" name="informA" data-num="${inform.INFORM_NUM }">
   </c:when>
  </c:choose>
	  <div class="row ms-1 me-1">
	    <p style="font-weight: 500">
	      ${inform.INFORM_CONTENT }
	    </p>
	    <div class="d-flex justify-content-between">
	      <p style="color: rgba(0, 0, 0, 0.361); font-size: small">
	        ${inform.INFORM_DATE }
	      </p>
	      <p style="font-size: small">
	      	<c:choose>
	      		<c:when test="${inform.INFORM_CONFIRM == 'N' }">
	        		<span style="color: rgba(0, 0, 0, 0.361);">읽지않음</span> 🔵
	        	</c:when>
	        	<c:when test="${inform.INFORM_CONFIRM == 'Y' }">
	        		<span style="color: rgba(0, 0, 0, 0.361);">읽음</span>
	        	</c:when>
	        </c:choose>
	      </p>
	    </div>
	    <hr />
	  </div>
	</a>
</c:forEach>