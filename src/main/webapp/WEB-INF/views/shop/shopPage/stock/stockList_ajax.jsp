<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>

			<c:choose>
				<c:when test="${fn:length(shopStockList) > 0 }">
					<c:forEach items="${shopStockList}" var="shopStock">
			          <tr>
			            <th scope="rowspan-3" style="width: 23%; text-align:center;">
			                <a href="#">
			                  <img src="/sk/image/display?fileName=${shopStock.GOODS_IMAGE_STD}" height="200" width="250"/>
			                </a>
			            </th>
			            <td style=" text-align: left; width: 35%; padding-left: 5rem; vertical-align: middle;">
			              <p style="font-weight: bolder; font-size: large">${shopStock.SHOP_BRAND}</p>
			              <p style="font-weight: bolder">
			                ${shopStock.TOTAL_GOODS_NAME} / ${shopStock.TOTAL_GOODS_MODEL}
			              </p>
			              <p style="font-size: small" id="goodsSize">사이즈 : ${shopStock.SHOP_GOODS_SIZE}mm</p>
			            </td>
			            <td style=" text-align: center; width: 20%; margin-bottom: 1; vertical-align: middle;">
			              <p class="mb-0" style="font-weight: bolder; font-size: large">${shopStock.TOTAL_GOODS_PRICE}</p>
			            </td>
			            <td style=" font-weight: bolder; text-align: right; vertical-align: middle; width: 10%;">
			                <input
			                  class="form-control form-control-sm text-center"
			                  type="text"
			                  style="width: 4rem;
			                  display:inline-block;"
			                  value="${shopStock.SHOP_GOODS_AMOUNT}"
			                  placeholder="재고"
			                />
			             </td>
			             <td style="text-align: center; vertical-align: middle; width: 10%;">
			                <button class="btn btn-primary btn-md" id="goodsAmountModify" name="goodsAmountModify" data-goodsNum="${shopStock.SHOP_GOODS_GOODS_NUM}" data-goodsSize="${shopStock.SHOP_GOODS_SIZE}" data-shopNum="${SHOP_NUM}" type="button">저장</button>
			            </td>
			          </tr>
			        </c:forEach>
		        </c:when>
	        </c:choose>