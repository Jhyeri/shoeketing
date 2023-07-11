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
<!-- 모달 -->
<div class="modal fade" id="findShop" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content" style="width:600px; height: auto;">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">매장 찾기</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
        	<div class="mt-3 ms-3 row-cols-md-1">
            	<table style="text-align: center;">
	            	<thead>
		                <tr class="mb-0" style="height: 70px;">
		                    <td style="width: 20%;">
		                    <label for="exampleFormControlInput1" class="form-label" style="font-size: large; font-weight: bolder;">매장 선택</label>
		                    </td>
		                    <td>
		                    <input type="text" name="keyword" class="form-control" id="exampleFormControlInput1">
		                    </td>
		                    <td style="width: 25%;">
		                        <button type="button" class="btn btn-primary" data-bs-target="#findShop" name="m_findShop">매장 찾기</button>
		                    </td>
		                </tr>
	                </thead>
                	<tbody id="stay">
              		</tbody>
          		</table>
            </div>
            <br>
	            <!-- 페이징 화면 처리 부분 시작 -->
		      	<div id="PAGE_NAVI"></div>
				<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
				<!-- 페이징 화면 처리 부분 끝 -->
        </div>
      </div>
   </div>
</div>
    <!-- 모달 끝 -->

        <div class="col-8" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">문의 작성</h3>
            <hr style="border: solid 1px rgb(73, 73, 73); width: 100%; ">
            <form class="needs-validation" novalidate method="post">
            <div class="row g-2">
                <table style="width: 99%; margin-left: 10px; text-align: center;">
                  <div class="mt-3" style="width: 45%; margin-left: 30%;">
                    <tr class="mt-3 mb-3">
                        <td style="width: 20%; height: 100px;">
                        <label for="shopValid" class="form-label" style="font-size: large; font-weight: bolder;">매장 선택</label>
                        </td>
                        <td>
                        <input type="text" name="searchbar" class="form-control" id="shopValid" readonly required>
                        </td>
                        <td style="width: 25%;">
                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#findShop" name="findShop">매장 찾기</button>
                             <div class="invalid-feedback">
						        매장 찾기를 이용해주세요.
						     </div>
                        </td>
                    </tr>

                    <tbody class="table-group-divider">

                    <tr>
                        <td style="width: 20%; height: 100px;">
                        <label for="titleValid" class="form-label" style="font-size: large; font-weight: bolder;">제  목</label>
                        </td>
                        <td>
                            <input type="text" name="title" class="form-control" id="titleValid" required>
                            <div class="invalid-feedback">
					        	제목을 입력해주세요.
					      	</div>
                        </td>
                     </tr>

                     <tbody class="table-group-divider" style="width: 50%;">

                    <tr>
                            <td style="width: 20%; height: 100px;">
                            <label for="contentsValid" class="form-label" style="font-size: large; font-weight: bolder;">내  용</label>
                            </td>
                            <td style="width: 40%;">
                                <textarea class="form-control" id="contentsValid" rows="10" name="content" required></textarea>
                                <div class="invalid-feedback">
						        	내용을 입력해주세요.
						      	</div>
                            </td>
                    </tr>
                </table>
                <hr style="margin-left: 30px; border: solid 1px rgb(73, 73, 73); width: 100%; ">
                <button style="margin-left: 78%; width: 25%; align-self: center;" type="submit" class="btn btn-primary" name="register">등 록</button>
              </div>
              </form>
      </div>
      
      
