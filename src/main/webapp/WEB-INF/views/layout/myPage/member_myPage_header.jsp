<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="py-5 row" style="background-color: black;" >
        <div class="col align-self-center ms-5" style="margin-left: 100px;">
            <h1 class="mb-0 fs-1" style="color: rgb(255, 255, 255);">${session_MEM_INFO.MEM_NAME}님</h1>   
    
        </div>
        <div class="col text-end" style="margin-right: 100px;">
            <h1 class="mb-0 fs-1" style="color: rgb(255, 255, 255);">${session_MEM_INFO.MEM_GRADE}</h2>
            <h1 class="mb-0 fs-5" style="color: rgb(255, 255, 255);">
            	<a style="color: rgb(255, 255, 255);" href="/sk/myPage">등급혜택</a>
            </h2>
        </div>
       </div>
</body>
</html>