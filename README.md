# :pushpin: SHOEKETING
>신발 재고 조회 및 픽업예약 사이트

</br>

## 1. 제작 기간 & 참여 인원
- 2022년 2월 6일 ~ 2023년 3월 20일
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
  - bootstrap

#### `WAS`
  - Apache Tomcat 9.0

#### `API & 라이브러리`
  - 카카오 Maps API
  - 토스페이먼츠 API
  - 웹 소켓
  - SOLAPI 문자 인증
  - RESTful API(JSON)
  - 국세청 사업자등록정보진위확인 API
  - JavaMail 라이브러리
  - jQuery

#### `IDE`
  - Spring Tool Suite 3
  - SQL Developer 
</br>

## 3. ERD 설계
 <img width="70%" src="https://github.com/Jhyeri/shoeketing/assets/111175466/50cc572f-5119-4b53-b21b-4a08b9ade715"/>

## 4. 프로젝트의 핵심 기능  
  - **일반회원**
    - 실시간으로 브랜드/상품/사이즈/매장에 따라 신발 재고를 확인 할 수 있습니다.
    - 원하는 제품에 대한 픽업 예약 기능을 제공합니다.<br/><br/>
  - **매장회원**
    - 매장에서 보유하고 있는 상품에 대한 픽업 예약 관리와 재고 관리 기능을 제공합니다.<br/><br/>
  - **브랜드회원**
    - 해당 브랜드 상품의 등록, 수정, 삭제 기능과 새로운 매장의 입점 요청 관리 기능을 제공합니다.<br/>


<details>
<summary><b> 핵심기능 설명 펼치기</b></summary>
<div markdown="1">
  
## [일반회원]
  
### 4.1. 신발 재고 수량 및 매장 위치 확인
  - **매장 위치 조회** :pushpin: [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/goods/search/stockSearchForm.jsp)
    - 카카오 Maps API를 통해 매장 위치를 조회할 수 있습니다.
  - **재고 수량 조회** :pushpin: [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/controller/StockController.java)
    - 브랜드/상품명/사이즈/매장별로 신발 재고 수량을 조회할 수 있습니다. :pushpin: [Service 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/service/StockServiceImpl.java)
<br/>

### 4.2. 토스페이먼츠 결제
  - 상품 픽업 날짜를 지정하고 토스페이먼츠 API로 예약금 결제 기능을 제공합니다.
  - **날짜 지정** :pushpin: [JSP코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/goods/search/stockSearchForm.jsp)
  - **토스페이먼츠 결제** :pushpin: [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/TossPaymentsController.java)
<br/>

### 4.3. 장바구니에서 픽업예약 
  - 장바구니에서 상품별로 빠르게 픽업예약을 진행할 수 있습니다.
    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/member/myPage/basket/basketList.jsp)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/BasketController.java)
    </div>
    </details>
<br/>

## [매장회원]

### 4.4. 재고 수량 관리
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

### 4.5. 요청 픽업예약 관리
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

## [브랜드회원]
  
### 4.6. 상품 등록 및 수정, 삭제
- 해당 브랜드의 상품을 등록/수정/삭제할 수 있습니다.
     <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [상품 목록 JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/brand/goods/goodsList.jsp)
    - [등록 페이지 JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/brand/goods/goodsWriteForm.jsp)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/GoodsController.java)
    - [Service 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/service/GoodsServiceImpl.java)

    </div>
    </details>
<br/> 
 
### 4.7. 매장 입점 요청 관리
- 브랜드 지점을 해당 사이트에 등록/삭제할 수 있습니다.

    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/webapp/WEB-INF/views/shop/shopPage/reservation/reservationRequestList.jsp)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/SK/src/main/java/sk/item/controller/ReservationController.java)
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
 - 일반회원 정보 수정/탈퇴
 - 찜 목록
 - 문의 게시판
 - 실시간 알림 (웹 소켓)
 - 픽업 예약 목록 + 리뷰 등록
 - 장바구니 목록
 - 픽업예약 및 간편결제 (토스페이먼츠 API)


   
<details>
<summary><b>담당 기능 설명 펼치기</b></summary>
<div markdown="1">

### 5.1. 마이페이지
  - **회원정보 수정**
    <details>
    <summary><b>📌 코드 확인</b></summary>
    <div markdown="1">
  
    - [JSP 코드 확인하기](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L51)
    - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L77)

    </div>
    </details>
  - **회원탈퇴**
    - 탈퇴 전, 비밀번호와 회원의 탈퇴가능여부를 확인합니다. 📌 [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L105)
    - 비밀번호가 일치하면 회원의 삭제여부를 'Y'로 변경하여 탈퇴처리합니다. 📌 [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L144)
<br/>

