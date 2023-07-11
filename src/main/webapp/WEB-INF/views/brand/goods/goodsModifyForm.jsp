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
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">상품 수정</h3>
            <div class="row g-2">
                <div class="mb-3 mt-4" style="width: 70%; margin-left: 30px;">
                    <label for="TOTAL_GOODS_NAME" class="form-label" style="font-size: large; font-weight: bolder;">상품명</label>
                    <input class="form-control" type="text" name="TOTAL_GOODS_NAME" id="TOTAL_GOODS_NAME" aria-label="Disabled input example" value="${goodsDetailMap.TOTAL_GOODS_NAME}">
                  </div>
                  <hr class="my-4">
                  <div class="mb-3" style="width: 70%; margin-left: 30px;">
                    <label for="TOTAL_GOODS_MODEL" class="form-label" style="font-size: large; font-weight: bolder;">모델 번호</label>
                    <input type="email" name="TOTAL_GOODS_MODEL" id="TOTAL_GOODS_MODEL" class="form-control" value="${goodsDetailMap.TOTAL_GOODS_MODEL}">
                  </div>
                  <hr class="my-4">
                  <div class="mb-3" style="width: 70%; margin-left: 30px;">
                    <label for="TOTAL_GOODS_CATEGORY" class="form-label" style="font-size: large; font-weight: bolder;">카테고리</label>
                    <select class="form-select form-select-sm" aria-label=".form-select-sm example" id="category">
                        <option selected>${goodsDetailMap.TOTAL_GOODS_CATEGORY}</option>
                        <c:if test="${goodsDetailMap.TOTAL_GOODS_CATEGORY eq '스니커즈'}">
	                        <option value="캔버스화">캔버스화</option>
	                        <option value="러닝화">러닝화</option>
						</c:if>
						<c:if test="${goodsDetailMap.TOTAL_GOODS_CATEGORY eq '캔버스화'}">
	                        <option value="스니커즈">스니커즈</option>
	                        <option value="러닝화">러닝화</option>
						</c:if>
						<c:if test="${goodsDetailMap.TOTAL_GOODS_CATEGORY eq '러닝화'}">
	                        <option value="스니커즈">스니커즈</option>
	                        <option value="캔버스화">캔버스화</option>
						</c:if> 
                      </select>
                  </div>
                  <hr class="my-4">
                  <div class="mb-3" style="width: 60%; margin-left: 30px;">
                
                    <label for="TOTAL_GOODS_PRICE" class="form-label" style="font-size: large; font-weight: bolder;">가격</label>
                <table>
                    <tr>
                        <td style="width: 70%; ">
                    <input class="form-control" id="TOTAL_GOODS_PRICE" name="TOTAL_GOODS_PRICE" type="text" aria-label="Disabled input example" value="${goodsDetailMap.TOTAL_GOODS_PRICE}">
                </td>
                    <td>
                    <p style="margin-bottom: -15px; font-size: larger; margin-left: 5px;">원</p>
                    </td>
                    </tr>
                </table>
                  </div>
 				<hr class="my-4">
                  <div class="mb-3" style="width: 70%; margin-left: 30px;">
					<div class="d-flex mb-2">
                       <label for="GOODS_DETAIL_SIZE" class="form-label align-self-center mb-0" style="font-size: large; font-weight: bolder;">사이즈</label>
                       <p id="stockCheckP" class="ms-5 align-self-center mb-0" style="color: rgba(0, 0, 0, 0.490);">사이즈에 마우스를 올리면 재고가 있는 매장 수 및 총 재고 개수가 표시됩니다.</p>
                   </div>                    
                   <table>
                        <tr>
                            <td class="sizeTd">
                    <div class="form-check col-3 ps-0 pe-1 align-self-center">
                        
                        <input
                          type="checkbox"
                          class="btn-check"
                          name="sizeType"
                          id="size_200"
                          autocomplete="off"
                          value="200"
                        />
                        <label
                          class="btn btn-outline-secondary"
                          for="size_200"
                          style="width: 45px; height: 25px"
                          ><p style="position: relative; bottom: 7px; right: 5px">
                            200
                          </p></label
                        >
                      </div>
                      </td>
                      <td class="sizeTd">
                      <div class="form-check col-3 ps-0 pe-1 align-self-center">
                        <input
                          type="checkbox"
                          class="btn-check"
                          name="sizeType"
                          id="size_205"
                          autocomplete="off"
                          value="205"
                        />
                        <label
                          class="btn btn-outline-secondary"
                          for="size_205"
                          style="width: 45px; height: 25px"
                          ><p style="position: relative; bottom: 7px; right: 5px">
                            205
                          </p>
                        </label>
                   
                      </div>
                      </td>

                      <td class="sizeTd">
                        <div class="form-check col-3 ps-0 pe-1 align-self-center">
                          <input
                            type="checkbox"
                            class="btn-check"
                            name="sizeType"
                            id="size_210"
                            autocomplete="off"
                            value="210"
                          />
                          <label
                            class="btn btn-outline-secondary"
                            for="size_210"
                            style="width: 45px; height: 25px"
                            ><p style="position: relative; bottom: 7px; right: 5px">
                              210
                            </p>
                          </label>
                     
                        </div>
                        </td>

                        <td class="sizeTd">
                          <div class="form-check col-3 ps-0 pe-1 align-self-center">
                            <input
                              type="checkbox"
                              class="btn-check"
                              name="sizeType"
                              id="size_215"
                              autocomplete="off"
                              value="215"
                            />
                            <label
                              class="btn btn-outline-secondary"
                              for="size_215"
                              style="width: 45px; height: 25px"
                              ><p style="position: relative; bottom: 7px; right: 5px">
                                215
                              </p>
                            </label>
                       
                          </div>
                          </td>

                          <td class="sizeTd">
                            <div class="form-check col-3 ps-0 pe-1 align-self-center">
                              <input
                                type="checkbox"
                                class="btn-check"
                                name="sizeType"
                                id="size_220"
                                autocomplete="off"
                                value="220"
                              />
                              <label
                                class="btn btn-outline-secondary"
                                for="size_220"
                                style="width: 45px; height: 25px"
                                ><p style="position: relative; bottom: 7px; right: 5px">
                                  220
                                </p>
                              </label>
                         
                            </div>
                          </td>

                            <td class="sizeTd">
                             <div class="form-check col-3 ps-0 pe-1 align-self-center">
                               <input
                                 type="checkbox"
                                 class="btn-check"
                                 name="sizeType"
                                 id="size_225"
                                 autocomplete="off"
                                 value="225"
                               />
                               <label
                                 class="btn btn-outline-secondary"
                                 for="size_225"
                                 style="width: 45px; height: 25px"
                                 ><p style="position: relative; bottom: 7px; right: 5px">
                                   225
                                 </p>
                               </label>
                          
                             </div>
                           </td>

                           <td class="sizeTd">
                             <div class="form-check col-3 ps-0 pe-1 align-self-center">
                               <input
                                 type="checkbox"
                                 class="btn-check"
                                 name="sizeType"
                                 id="size_230"
                                 autocomplete="off"
                                 value="230"
                               />
                               <label
                                 class="btn btn-outline-secondary"
                                 for="size_230"
                                 style="width: 45px; height: 25px"
                                 ><p style="position: relative; bottom: 7px; right: 5px">
                                   230
                                 </p>
                               </label>
                          
                             </div>
                            </td>

                            <td class="sizeTd">
                              <div class="form-check col-3 ps-0 pe-1 align-self-center">
                               <input
                                 type="checkbox"
                                 class="btn-check"
                                 name="sizeType"
                                 id="size_235"
                                 autocomplete="off"
                                 value="235"
                               />
                               <label
                                 class="btn btn-outline-secondary"
                                 for="size_235"
                                 style="width: 45px; height: 25px"
                                 ><p style="position: relative; bottom: 7px; right: 5px">
                                   235
                                 </p>
                               </label>
                          
                              </div>
                            </td>

                             <td class="sizeTd">
                              <div class="form-check col-3 ps-0 pe-1 align-self-center">
                                <input
                                  type="checkbox"
                                  class="btn-check"
                                  name="sizeType"
                                  id="size_240"
                                  autocomplete="off"
                                  value="240"
                                />
                                <label
                                  class="btn btn-outline-secondary"
                                  for="size_240"
                                  style="width: 45px; height: 25px"
                                  ><p style="position: relative; bottom: 7px; right: 5px">
                                    240
                                  </p>
                                </label>
                           
                              </div>
                              </td>

                              <td class="sizeTd">
                               <div class="form-check col-3 ps-0 pe-1 align-self-center">
                                 <input
                                   type="checkbox"
                                   class="btn-check"
                                   name="sizeType"
                                   id="size_245"
                                   autocomplete="off"
                                   value="245"
                                 />
                                 <label
                                   class="btn btn-outline-secondary"
                                   for="size_245"
                                   style="width: 45px; height: 25px"
                                   ><p style="position: relative; bottom: 7px; right: 5px">
                                     245
                                   </p>
                                 </label>
                            
                               </div>
                              </td>
                    </tr>

                    <tr>
                        <td class="sizeTd">
                    <div class="form-check col-3 ps-0 pe-1 align-self-center">
                    
                    <input
                      type="checkbox"
                      class="btn-check"
                      name="sizeType"
                      id="size_250"
                      autocomplete="off"
                      value="250"
                    />
                    <label
                      class="btn btn-outline-secondary"
                      for="size_250"
                      style="width: 45px; height: 25px"
                      ><p style="position: relative; bottom: 7px; right: 5px">
                        250
                      </p></label
                    >
                  </div>
                  </td>
                  <td class="sizeTd">
                  <div class="form-check col-3 ps-0 pe-1 align-self-center">
                    <input
                      type="checkbox"
                      class="btn-check"
                      name="sizeType"
                      id="size_255"
                      autocomplete="off"
                      value="255"
                    />
                    <label
                      class="btn btn-outline-secondary"
                      for="size_255"
                      style="width: 45px; height: 25px"
                      ><p style="position: relative; bottom: 7px; right: 5px">
                        255
                      </p>
                    </label>
               
                  </div>
                  </td>

                  <td class="sizeTd">
                    <div class="form-check col-3 ps-0 pe-1 align-self-center">
                      <input
                        type="checkbox"
                        class="btn-check"
                        name="sizeType"
                        id="size_260"
                        autocomplete="off"
                        value="260"
                      />
                      <label
                        class="btn btn-outline-secondary"
                        for="size_260"
                        style="width: 45px; height: 25px"
                        ><p style="position: relative; bottom: 7px; right: 5px">
                          260
                        </p>
                      </label>
                 
                    </div>
                    </td>

                    <td class="sizeTd">
                        <div class="form-check col-3 ps-0 pe-1 align-self-center">
                          <input
                            type="checkbox"
                            class="btn-check"
                            name="sizeType"
                            id="size_265"
                            autocomplete="off"
                            value="265"
                          />
                          <label
                            class="btn btn-outline-secondary"
                            for="size_265"
                            style="width: 45px; height: 25px"
                            ><p style="position: relative; bottom: 7px; right: 5px">
                              265
                            </p>
                          </label>
                     
                        </div>
                        </td>

                        <td class="sizeTd">
                            <div class="form-check col-3 ps-0 pe-1 align-self-center">
                              <input
                                type="checkbox"
                                class="btn-check"
                                name="sizeType"
                                id="size_270"
                                autocomplete="off"
                                value="270"
                              />
                              <label
                                class="btn btn-outline-secondary"
                                for="size_270"
                                style="width: 45px; height: 25px"
                                ><p style="position: relative; bottom: 7px; right: 5px">
                                  270
                                </p>
                              </label>
                         
                            </div>
                            </td>

                            <td class="sizeTd">
                                <div class="form-check col-3 ps-0 pe-1 align-self-center">
                                  <input
                                    type="checkbox"
                                    class="btn-check"
                                    name="sizeType"
                                    id="size_275"
                                    autocomplete="off"
                                    value="275"
                                  />
                                  <label
                                    class="btn btn-outline-secondary"
                                    for="size_275"
                                    style="width: 45px; height: 25px"
                                    ><p style="position: relative; bottom: 7px; right: 5px">
                                      275
                                    </p>
                                  </label>
                             
                                </div>
                                </td>

                                <td class="sizeTd">
                                    <div class="form-check col-3 ps-0 pe-1 align-self-center">
                                      <input
                                        type="checkbox"
                                        class="btn-check"
                                        name="sizeType"
                                        id="size_280"
                                        autocomplete="off"
                                        value="280"
                                      />
                                      <label
                                        class="btn btn-outline-secondary"
                                        for="size_280"
                                        style="width: 45px; height: 25px"
                                        ><p style="position: relative; bottom: 7px; right: 5px">
                                          280
                                        </p>
                                      </label>
                                 
                                    </div>
                                    </td>

                                    <td class="sizeTd">
                                        <div class="form-check col-3 ps-0 pe-1 align-self-center">
                                          <input
                                            type="checkbox"
                                            class="btn-check"
                                            name="sizeType"
                                            id="size_285"
                                            autocomplete="off"
                                            value="285"
                                          />
                                          <label
                                            class="btn btn-outline-secondary"
                                            for="size_285"
                                            style="width: 45px; height: 25px"
                                            ><p style="position: relative; bottom: 7px; right: 5px">
                                              285
                                            </p>
                                          </label>
                                     
                                        </div>
                                        </td>

                                        <td class="sizeTd">
                                            <div class="form-check col-3 ps-0 pe-1 align-self-center">
                                              <input
                                                type="checkbox"
                                                class="btn-check"
                                                name="sizeType"
                                                id="size_290"
                                                autocomplete="off"
                                                value="290"
                                              />
                                              <label
                                                class="btn btn-outline-secondary"
                                                for="size_290"
                                                style="width: 45px; height: 25px"
                                                ><p style="position: relative; bottom: 7px; right: 5px">
                                                  290
                                                </p>
                                              </label>
                                         
                                            </div>
                                            </td>

                                            <td class="sizeTd">
                                                <div class="form-check col-3 ps-0 pe-1 align-self-center">
                                                  <input
                                                    type="checkbox"
                                                    class="btn-check"
                                                    name="sizeType"
                                                    id="size_295"
                                                    autocomplete="off"
                                                    value="295"
                                                  />
                                                  <label
                                                    class="btn btn-outline-secondary"
                                                    for="size_295"
                                                    style="width: 45px; height: 25px"
                                                    ><p style="position: relative; bottom: 7px; right: 5px">
                                                      295
                                                    </p>
                                                  </label>
                                             
                                                </div>
                                                </td>
                </tr>
                    </table>
                  </div>         
                  <hr class="my-4">
                <div class="mb-3" style="width: 70%; margin-left: 30px;">
                    <table>
                        <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">사진</label>
                        <tr>
	                        <td style="width: 70%;">
	                            <div class="mb-3">
	                                <input class="form-control" type="file"  multiple="multiple" accept="image/jpg, image/jpeg, image/png" id="img_upload" name="img_upload"> <!-- onchange="preview()" -->
	                              </div>
	                        </td>
                        </tr>
                    </table>
                            <div class="mb-3" style="font-size: small;">
		                    <c:forEach items="${goodsImageList}" var="image">
							  ${image.GOODS_IMAGE_STD}<br>
					    	</c:forEach>
					    	</div>
                </div>  
                <hr class="my-4">
                <button class="btn btn-primary btn-lg" style="margin-left: 30%; width: 45%;" type="button" name="goodsModify">상품 수정</button>
            </div>
        </div>
        
