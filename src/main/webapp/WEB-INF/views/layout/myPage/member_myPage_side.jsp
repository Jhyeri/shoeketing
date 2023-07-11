<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<div class="col-2 order-ms-last" style="margin-top: 0px">
        <h3 style="margin-left: 13%; color: black">My Page</h3>
        <hr
          style="border: solid 1px rgb(73, 73, 73); width: 80%; margin-left: 5%"
        />
        <ul>
          <li class="list-group-item d-flex justify-content-between lh-sm">
            <div>
              <h4><a href="/sk/myPage/accountModifyForm">회원 정보 수정</a></h4>
              <small class="text-muted"> </small>
            </div>
          </li>
          <li class="list-group-item d-flex justify-content-between lh-sm mt-4">
            <div>
              <h5 class="my-0">나의 정보</h5>
              <br />
              <h6 class="text-muted" style="margin-left: 25px">
                <a href="/sk/myPage/goodsLikeList">찜 목록</a>
              </h6>
              <h6 class="text-muted" style="margin-left: 25px">
                <a href="/sk/myPage/reservationList">픽업 예약 목록</a>
              </h6>
            </div>
          </li>

          <li class="list-group-item d-flex justify-content-between lh-sm mt-4">
            <div>
              <h5 class="my-0">매장 문의</h5>
              <br />
              <h6 class="text-muted" style="margin-left: 25px">
                <a href="/sk/myPage/csList">나의 문의 내역</a>
              </h6>
              <h6 class="text-muted" style="margin-left: 25px">
                <a href="/sk/myPage/csWriteForm">문의 작성하기</a>
              </h6>
            </div>
          </li>

          <li
            class="list-group-item d-flex justify-content-between mt-4"
          >
            <div class="text-success">
              <h5 class="my-0"><a href="/sk/basket/basketList">장바구니</a></h5>
            </div>
          </li>

          <li class="list-group-item d-flex justify-content-between mt-5">
            <h5 class="my-0">
              <a href="/sk/myPage/accountDeleteForm">회원 탈퇴</a>
            </h5>
          </li>
        </ul>
      </div>
</body>
</html>