<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
  <div class="py-5 row" style="background-color: black; height: 200px;" >
    <div class="col align-self-center ms-5" style="margin-left: 100px;">
        <h1 class="mb-0 fs-1" style="color: rgb(255, 255, 255);"><%=session.getAttribute("session_SHOP_NAME")%></h1>   
    </div>
    
    <div class="col text-end mt-0" style="margin-right: 100px; align-items: center;">
    <table style="margin-left: 430px;">
    <tr>
    	<td>
            <img class="mb-1 mt-2" style="width: 80px; height: 80px; margin-right: 30px;" src="/sk/image/display?fileName=<%= session.getAttribute("session_SHOP_BRAND_LOGO_FILE")%>">
        </td>
        
        <td>
            <p class="mb-0 fs-2" style="color: rgb(255, 255, 255); font-size: larger;">나이키</p>
        </td>
    </tr>
    </table>
      </div>
   </div>
</body>
</html>