<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="col-10" style="margin-top: 0px">
      <h3 style="margin-left: 30px; color: black; font-weight: bolder">
        공지사항 수정
      </h3>

      <hr />

      <table class="table">
        <thead>
          <tr>
            <th>
              <div class="d-flex mb-3">
                <label for="NOTICE_TITLE" class="form-label ms-5 mb-0 align-self-center" style="width:6rem">제목</label>
                <input
                  type="text"
                  class="form-control align-self-center"
                  id="NOTICE_TITLE"
                  name="NOTICE_TITLE"
                  placeholder="제목을 입력해주세요"
                  value="${noticeDetail.NOTICE_TITLE}"
                  required
                />
              </div>
            </th>
          </tr>
        </thead>
        <tbody class="table-group-divider">
          <tr>
            <td>
              <div class="d-flex mt-3 mb-3">
                <label for="NOTICE_CONTENT" class="form-label ms-5 mb-0 align-self-center" style="width:6rem">내용</label>
                <textarea
                  class="form-control align-self-center"
                  id="NOTICE_CONTENT"
                  name="NOTICE_CONTENT"
                  rows="8"
                  required
                >${noticeDetail.NOTICE_CONTENT}</textarea>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
      <div class="row">
        <div class="col-12 text-end">
          <button type="button" class="btn btn-primary" name="noticeModify" style="width: 6rem">
            수정
          </button>
        </div>
      </div>
    </div>
  </body>
  <script>
  $(document).ready(function() { 
		$("button[name='noticeModify']").on("click", function(e) { 
			e.preventDefault();
			fn_noticeModify();
		});
		
		function fn_noticeModify() {
			var formData = new FormData();
			
			var NOTICE_TITLE = $("#NOTICE_TITLE").val();
			var NOTICE_CONTENT = $("#NOTICE_CONTENT").val();
			var NOTICE_NUM = parseInt("${noticeDetail.NOTICE_NUM}");
			
			formData.append("NOTICE_TITLE", NOTICE_TITLE);
			formData.append("NOTICE_CONTENT", NOTICE_CONTENT);
			formData.append("NOTICE_NUM", NOTICE_NUM);
			
			$.ajax({
				type : 'post',
				url : '/sk/admin/noticeModify',
				data : formData,
				processData : false,
				contentType : false,
				success : function(data){
					if(data== 1){
						alert("공지사항이 수정되었습니다.");
						location.href='/sk/admin/noticeDetail?NOTICE_NUM=' + NOTICE_NUM;
					} else {
						alert("공지사항이 수정되지 못했습니다.");
					}
				},
				error : function(){
					alert("오류 발생");
				}
			});	
		};
	});
</script>
</html>