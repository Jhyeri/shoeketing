<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@ include file="../include/include-head.jspf" %>
<style>
.container {
        width: 1500px;
        max-width: none!important;
      }

      .navbar {
        width: 1000px;
        max-width: none!important;
      }
body, pre {
  font-family: 'Noto Sans KR', sans-serif;
}
</style>
<title>SHOEKETING</title>
</head>
<body>
	<!-- header -->
	<tiles:insertAttribute name="header"/>
	<!-- header end -->
	
	<!-- body1 --> 
	<main id="main">
	<tiles:insertAttribute name="body1"/>
	<%@ include file="../include/include-body.jspf" %>
	</main>
	<!-- body1 end -->
	
	<!-- footer --> 
	<tiles:insertAttribute name="footer"/>
	<!-- footer end -->
</body>
<%@ include file="../include/include-foot.jspf" %>
</html>