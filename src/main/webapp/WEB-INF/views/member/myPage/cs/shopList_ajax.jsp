<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %> 
<c:forEach var="list" items="${shopList}" varStatus="status">
	 <tr class='mb-0' style='height: 70px;' id='firstRow_${status.index}'>
		<td style='width: 20%;'>
			<p style='font-weight: bolder; font-size: medium; margin-bottom: 0;' id="shop_name">${list.SHOP_NAME}</p>
		</td>
		<td id="shop_add_${status.index}">${list.SHOP_ADD}</td>
			<td style='width: 25%;'>
				<a href="#" style='text-decoration: underline;' id='m_select' data-bs-dismiss="modal" onClick="selectShop('${list.SHOP_NAME}','${list.SHOP_NUM}')">선택</a>
			</td>
	</tr> 
</c:forEach>	

