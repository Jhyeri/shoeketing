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
        공지사항 작성
      </h3>

      <hr />
      
      <form id="noticeWriteForm" class="needs-validation" novalidate action="/sk/memberJoin/joinSuccess" method="post">

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
                ></textarea>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
      <div class="row">
        <div class="col-12 text-end">
          <button type="button" class="btn btn-primary" name="noticeWrite" style="width: 6rem">
            작성
          </button>
        </div>
      </div>
      </form>
    </div>
  </body>
  
 <script>
  $(document).ready(function() { 
		$("button[name='noticeWrite']").on("click", function(e) { 
			e.preventDefault();
			fn_noticeWrite();
		});
		
		function fn_noticeWrite() {
			  var formData = new FormData();

			  var NOTICE_TITLE = $("#NOTICE_TITLE").val();
			  var NOTICE_CONTENT = $("#NOTICE_CONTENT").val();

			  formData.append("NOTICE_TITLE", NOTICE_TITLE);
			  formData.append("NOTICE_CONTENT", NOTICE_CONTENT);

			  // 입력 필드의 조건 검사 수행
			  if (NOTICE_TITLE == null || $.trim(NOTICE_TITLE) == "") {
			    alert("제목을 입력해주세요.");
			    $("#NOTICE_TITLE").focus();
			    return;
			  } else if (NOTICE_TITLE.length < 2 || NOTICE_TITLE.length > 10) {
			    alert("제목은 2자 이상 10자 이하로 입력해주세요.");
			    $("#NOTICE_TITLE").focus();
			    return;
			  }

			  if (NOTICE_CONTENT == null || $.trim(NOTICE_CONTENT) == "") {
			    alert("내용을 입력해주세요.");
			    $("#NOTICE_CONTENT").focus();
			    return;
			  } else if (NOTICE_CONTENT.length < 10 || NOTICE_CONTENT.length > 100) {
			    alert("내용은 10자 이상 100자 이하로 입력해주세요.");
			    $("#NOTICE_CONTENT").focus();
			    return;
			  }

			  $.ajax({
			    type: "post",
			    url: "/sk/admin/noticeWrite",
			    data: formData,
			    processData: false,
			    contentType: false,
			    success: function (data) {
			      if (data == 1) {
			        alert("공지사항이 작성되었습니다.");
			        location.href = "/sk/admin/noticeList";
			      } else {
			        alert("공지사항이 작성 실패");
			      }
			    },
			    error: function () {
			      alert("오류 발생");
			    },
			  });
			}

	});
  
  
  (() => {
	  'use strict'

	  // Fetch all the forms we want to apply custom Bootstrap validation styles to
	  const forms = document.querySelectorAll('.needs-validation')

	  // Loop over them and prevent submission
	  Array.from(forms).forEach(form => {
	    form.addEventListener('submit', event => {
	      if (!form.checkValidity()) {
	        event.preventDefault()
	        event.stopPropagation()
	      }

	      form.classList.add('was-validated');
	      
	      
	      //제목
	      var NOTICE_TITLE = $("#NOTICE_TITLE").val();
	      
	      if (NOTICE_TITLE == null || $.trim(NOTICE_TITLE)== "") {
	        alert('제목을 입력해주세요.');
	          
	        $("#NOTICE_TITLE").focus();
	        event.preventDefault();
	        return;
	      } else if (NOTICE_TITLE.length < 2 || NOTICE_TITLE.length > 10) {
	        alert('제목은 2자 이상 10자 이하로 입력해주세요.');
	          
	        $("#NOTICE_TITLE").focus();
	        event.preventDefault();
	        return;
	      }
	      
	      //내용
	      var NOTICE_CONTENT = $("#NOTICE_CONTENT").val();
	      
	      if (NOTICE_CONTENT == null || $.trim(NOTICE_CONTENT)== "") {
	        alert('내용을 입력해주세요.');
	          
	        $("#NOTICE_CONTENT").focus();
	        event.preventDefault();
	        return;
	      } else if (NOTICE_CONTENT.length < 10 || NOTICE_CONTENT.length > 100) {
	        alert('내용은 10자 이상 100자 이하로 입력해주세요.');
	          
	        $("#NOTICE_CONTENT").focus();
	        event.preventDefault();
	        return;
	      }
	      
	      
	    }, false);
	  });
	})()

</script>
</html>