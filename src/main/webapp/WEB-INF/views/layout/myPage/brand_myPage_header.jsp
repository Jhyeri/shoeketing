<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="py-5 row" style="background-color: black; height: 200px;" >
        <div class="col align-self-center ms-5" style="margin-left: 100px;">
        <table>
        <tr>
        <td>
            <img class="mb-1 mt-2" style="width: 80px; height: 80px; margin-right: 90%;" src="/sk/image/display?fileName=<%= session.getAttribute("session_BRAND_LOGO_FILE")%>">
            </td>
            <td>
            <p class="mb-0 fs-1" style="margin-left: 30px; margin-top: 0px; color: rgb(255, 255, 255); font-size: larger; font-weight: border;"><%= session.getAttribute("session_BRAND_NAME")%></p>
            </td>
            </tr>
            </table>
      </div>
       </div>
</body>
</html>