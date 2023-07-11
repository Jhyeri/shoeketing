<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/include-taglib.jspf" %>


     <!-- 답변 작성 모달 -->
		<div class="modal fade" id="csWrite" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
		                <p style="font-weight: bolder; font-size: medium; margin-bottom: 0;">상품 1의 재고 문의</p>
		            </tr>
		  
		            <tr style="height: 70px;">
		                <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
		            </tr>
		            <tr style="height: 70px;">
		                <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">답변 내용</label>
		                <textarea class="form-control" id="CS_REPLY_CONTENT" rows="10"></textarea></tr>  
		          </table>
		            </div>
		            <br>
		            <div class="modal-footer">
		              <button type="button" class="btn btn-primary" name="shopCSReplyWrite" id="shopCSReplyWrite" data-csNum="${csDetailMap.CS_NUM}" data-csWriter="${csDetailMap.MEM_NUM}">답변 작성</button>
		            </div>
		        </div>
			</div>
	      </div>
	    </div>
	    
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
		            	<div class="row mb-3">
		            		<div class="col">
		                		<p style="font-weight: bolder; font-size: large; margin-bottom: 0;">${csDetailMap.CS_TITLE}</p>
		                	</div>
		                </div>
		                <div class="row">
		                	<div class="col-6"></div>
		                	<div class="col-6 text-end">
		                		<p style="font-size: medium; margin-bottom: 0;">${csReplyStatus}</p>
		                	</div>
		                </div>
		            </tr>
		  
		            <tr style="height: 70px;">
		                <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
		            </tr>
		            <tr style="height: 70px;">
		                <p style="font-size: medium; margin-bottom: 0;">${csDetailMap.CS_CONTENT}</p>
		            </tr>  
		          </table>
		          	<div class="row">
		          	  <div class="col-8"><p class="text-start mb-2" style="">작성자 : ${csDetailMap.MEM_EMAIL}</p></div>
		              <div class="col-4"><p class="text-start mb-2">작성날짜 : ${csDetailMap.CS_DATE}</p></div>
		             </div>
		            </div>
		            <div class="modal-footer">
		              <c:if test="${csReplyMap == null}">
		              	<button class="btn btn-primary" data-bs-target="#csWrite" data-bs-toggle="modal">답변 작성하기</button>
		              </c:if>
		            </div>
		            <c:if test="${csReplyMap != null}">
			            <div class="mt-4 ms-3 row-cols-md-1">
				            <div class="row mb-3">
				           		<hr>
				            	<div class="col mb-3">
				           	 		<p style="font-weight: bolder; font-size: large; margin-bottom: 0;">문의 답변</p>
				           	 	</div>
				           	 	<div class="row">
				           	 		<div class="col mb-3">
				           	 			<pre style="font-size : medium">${csReplyMap.CS_REPLY_CONTENT}</pre>
				           	 		</div>
				           	 	</div>
				           	 	<hr>
				            </div>
				        </div>
			       </c:if>
		      	  </div>
		        </div>
		      </div>
		    </div>
    <!-- 모달 끝 -->