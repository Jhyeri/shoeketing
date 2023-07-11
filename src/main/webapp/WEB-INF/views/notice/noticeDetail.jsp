<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container {
        width: 1200px; /*기본값 1500px*/
        max-width: none !important;
      }
</style>
</head>
<body>
    <div class="container">
      <div class="row d-flex mb-4 mt-5">
        <h3 class="" style="font-weight: 700">공지사항</h3>
      </div>

      <div class="row">
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
      </div>

      <div class="row text-end">
        <div class="col-12">
          <button type="button" class="btn btn-secondary" id="noticeListBtn" style="width:6rem">목록</button>
        </div>
      </div>
    </div>
  </body>
<script>
$(document).ready(function() {
	$("#noticeListBtn").on("click", function(e) {
		var page = ${page};
		var searchType = '${searchType}';
		var keyword = '${keyword}';
		location.href = '/sk/noticeList?page=' + page + '&searchType=' + searchType + '&keyword=' + keyword;
	});
})
</script>
</html>