</body>

<script>
$(document).ready(function(){
	
	// 상품 사이즈 표시
	<c:forEach items="${goodsSizeList}" var="size">
		console.log('${size.GOODS_DETAIL_SIZE}');
		$("input:checkbox[value='${size.GOODS_DETAIL_SIZE}']").prop("checked", true);
	</c:forEach>
	
	
	$("button[name='goodsModify']").on("click", function(e){	 // 상품 수정
		e.preventDefault();
		fn_goodsModify();
	
	});
	
	function fn_goodsModify(){
		var formData = new FormData();
		
		var goodsName = $("#TOTAL_GOODS_NAME").val();
		var goodsModel = $("#TOTAL_GOODS_MODEL").val();
		var category = document.getElementById("category");
		var goodsCategory = (category.options[category.selectedIndex].value);
		var goodsPrice = $("#TOTAL_GOODS_PRICE").val();
		
		var goodsSizeValues = [];
		$('input[name="sizeType"]:checked').each(function(i){
			goodsSizeValues.push($(this).val());
		});
		//var goodsSize = $('input[name="sizeType"]:checked').val();
			
		var uploadGoodsImg = $("input[name='img_upload']");
		var files = uploadGoodsImg[0].files;
		console.log(files);
		
		for(var i=0; i<files.length; i++){
			formData.append("uploadGoodsImg", files[i]);
		}
		
		formData.append("TOTAL_GOODS_NAME", goodsName);
		formData.append("TOTAL_GOODS_MODEL", goodsModel);
		formData.append("TOTAL_GOODS_CATEGORY", goodsCategory);
		formData.append("TOTAL_GOODS_PRICE", goodsPrice);
		formData.append("GOODS_DETAIL_SIZE_new", goodsSizeValues);
		formData.append("TOTAL_GOODS_NUM", ${goodsDetailMap.TOTAL_GOODS_NUM});
		//formData.append("img_upload", uploadGoodsImg);
		
		$.ajax({
			type : 'post',
			url : '/sk/brandPage/goodsModify',
			data : formData,
			processData : false,
			contentType : false,
			success : function(data){
				if(data.result == "pass"){
					alert("상품이 정상적으로 수정되었습니다.");
					location.href='/sk/brandPage/goodsList';
				} else if(data.result == "fail") {
					alert("상품 수정에 실패하였습니다.");
				}
			},
			error : function(request, status, error) {
			        console.log("code: " + request.status);
			        console.log("message: " + request.responseText);
			        console.log("error: " + error);
					alert("오류 발생");
			}	
			
		});
	}
	
	$(".sizeTd").mouseover(function() {
	      var stockCheckP = $("#stockCheckP");
	      stockCheckP.empty();
	      
	      var goodsSize = $(this).find('input:checkbox').attr('value');
	      var formData = new FormData();
	      formData.append("TOTAL_GOODS_NUM", ${goodsDetailMap.TOTAL_GOODS_NUM});
	      formData.append("GOODS_DETAIL_SIZE", goodsSize);
	      
	      $.ajax({
	         url : '/sk/brandPage/goodsModifyForm/sizeCheck',
	         type : 'POST',
	         data : formData,
	         processData : false,
	         contentType : false,
	         success : function(data) {
	            var str = "";
	            str += goodsSize + "(매장 수 : " + data.shopCount + "개 / 재고 : " + data.goodsAmount + "개)";
	            stockCheckP.append(str);
	         }
	      });
	   })
	   
	   $(".sizeTd").mouseleave(function() {
		  var stockCheckP = $("#stockCheckP");
	      stockCheckP.empty();
	      stockCheckP.append("사이즈에 마우스를 올리면 재고가 있는 매장 수 및 총 재고 개수가 표시됩니다.");
	   })
});

</script>

</html>