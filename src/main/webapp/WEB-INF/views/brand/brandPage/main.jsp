<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <div class="col-8" style="margin-top: 0px;">
            <h3 style="margin-left: 30px; color: black; font-weight: bolder;">브랜드 회원 마이페이지</h3>

			  <!-- 추후 data-brandNum 세션에서 꺼낸 BRAND_NUM 값으로 전송 -->
              <h4 style="margin-left: 30px; margin-top: 60px; color: black; font-weight: bolder; text-align: center;"><a href="/sk/brandPage/accountModifyForm">기본 정보 수정</a></h4> 

              <h4 style="margin-left: 30px; margin-top: 70px; color: black; font-weight: bolder; text-align: center;"><a href="/sk/brandPage/goodsList">상품 관리</a></h4>

              <h4 style="margin-left: 30px; margin-top: 70px; color: black; font-weight: bolder; text-align: center;"><a href="/sk/brandPage/shopList">매장 관리</a></h4>
            </div>

<!-- <script type="text/javascript">
$(document).ready(function() {
	$("a[name='brandInfoModify']").on("click", function(e) {  // 브랜드 기본정보 수정
		e.preventDefault();
	
		const brandNum = $(this).attr("data-brandNum");
		location.href="/sk/brandPage/accountModifyForm?BRAND_NUM=" + brandNum;
		
		//fn_brandInfoModify(brandNum);
	});
	
	/* //ajax로 왜 안될까... url 요청은 잘 가는데 Controller에서 ModelAndView 동작이 안된당,, 나중에 방법 찾기,, 
	function fn_brandInfoModify(brandNum){
		
		var brandNum1 = brandNum;
		
		var params = {
				"BRAND_NUM" : brandNum1
		}
		
		$.ajax({
			type : 'post',
			url : '/sk/brandPage/accountModifyForm',
			data : JSON.stringify(params),
			contentType : "application/json; charset=utf-8",
			 success : function(data){
				 console.log(data);
			},
			error : function(){
				alert("오류 발생");
			}
			
		});
	}  */
});

</script> -->

</body>
</html>