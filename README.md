# :pushpin: SHOEKETING
>신발 재고 조회 및 픽업예약 사이트

</br>

## 1. 제작 기간 & 참여 인원
- 2022년 2월 6일 ~ 2023년 3월 31일
- 팀 프로젝트 (6인)

</br>


## 2. 프로젝트에 사용된 기술
#### `Back-end`
  - Java (JDK 11)
  - Spring Framework 5.0.7
  - JSP
  - Oracle 11g
  - MyBatis 3.0

#### `Front-end`
  - HTML5
  - CSS3
  - JavaScript
  - Ajax
  - jQuery
  - bootstrap

#### `WAS`
  - Apache Tomcat 9.0

#### `API & 라이브러리`
  - 카카오 Maps API
  - 토스페이먼츠 API
  - 웹소켓
  - SOLAPI 문자 인증
  - JavaMail API
  - RESTful API(JSON)
  - 사업자 등록번호 API
  - JavaMail API

#### `IDE`
  - Spring Tool Suite 3
  - SQL Developer 
</br>

## 3. ERD 설계
 <img width="60%" src="https://github.com/Jhyeri/shoeketingtmp/assets/111175466/20769571-5bb0-4b1a-840d-ffad19ca6be6"/>

## 4. 프로젝트의 핵심 기능  
- **일반회원**
  - 실시간으로 브랜드/상품/사이즈/매장에 따라 신발 재고를 확인 할 수 있습니다.
  - 원하는 제품에 대한 픽업 예약 기능을 제공합니다.
- **매장회원**
  - 매장에서 보유하고 있는 상품에 대한 픽업 예약 관리와 재고 관리 기능을 제공합니다.
- **브랜드회원**
  - 해당 브랜드 상품의 등록, 수정, 삭제 기능과 새로운 매장의 입점 요청 관리 기능을 제공합니다.


<details>
<summary><b> 핵심기능 설명 펼치기</b></summary>
<div markdown="1">
  
### [일반회원]
  
#### 4.1. 신발 재고 수량 및 매장 위치 확인
- **매장 위치 조회** :pushpin: [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/goods/search/stockSearchForm.jsp)
  - 카카오 Maps API를 통해 매장 위치를 조회할 수 있습니다.
- **재고 수량 조회** :pushpin: [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/controller/StockController.java)
  - 브랜드/상품명/사이즈/매장별로 신발 재고 수량을 조회할 수 있습니다. :pushpin: [Service 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/service/StockServiceImpl.java)
<br/>

#### 4.2. 토스페이먼츠 결제
  - 상품 픽업 날짜를 지정하고 토스페이먼츠로 예약금 결제 기능을 제공합니다.
  - **날짜 지정** :pushpin: [JSP코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/goods/search/stockSearchForm.jsp)
  - **토스페이먼츠 결제** :pushpin: [Controller코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/TossPaymentsController.java)
<br/>

#### 4.3. 장바구니에서 픽업예약 
  - 장바구니에서 상품별로 빠르게 픽업예약을 진행할 수 있습니다.
    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/member/myPage/basket/basketList.jsp)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/BasketController.java)
    </div>
    </details>
<br/>

### [매장회원]

#### 4.4. 재고 수량 관리
  - 매장에서 보유하고 있는 상품의 재고 수량을 관리할 수 있습니다.

    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/shop/shopPage/stock/stockList.jsp)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/StockController.java)
    - [Service 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/service/StockServiceImpl.java)

    </div>
    </details>
<br/>

#### 4.5. 요청 픽업예약 관리
  - 매장에 요청된 픽업 예약을 승인/거부/취소가 가능합니다.
     <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/shop/shopPage/reservation/reservationRequestList.jsp)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/ReservationController.java)
    - [Service 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/service/ReservationServiceImpl.java)

    </div>
    </details>
<br/>

### [브랜드회원]
  
#### 4.6. 상품 등록 및 수정, 삭제
- 해당 브랜드의 상품을 등록/수정/삭제할 수 있습니다.
     <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [상품 목록 JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/brand/goods/goodsList.jsp)
    - [등록 폼 JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/brand/goods/goodsWriteForm.jsp)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/GoodsController.java)
    - [Service 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/service/GoodsServiceImpl.java)

    </div>
    </details>
