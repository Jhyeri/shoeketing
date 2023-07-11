<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="col-2 order-ms-last" style="margin-top: 0px">
      <h3 style="margin-left: 13%; color: black">관리자</h3>
      <hr
        style="border: solid 1px rgb(73, 73, 73); width: 80%; margin-left: 5%"
      />
      <ul>
        <li class="list-group-item d-flex justify-content-between lh-sm mt-4">
          <div>
            <h5 class="my-0">공지사항</h5>
            <br />
            <h6 class="text-muted mb-3" style="margin-left: 25px">
              <a href="/sk/admin/noticeList" style="font-weight: 400;">공지사항 목록</a>
            </h6>
            <h6 class="text-muted mb-3" style="margin-left: 25px">
              <a href="/sk/admin/noticeWriteForm" style="font-weight: 400;">공지사항 작성</a>
            </h6>
          </div>
        </li>

        <li class="list-group-item d-flex justify-content-between lh-sm mt-4">
          <div>
            <h5 class="my-0">회원 관리</h5>
            <br />
            <h6 class="text-muted mb-3" style="margin-left: 25px">
              <a href="/sk/admin/memberList" style="font-weight: 400;">일반회원</a>
            </h6>
            <h6 class="text-muted mb-3" style="margin-left: 25px">
              <a href="/sk/admin/shopList" style="font-weight: 400;">매장회원</a>
            </h6>
            <h6 class="text-muted mb-3" style="margin-left: 25px">
              <a href="/sk/admin/brandList" style="font-weight: 400;">브랜드회원</a>
            </h6>
          </div>
        </li>

        <li
          class="list-group-item d-flex justify-content-between bg-light mt-4"
        >
          <div class="text-success">
            <h5 class="my-0"><a href="/sk/admin/goodsTotalList">상품 관리</a></h5>
          </div>
        </li>

      </ul>
    </div>
</body>
</html>