### 5.2. 찜 목록
  - **찜 목록**
    - 찜한 상품을 조회할 수 있습니다.<br/>
  
      <details>
      <summary><b>📌 코드 확인</b></summary>
      <div markdown="1">
    
      - [JSP 코드 확인하기](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/goodsLikeList.jsp)
      - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java)
    
      </div>
      </details>
    
  - **찜 취소**
    - ajax 요청을 통해 상품의 썸네일 이미지를 클릭하면 찜 목록에서 삭제할 수 있습니다.<br/>
      <details>
      <summary><b>📌 코드 확인</b></summary>
      <div markdown="1">
    
      - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/goodsLikeList.jsp#L62)
      - [Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/myPage/controller/MemberPageController.java#L195)
  
      </div>
      </details> 
      <br/>

### 5.3. 문의내역
  - **나의 문의 내역 조회** 📌[Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/cs/controller/CSController.java#L49)

  - **문의글 상세보기** 📌[Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/cs/controller/CSController.java#L162)
    - 문의내역에서 함수를 호출하여 모달창을 띄웁니다.

  - **문의 작성** 📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/cs/controller/CSController.java) 
<br/>

### 5.4. 실시간 알림
  - **웹 소켓 설정** 📌[Handler 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/common/handler/InformHandler.java)
    - 클라이언트가 서버로 연결 시, 로그인 중인 개별 유저를 저장합니다.
    - 클라이언트가 데이터 전송 시, 특정 유저에게 알림을 전송처리 합니다.

  - **웹 소켓 연결** 📌[JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/layout/header.jsp)
    - 모든 페이지에서 공통으로 사용하는 페이지인 header.jsp에 웹 소켓을 연결합니다.

  - **알림 메시지 전송** 📌[JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/shop/shopPage/cs/csList.jsp#L127)

<br/>

### 5.5. 리뷰 등록
  - **리뷰 작성 이력 확인**
    - 1회만 작성 가능하므로, 후기 등록 전에 리뷰 작성여부를 체크합니다.
  
  - **리뷰 등록**
    - ajax 요청을 통해 리뷰를 등록 처리 합니다.
  
      <details>
      <summary><b>📌 코드 확인</b></summary>
      <div markdown="1">
      
      - [JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/reservation/reservationList.jsp#L235)
      - [Controller코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/review/controller/ReviewController.java)
      
      </div>
      </details>
<br/>

### 5.6. 장바구니
  - **장바구니 목록 조회** 📌[Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/controller/BasketController.java#L68)
  - **상품 삭제** 📌[Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/controller/BasketController.java#L68)
  - **픽업예약** 📌[Controller 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/item/controller/TossPaymentsController.java)
    - 상품별로 원하는 날짜를 지정하여 픽업예약 및 토스 간편결제를 진행할 수 있습니다. 
    - **픽업예약** 버튼을 통해 해당 상품을 예약 가능합니다. 📌[JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/basket/basketList.jsp#L85)
    - **선택예약** 버튼을 통해 최대 5개의 상품을 일괄예약 및 결제가 가능합니다. 📌[JSP 코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/webapp/WEB-INF/views/member/myPage/basket/basketList.jsp#L570)
  
</div>
</details>

<br/>

## 6. 핵심 트러블 슈팅

### 6.1. 개발 효율성 향상을 위한 노력

#### 📍 문제점 발견
- 사이트가 가진 대부분의 기능은 로그인 한 회원이 사용할 수 있으므로, 기능 구현 시 Session영역에 저장된 회원정보를 사용할 때가 많았습니다.
- 따라서 프로젝트 내 대부분의 메소드에서 **같은 코드가 중복**되는 것을 발견하였습니다.
 
#### 📍 해결 과정
중복되는 코드를 간결화하고, 간편하게 사용할 수 있는 방법을 고민해보았습니다.

 - **Service클래스 생성**  📌[코드 확인](https://github.com/Jhyeri/shoeketing/blob/main/src/main/java/sk/common/service/CommonService.java)
   - Session영역에 저장된 회원정보 중, 원하는 정보만 골라서 꺼낼 수 있는 메소드를 작성하였습니다.
   - 다른 Service클래스나 Controller에서 함께 사용할 수 있도록 하였습니다. 

#### 📍 결과
- 기존
  -  해당 작업을 위해 동일한 코드를 2~3줄씩 작성해야 했으며, 자주 반복해야 했습니다.
- 현재
  - `예) sessionService.getSession(session, "MEM_NUM")` 와 같이 **한 줄**로 작성합니다.
  - 편리하게 사용할 수 있으며, 동일한 코드 작성이 감소했습니다.


</br>

## 7. 그 외 트러블 슈팅

아래 링크를 통해 더 많은 트러블 슈팅을 확인하실 수 있습니다.<br/><br/>
[**📌 트러블 슈팅 모음**](https://snow-lifter-a27.notion.site/b7fdcc1bdf2b4edc8c95c0b02dc43d47?v=8ff9829cf7eb46bc8a9ac2809c51cc31)
<br/><br/>

<!-- <details>
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
  
 - Controller에서 리턴한 Map타입의 값에 접근하고자 함
   - 그러나 JSP에서 데이터를 찾을 수 없었음
    <details>
    <summary>📌기존코드 펼치기</summary>
    <div markdown="1">
      <img width="60%" src="https://github.com/Jhyeri/shoeketingtmp/assets/111175466/e75f69e6-683b-4424-bd9f-92e2347abbc6"/>
    </div>
    </details>
- **해결방법**
  - Controller에서 "result"라는 이름으로 값을 리턴하였기 때문에 
  - **"data.result"로 수정하여 해결**
     <details>
    <summary>📌개선된 코드 펼치기</summary>
    <div markdown="1">
      <img width="60%" src="https://github.com/Jhyeri/shoeketingtmp/assets/111175466/3a218307-adb6-46d9-91e6-3765cde91a13"/>
    </div>
    </details>
   
</div>
</details>    
-->