<script type="text/javaScript">
$(document).ready(function() {
	
	fn_selectShopList(1);
	
	$("button[name='findShop']").on("click", function(e) { //매장찾기 버튼을 누르면
		 e.preventDefault();
		 findShop();
	});
	
	$("button[name='m_findShop']").on("click", function(e) { //매장이름 검색 시
		 e.preventDefault();
		 findShop();
	});
	
	//유효성 검사
	 (() => {
	 	  'use strict'
	   // Fetch all the forms we want to apply custom Bootstrap validation styles to
	   const form = document.querySelector('.needs-validation')
	   // Loop over them and prevent submission
	 $("button[name='register']").on("click", function(e) { //등록 버튼 누르면
	 	 form.classList.add('was-validated')
	 		
	 	if (!form.checkValidity()) {
	         event.preventDefault()
	         event.stopPropagation()
	         return false;
	     }
	 	//입력한 제목과 내용을 각각 변수에 저장
	 	let titleValid = $('#titleValid').val();
	 	let contentsValid = $('#contentsValid').val();
	 	
	 	//제목, 내용 글자 수 읽어와서 글자수 제한 alert창 띄워주기
	 	//제목 최대 133글자 입력 가능 (title 최대 400byte (오라클 기준 한글 1글자당 3byte))
	 	if(titleValid.length > 133){
	 		alert("제목을 최대 133글자로 작성해주세요.")
	 		$('#titleValid').focus()
	 		return false;
	 	}
	 	
	 	//내용 최대 1333글자 입력 가능 (content 최대 4000byte (오라클 기준 한글 1글자당 3byte))
	 	if(contentsValid.length > 1333){
	 		alert("내용을 최대 1333글자로 작성해주세요.")
	 		$('#contentsValid').focus()
	 		return false;
	 	}
	 	fn_register();
	 	});
	 })()
});

		
	
	const findShop = function() { //매장 리스트 가져오기
		var keyword = $("#exampleFormControlInput1").val();
		console.log("검색어 : " + keyword);
		var formData = new FormData();
	    formData.append("keyword", keyword);
		
	    if(keyword == null){
	         alert("검색어를 입력해주세요.");
	    	return false;  
	    }
	    $.ajax({
			url:"/sk/myPage/findShopAjax",
			type:'post',
			data:formData,
	        processData:false,
	        contentType:false,
	        dataType:'HTML',
			success:function(data) {
					console.log("검색어 전송 성공 : " + keyword);
					console.log(data);
				
					$("#stay").empty();
					$("#stay").html(data);
			},
			error:function() {
				alert("잠시 후 다시 시도해주세요.");
			}	
		}); 
	};
	
	 function selectShop(shopName, shopNum) {
		 $("input[name='searchbar']").val(shopName);
		 $("input[name='searchbar']").attr("data-num", shopNum);
	}
	 
	 function fn_register() {
		 
		 var title = $("input[name='title']").val();
		    var content = $("textarea").val();

		    // 제목이나 내용이 비어있는지 확인
		    if (title.trim() === '') {
		        alert('제목을 입력해주세요.');
		        return;
		    }

		    if (content.trim() === '') {
		        alert('내용을 입력해주세요.');
		        return;
		    }

		    // 입력한 제목과 내용이 유효한지 확인
		    var titleRegex = /^[a-zA-Z0-9ㄱ-ㅎ가-힣\s]{2,100}$/; // 제목은 영문,숫자,한글,공백 1~100자
		    var contentRegex = /^[a-zA-Z0-9ㄱ-ㅎ가-힣\s]{2,500}$/; // 내용은 영문,숫자,한글,공백 1~500자
		    
		    if (!titleRegex.test(title)) {
		        alert('제목은 영문,숫자,한글,공백 2~100자로 입력해주세요.');
		        return;
		    }

		    if (!contentRegex.test(content)) {
		        alert('내용은 영문,숫자,한글,공백 2~500자로 입력해주세요.');
		        return;
		    }

		    // 매장 번호가 선택되었는지 확인
		    var shopNum = $("input[name='searchbar']").attr("data-num");
		    if (!shopNum) {
		        alert('매장을 선택해주세요.');
		        return;
		    }

		 
		 
		var formData = new FormData();
		formData.append("CS_TITLE", $("input[name='title']").val());
		formData.append("CS_CONTENT", $("textarea").val());
		formData.append("CS_SHOP_NUM",$("input[name='searchbar']").attr("data-num"));
	//var title =	$("input[name='title']").val();
	 //	var content = $("#content").val();
	 
	 	if(confirm("작성중인 글을 등록하시겠습니까?")) {
	 		$.ajax({
				url:"/sk/myPage/csWrite",
				type:'post',
				data:formData,
		        processData:false,
		        contentType:false,
				success:function(data) {
						console.log("글 전송 성공 : " + formData);
						alert("글을 등록하였습니다.");
						location.href="/sk/myPage/csList";
				},
				error:function() {
					alert("잠시 후 다시 시도해주세요.");
				}	
			});
	 	} 
	 };
	 
	 function fn_selectShopList(pageNo) {//페이징 함수
		 var keyword = $("#exampleFormControlInput1").val();
		 
		 var comAjax = new ComAjax();
		 comAjax.setUrl("/sk/myPage/findShop/paging");
		 comAjax.setCallback("fn_selectShopListCallback");
		 comAjax.addParam("PAGE_INDEX", pageNo);
		 comAjax.addParam("PAGE_ROW", 10); //한 페이지에 보여줄 게시물의 개수
		 comAjax.addParam("keyword", keyword);
		 
		 comAjax.ajax();
	}

	function fn_selectShopListCallback(data) {
		var total = data.TOTAL; //게시물의 개수 
		var body = $("#stay");
		
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
					eventName : "fn_selectShopList"
			};
			gfn_renderPaging(params);
			
			var str = "";
			
			$.each(data.shopList, function(key, value, index) {
				
				str +=	"<tr class='mb-0' style='height: 70px;' id='firstRow_"+index+"'>";
				str +=	"<td style='width: 20%;'>";
				str +=		"<p style='font-weight: bolder; font-size: medium; margin-bottom: 0;' id='shop_name'>"+value.SHOP_NAME+"</p>";
				str +=	"</td>";
				str +=	"<td id='shop_add_"+index+"'>"+value.SHOP_ADD+"</td>";
				str +=		"<td style='width: 25%;'>";
				str +=			"<a href='#' style='text-decoration: underline;' id='m_select' data-bs-dismiss='modal' onClick='selectShop("+value.SHOP_NAME+","+value.SHOP_NUM+")'>선택</a>";
				str +=		"</td>";
				str +=	"</tr>";

			});
			body.append(str);
		}
	}
	 
	 
	 
</script>
</body>
</html>