<br/> 
 
#### 4.7. 매장 입점 요청 관리
- 브랜드 지점을 해당 사이트에 등록/삭제할 수 있습니다.

    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/shop/shopPage/reservation/reservationRequestList.jsp)
    - [Controller코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/ReservationController.java)
    - [Service 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/service/ReservationServiceImpl.java
)
    </div>
    </details>
<br/> 
</div>
</details>

<!-- </div>
</details> -->

</br>

## 5. 담당한 부분
 - 회원정보 수정
 - 회원 탈퇴
 - 리뷰 등록
 - 찜 목록
 - 픽업 예약 목록
 - 장바구니
   - 픽업예약 및 토스페이먼츠 결제

<details>
<summary><b>담당 기능 설명 펼치기</b></summary>
<div markdown="1">

### 5.1. 마이페이지
  - **회원정보 수정**
    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인하기](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L51)
    - [Controller코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L77)

    </div>
    </details>
  - **회원탈퇴**
    - 탈퇴 전, 비밀번호와 회원의 탈퇴가능여부를 확인합니다. 📌 [코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L109)
    - 비밀번호가 일치하면 회원의 삭제여부를 'Y'로 변경하여 탈퇴처리합니다. 📌 [코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L148)
<br/>

### 5.2. 찜 목록
  - **찜 목록**
    - 찜한 상품을 조회할 수 있습니다.
    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인하기](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/goodsLikeList.jsp)
    - [Controller코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java)

    </div>
    </details>
    
  - **찜 취소**
    - ajax 요청을 통해 상품의 썸네일을 클릭하면 찜 목록에서 삭제할 수 있습니다. 
    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/goodsLikeList.jsp#L62)
    - [Controller코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L163)

    </div>
    </details> 
<br/>

### 5.3. 문의내역
  - **나의 문의 내역 조회** 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/cs/controller/CSController.java#L49)

  - **문의글 상세보기** 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/cs/controller/CSController.java#L162)
    - 문의내역에서 함수를 호출하여 모달창으로 상세보기가 가능합니다.

  - **문의 작성**
    - 문의할 매장 찾기 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/cs/csWriteForm.jsp#L161)
      - **문의할 매장을 직접 지정**할 수 있습니다.
      - ajax요청을 통해 모든 매장을 조회할 수 있으며, 검색 또한 가능합니다.
    - 글 등록하기 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/cs/csWriteForm.jsp#L192)
    - 글 삭제하기 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/cs/csWriteForm.jsp#L132)
  
### 5.4. 리뷰 등록
  - **리뷰 작성 이력 확인**
    - 1회만 작성 가능하므로, 후기 등록 전에 리뷰 작성여부를 체크합니다.
  
  - **리뷰 등록**
    - ajax 요청을 통해 리뷰를 등록 처리 합니다.
<details>
<summary><b>📌 코드 확인</b></summary>
<div markdown="1">

- [JSP 코드 확인하기](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/reservation/reservationList.jsp)
- [Controller코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/review/controller/ReviewController.java)

</div>
</details>
<br/>

### 5.5. 장바구니
  - **장바구니 목록 조회** 📌[코드 확인]()
  - **상품 삭제**
    - 하나의 상품만 삭제하거나, 여러개의 상품을 삭제하는 전체삭제 기능도 제공합니다.📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/basket/basketList.jsp#L10)
    
  - **픽업예약**
    - 상품별로 원하는 날짜를 지정하여 픽업예약 및 토스페이먼츠 결제를 진행할 수 있습니다. 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/controller/TossPaymentsController.java)
    - **픽업예약** 버튼을 통해 하나의 상품만 예약 가능합니다. 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/basket/basketList.jsp#L48)
    - **선택예약** 버튼을 통해 최대 5개의 상품까지 한 번에 예약 및 결제가 가능합니다. 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/basket/basketList.jsp#L447)

</div>
</details>

<br/>

## 6. 핵심 트러블 슈팅

### 6.1. 중복된 코드와 작업을 줄이기 위한 노력

