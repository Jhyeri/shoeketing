<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>

<!-- 공지사항 리스트 반복문으로 출력 (글 번호, 제목, 작성날짜) -->
        <c:choose>
        	<c:when test="${fn:length(noticeList) > 0}">
        		<c:forEach items="${noticeList}" var="notice" varStatus="status" begin="0" end="10">
		          <tr>
				  <th scope="row">${notice.NOTICE_NUM}</th> 
		          	<td style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap; max-width:200px;" title="${notice.NOTICE_TITLE}"><a href="#" name="title" class="text-dark" data-num="${notice.NOTICE_NUM}">${notice.NOTICE_TITLE}</a></td> <!-- NOTICE_TITLE -->
		            <td>${notice.NOTICE_DATE}</td> <!-- NOTCIE_DATE -->
		          </tr>  
		    	</c:forEach>
			</c:when>
         </c:choose>  
