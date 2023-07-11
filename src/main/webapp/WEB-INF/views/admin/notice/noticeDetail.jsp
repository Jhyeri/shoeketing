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
        공지사항
      </h3>

      <hr/>

      <table class="table">
        <thead>
            <tr>
              <th>
                <h5 class="ms-2 mb-2">${noticeDetail.NOTICE_TITLE}</h5>
                <p
                  class="ms-2 mb-1"
                  style="
                    font-weight: 400;
                    font-size: 14px;
                    color: rgba(0, 0, 0, 0.6);
                  "
                >
                  ${noticeDetail.NOTICE_DATE}
                </p>
              </th>
            </tr>
          </thead>
          <tbody class="table-group-divider">
            <tr>
              <td>
                <pre class="mt-4 mb-4 ms-2">
 ${noticeDetail.NOTICE_CONTENT}
 </pre
                >
              </td>
            </tr>
          </tbody>
      </table>
      <div class="row">
        <div class="col-12 text-end">
          <button type="button" class="btn btn-primary" name="adminNoticeModify" style="width:6rem">수정</button>
          <button type="button" class="btn btn-danger" name="adminNoticeDelete" style="width:6rem">삭제</button>
          <button type="button" class="btn btn-secondary" id="noticeListBtn" style="width:6rem">목록</button>
        </div>
      </div>
    </div>
  </body>
  
  <script>
  $(document).ready(function() {
		
		$("button[name='adminNoticeDelete']").on("click", function(e) {  // 관리자 공지사항 삭제
			e.preventDefault();
			fn_adminNoticeDelete();
		});
		
		function fn_adminNoticeDelete() {
			var formData = new FormData();
			var noticeDelete =  ${noticeDetail.NOTICE_NUM};
			
			formData.append("NOTICE_NUM", noticeDelete);
			
			$.ajax({
				url: '/sk/admin/noticeDelete',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function(data) {
					if(data==1) {
						alert("게시물을 삭제했습니다.");
						location.href='/sk/admin/noticeList';
					} else {
						alert("게시물 삭제를 실패했습니다.");
					}
				
				},
				error: function(xhr, status, error) {
					console.log('실패');
				}
			});
		};

		$("button[name='adminNoticeModify']").on("click", function(e) {  // 관리자 공지사항 수정
			e.preventDefault();
			fn_adminNoticeModify();
		});
		
		function fn_adminNoticeModify() {
			var noticeModify =  ${noticeDetail.NOTICE_NUM};
			location.href="/sk/admin/noticeModifyForm?NOTICE_NUM=" + noticeModify;
	};
	
	$("#noticeListBtn").on("click", function(e) {
		var page = ${page};
		var searchType = '${searchType}';
		var keyword = '${keyword}';
		location.href = '/sk/admin/noticeList?page=' + page + '&searchType=' + searchType + '&keyword=' + keyword;
	});
  
  });

  </script>
</html>