#### 📍 문제점 발견
- 사이트가 가진 대부분의 기능은 로그인 한 회원이 사용할 수 있으므로, 기능 구현 시 Session영역에 저장된 회원정보를 사용할 때가 많았습니다.
- 따라서 프로젝트 내 대부분의 메소드에서 **같은 코드가 중복**되는 것을 발견하였습니다.
 
#### 📍 해결 과정
중복되는 코드를 조금이나마 간결화하고, 간편하게 사용할 수 있는 방법을 고민해보았습니다.

 - **Service클래스 생성**  📌[코드 확인]()
   - Session영역에 저장된 회원정보 중, 원하는 정보만 골라서 꺼낼 수 있는 메소드를 작성하였습니다.
   - 다른 Service클래스나 Controller에서 함께 사용할 수 있도록 하였습니다. 

#### 📍 결과
- 기존
  -  해당 작업을 위해 동일한 코드를 2~3줄씩 작성해야 했으며, 자주 반복해야 했습니다.
- 현재
  - `예) sessionService.getSession(session, "MEM_NUM")` 와 같이 **한 줄**로 작성합니다.
  - 편리하게 사용할 수 있으며, 동일한 코드가 감소하였습니다.


</br>

## 7. 그 외 트러블 슈팅
<details>
<summary>Ajax함수 success 함수 동작 오류</summary>
<div markdown="1">

  - ajax함수가 요청은 처리하나, success함수가 동작하지 않음
  - ajax 함수에서 'json'으로 지정하였던 'dataType'속성을 제거하여 해결
 
</div>
</details>

<details>
<summary>String 강제형변환 오류</summary>
<div markdown="1">

  - int타입을 String타입으로 강제형변환 하였더니 오류 발생
  - toString()메소드로 수정하여 해결

</div>
</details>

<details>
<summary>Ajax함수 전송데이터 형식 문제</summary>
<div markdown="1">

  - **JSON.stringify()함수 사용**
    - 데이터가 `이름=값`의 형태로 전달되지 않음
    <details>
    <summary>📌기존코드</summary>
    <div markdown="1">
      <img width="60%" src="https://github.com/Jhyeri/shoeketingtmp/assets/111175466/aa5fb6a6-c138-480a-b077-5bb9a5318387"/>
    </div>
    </details>
  - **해결방법**
    - 이름과 값의 쌍으로 수정하여 해결 
     <details>
    <summary>📌개선된 코드</summary>
    <div markdown="1">
      <img width="60%" src="https://github.com/Jhyeri/shoeketingtmp/assets/111175466/4c784086-f7ae-48a5-954f-e1e77e5de1bc"/>
    </div>
    </details>
</div>
</details>

<details>
<summary>Ajax함수 배열 전송 오류</summary>
<div markdown="1">

- 에러메세지(400오류)
  - `Required List parameter 'basketList(전송받은 배열)' is not present`
  
- 해결방법
  - `$.ajaxSettings.traditional = true;` 추가
  - Controller의 `@ReqeustParam` 어노테이션을 `@ReqeustBody`로 수정
 
</div>
</details>
 
<details>
<summary>Ajax 사용 중 data 접근 오류</summary>
<div markdown="1">
  
 - Controller에서 리턴한 Map형태의 데이터에 접근하고자 함
   - 그러나 JSP에서 데이터를 찾을 수 없었음
    <details>
    <summary>📌기존코드 펼치기</summary>
    <div markdown="1">
      <img width="60%" src="https://github.com/Jhyeri/shoeketingtmp/assets/111175466/e75f69e6-683b-4424-bd9f-92e2347abbc6"/>
    </div>
    </details>
- **해결방법**
  - Controller에서 "result"라는 이름으로 리턴하였기 때문에 
  - **"data.result"로 수정하여 해결**
     <details>
    <summary>📌개선된 코드 펼치기</summary>
    <div markdown="1">
      <img width="60%" src="https://github.com/Jhyeri/shoeketingtmp/assets/111175466/3a218307-adb6-46d9-91e6-3765cde91a13"/>
    </div>
    </details>
   
</div>
</details>    

</br>

## 8. 회고 / 느낀점
>프로젝트 개발 회고 글: https://zuminternet.github.io/ZUM-Pilot-integer/
