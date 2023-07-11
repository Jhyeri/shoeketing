package sk.item.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.item.service.ReservationService;

@Controller
public class TossPaymentsController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "reservationService")
	private ReservationService reservationService;
	
	@Resource(name = "sessionService")
	private CommonService sessionService;
	
	
	List<Map<String, Object>> reserveGoodsList = new ArrayList<>(); 

	
	// 픽업 예약금 결제는 실시간 재고 검색 폼 - 픽업예약 모달창에서 진행 (stockSearchForm.jsp)
	
	@GetMapping(value = "/tossPaymentsSuccess")
	public ModelAndView reservationSuccess(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 픽업 예약금 결제 성공 ######");
	
		ModelAndView mv = new ModelAndView("redirect:/tossPaymentsApprove");   // 픽업 예약금 결제 승인으로 리다이렉트
		
		mv.addObject("pickupDate", map.get("pickupDate"));
		mv.addObject("goodsNum", map.get("goodsNum"));
		mv.addObject("shopNum", map.get("shopNum"));
		mv.addObject("goodsSize", map.get("goodsSize"));
		mv.addObject("paymentKey",  map.get("paymentKey"));
		mv.addObject("orderId", map.get("orderId"));
	
		return mv;
	}
	
	//여러개 결제
	@RequestMapping(method= {RequestMethod.POST, RequestMethod.GET}, value = "/getGoodsInfo")
	public ModelAndView receiveGoodsInfo(@RequestBody List<Map<String, Object>> list, HttpSession session) throws Exception {
		log.debug("###### 결제 생성 전 상품정보 받기 ######");
		ModelAndView mv = new ModelAndView("jsonView");
		
		System.out.println("getGoodsInfo 파라미터 : " + list);
		
		if(!list.isEmpty()) {
			for(int i=0; i<list.size(); i++) {
				System.out.println("list : " + list.get(i));
				reserveGoodsList.add(list.get(i));
				System.out.println("reserveGoodsList : " + reserveGoodsList.get(i));
			}
		}
		
		return mv;
		
	}
	
	
	//여러개 예약일 때
	@GetMapping(value = "/tossPaymentsSuccessBundle")
	public ModelAndView reservationSuccess(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 여러개 픽업 예약금 결제 성공 ######");
		
		ModelAndView mv = new ModelAndView("redirect:/tossPaymentsApproveBundle");   // 픽업 예약금 결제 승인으로 리다이렉트
		
		System.out.println("successBundle 파라미터 map : " + map);
		
    
	      
	    mv.addObject("paymentKey",  map.get("paymentKey"));
	    mv.addObject("orderId",  map.get("orderId"));
	    mv.addObject("amount",  map.get("amount"));
	    
	    
		return mv;
	}
	
	@GetMapping(value = "/tossPaymentsApprove")
	public ModelAndView reservationApprove(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 픽업 예약금 결제 승인 / 픽업 예약 리스트 이동 ######");
		ModelAndView mv = new ModelAndView("reservationList");  // 결제 승인 완료 후, 픽업 예약 리스트로 이동
		
		// 로그인 한 회원 정보 세션에서 가져와서 map에 넣어주기
		map.put("RESERVATION_USER", sessionService.getSession(session, "MEM_NUM"));
		map.put("RESERVATION_PHONE", sessionService.getSession(session, "MEM_PHONE"));

		// 픽업 예약 관련 파라미터들 map에 넣어주기
		map.put("RESERVATION_PICKUP_DATE", map.get("pickupDate"));
		map.put("RESERVATION_PRONUM", map.get("goodsNum"));
		map.put("RESERVATION_SHOP_NUM", map.get("shopNum"));
		map.put("RESERVATION_SIZE", map.get("goodsSize"));
		
		mv.addObject("paymentKey", map.get("paymentKey"));
		mv.addObject("orderId", map.get("orderId"));
		
		System.out.println("session mem_grade 확인 : " + sessionService.getSession(session, "MEM_GRADE"));
		
		int amount = 0;
		// 등급별 픽업 예약금
		if(sessionService.getSession(session, "MEM_GRADE").equals("골드")) {
			amount = 30000;
		} else if(sessionService.getSession(session, "MEM_GRADE").equals("플래티넘")) {
			amount = 27000;
		} else if(sessionService.getSession(session, "MEM_GRADE").equals("다이아")) {
			amount = 25000;
		}
		
		log.debug("paymentKey 확인 :" + map.get("paymentKey"));
		
		// 결제 승인시 연결할 웹페이지 url
		String apiURL = "https://api.tosspayments.com/v1/payments/confirm";
		System.out.println(apiURL);
		
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection(); // url 연결

			con.setRequestMethod("POST");
			con.setDoOutput(true); // OutputStream으로 POST 데이터 넘겨주기 위해 true로 지정
			con.setRequestProperty("Authorization", "Basic dGVzdF9za19xTGxESmFZbmdyb0FOZEc2bFpYM2V6R2RScFh4Og=="); 
			con.setRequestProperty("Content-Type", "application/json");

			StringBuilder sb = new StringBuilder();

			// append() 사용해 문자열 더하기 (보내줄 파라미터들 한줄로 묶기)
			sb.append("{\"paymentKey\":" + "\"" + map.get("paymentKey") + "\",");
			sb.append("\"orderId\":" + "\"" + map.get("orderId") + "\",");
			sb.append("\"amount\":" + amount + "}");

			OutputStream os = con.getOutputStream();
			OutputStreamWriter writer = new OutputStreamWriter(os);

			writer.write(sb.toString()); // sb 객체 String으로 변경해서, 파라미터 보내기
			writer.flush();
			writer.close();

			System.out.println("sb.toString() : " + sb.toString());
			os.close();
			con.connect();

			// 버퍼 이용해서 읽기위해 객체선언 (readLine():입력 값으로 들어온 데이터를 한 줄로 읽어 String으로 바꿔줌)
			BufferedReader br;
			int responseCode = con.getResponseCode(); // 응답코드 받아서 responseCode에 저장
			System.out.println("responseCode=" + responseCode);

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생 (응답코드 200 아님)
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String inputLine;
			StringBuffer res = new StringBuffer();

			// 입력 값으로 들어온 데이터를 String으로 변경해 inputLine에 저장해주고, 이 값이 null이 아니면
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine); // StringBuffer객체에 더해주기
			}
			
			System.out.println("res : " + res);
			
			br.close();

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)

				// insertReservation 호출 (추후 실시간 재고검색 기능 구현후 주석 풀기)
				// 예약 insert 하는 과정
				Map<String, Object> reservationResult = reservationService.insertReservation(map, session);
				System.out.println("reservationResult 결과 : " + reservationResult);
				
				// 픽업 예약 리스트 가져와서 보여주기
				List<Map<String, Object>> pickupList = reservationService.selectPickupList(map, session);
				int pickupCount = reservationService.selectPickupCount(map, session);
				
				mv.addObject("pickupList", pickupList);
				mv.addObject("pickupCount", pickupCount);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return mv;
	}
	
	//여러개 결제 승인
	@GetMapping(value = "/tossPaymentsApproveBundle")
	public ModelAndView reservationApproveBundle(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 여러개 픽업 예약금 결제 승인 / 픽업 예약 리스트 이동 ######");
		ModelAndView mv = new ModelAndView("reservationList");  // 결제 승인 완료 후, 픽업 예약 리스트로 이동
		
		System.out.println("session mem_grade 확인 : " + sessionService.getSession(session, "MEM_GRADE"));
		
		log.debug("paymentKey 확인 :" + map.get("paymentKey"));
		
		// 결제 승인시 연결할 웹페이지 url
		String apiURL = "https://api.tosspayments.com/v1/payments/confirm";
		System.out.println(apiURL);
		
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection(); // url 연결
			
			con.setRequestMethod("POST");
			con.setDoOutput(true); // OutputStream으로 POST 데이터 넘겨주기 위해 true로 지정
			con.setRequestProperty("Authorization", "Basic dGVzdF9za19xTGxESmFZbmdyb0FOZEc2bFpYM2V6R2RScFh4Og=="); 
			con.setRequestProperty("Content-Type", "application/json");
			
			StringBuilder sb = new StringBuilder();
			
			// append() 사용해 문자열 더하기 (보내줄 파라미터들 한줄로 묶기)
			sb.append("{\"paymentKey\":" + "\"" + map.get("paymentKey") + "\",");
			sb.append("\"orderId\":" + "\"" + map.get("orderId") + "\",");
			sb.append("\"amount\":" + map.get("amount") + "}");
			
			OutputStream os = con.getOutputStream();
			OutputStreamWriter writer = new OutputStreamWriter(os);
			
			writer.write(sb.toString()); // sb 객체 String으로 변경해서, 파라미터 보내기
			writer.flush();
			writer.close();
			
			System.out.println("sb.toString() : " + sb.toString());
			os.close();
			con.connect();
			
			// 버퍼 이용해서 읽기위해 객체선언 (readLine():입력 값으로 들어온 데이터를 한 줄로 읽어 String으로 바꿔줌)
			BufferedReader br;
			int responseCode = con.getResponseCode(); // 응답코드 받아서 responseCode에 저장
			System.out.println("responseCode=" + responseCode);
			
			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생 (응답코드 200 아님)
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			
			String inputLine;
			StringBuffer res = new StringBuffer();
			
			// 입력 값으로 들어온 데이터를 String으로 변경해 inputLine에 저장해주고, 이 값이 null이 아니면
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine); // StringBuffer객체에 더해주기
			}
			
			System.out.println("res : " + res);
			
			br.close();
			
			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				
				Map<String, Object> finalMap = new HashMap<>();
				Map<Object, Object> orderIdMap = new HashMap<>();
				List<String> orderIdList = new ArrayList<>();
				
				for(int i=0; i<reserveGoodsList.size(); i++) {
					
					//list에 있는 map의 데이터를 차례대로 map에 저장
					finalMap = (Map<String, Object>)reserveGoodsList.get(i);
					
					// 로그인 한 회원 정보 세션에서 가져와서 finalMap에 넣어주기
					map.put("RESERVATION_USER", sessionService.getSession(session, "MEM_NUM"));
					map.put("RESERVATION_PHONE", sessionService.getSession(session, "MEM_PHONE"));
					
					System.out.println("finalMap 출력 : " + finalMap);
				
					map.put("RESERVATION_PICKUP_DATE", finalMap.get("pickupDate"));
					map.put("RESERVATION_PRONUM", finalMap.get("goodsNum"));
					map.put("RESERVATION_SHOP_NUM", finalMap.get("shopNum"));
					map.put("RESERVATION_SIZE", finalMap.get("goodsSize"));
//					mv.addObject("orderId", map.get("orderId"));
					
					// insertReservation 호출 (추후 실시간 재고검색 기능 구현후 주석 풀기)
					// 예약 insert 하는 과정
					Map<String, Object> reservationResult = reservationService.insertReservation(map, session);
					
					
//					orderIdMap.put("orderId", reservationResult.get("RESERVATION_NUM"));
					//max 주문번호 가져오기
					String maxOrderId = String.valueOf(reservationService.selectOrderId(map));
//					orderIdMap.put("orderId"+i, maxOrderId);
//					mv.addObject("orderId"+i, maxOrderId);
					orderIdList.add(maxOrderId);
					
					System.out.println("reservationResult 결과 : " + reservationResult);
					
				}
				System.out.println("orderIdList : " + orderIdList);
				
				mv.addObject("paymentKey", map.get("paymentKey"));
				
				//리스트 비우기
				reserveGoodsList.clear();
				
				// 픽업 예약 리스트 가져와서 보여주기
				List<Map<String, Object>> pickupList = reservationService.selectPickupList(map, session);
				int pickupCount = reservationService.selectPickupCount(map, session);
				
				mv.addObject("pickupList", pickupList);
				mv.addObject("pickupCount", pickupCount);
				mv.addObject("orderIdList", orderIdList);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return mv;
	}
	
	
	@ResponseBody
	@PostMapping(value = "/tossPaymentsCancel")
	public Map<String, Object> reservationCancel(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 픽업 예약금 결제 취소 ######");
		log.debug("map 확인 : " + map);
		
		int cancelAmount = 0;
		
		// 등급별 픽업 예약금
		if(sessionService.getSession(session, "MEM_GRADE").equals("골드")) {
			cancelAmount = 30000;
		} else if(sessionService.getSession(session, "MEM_GRADE").equals("플래티넘")) {
			cancelAmount = 27000;
		} else if(sessionService.getSession(session, "MEM_GRADE").equals("다이아")) {
			cancelAmount = 25000;
		}
		
		// Request)
		String paymentKey = map.get("paymentKey").toString();
		String cancelReason = "고객이 취소를 원함";
		
		log.debug("paymentKey 확인 :" + paymentKey);
		
		// 결제 취소시 연결할 웹페이지 url
		String apiURL = "https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel";
		System.out.println(apiURL);
		
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection(); // url 연결

			con.setRequestMethod("POST");
			con.setDoOutput(true); // OutputStream으로 POST 데이터 넘겨주기 위해 true로 지정
			con.setRequestProperty("Authorization", "Basic dGVzdF9za19xTGxESmFZbmdyb0FOZEc2bFpYM2V6R2RScFh4Og=="); 
			con.setRequestProperty("Content-Type", "application/json");

			StringBuilder sb = new StringBuilder();

			// append() 사용해 문자열 더하기 (보내줄 파라미터들 한줄로 묶기)
			sb.append("{\"cancelReason\":" + "\"" + cancelReason + "\",");
			sb.append("\"cancelAmount\":" + "\"" + cancelAmount + "\"}");

			OutputStream os = con.getOutputStream();
			OutputStreamWriter writer = new OutputStreamWriter(os);

			writer.write(sb.toString()); // sb 객체 String으로 변경해서, 파라미터 보내기
			writer.flush();
			writer.close();

			System.out.println("sb.toString() : " + sb.toString());
			os.close();
			con.connect();

			// 버퍼 이용해서 읽기위해 객체선언 (readLine():입력 값으로 들어온 데이터를 한 줄로 읽어 String으로 바꿔줌)
			BufferedReader br;
			int responseCode = con.getResponseCode(); // 응답코드 받아서 responseCode에 저장
			System.out.println("responseCode=" + responseCode);

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생 (응답코드 200 아님)
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}

			String inputLine;
			StringBuffer res = new StringBuffer();

			// 입력 값으로 들어온 데이터를 String으로 변경해 inputLine에 저장해주고, 이 값이 null이 아니면
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine); // StringBuffer객체에 더해주기
			}
			
			System.out.println("res : " + res);
			
			br.close();

			if (responseCode == 200) { // 정상 호출일 경우 (응답코드 200)
				Map<String, Object> resultMap = new HashMap<>();
				
				// 픽업 상태가 "예약 대기중"일 경우 (재고변동 X)_예약 거부
				if(map.get("RESERVATION_STATUS").toString().equals("예약 대기중")){
					resultMap = reservationService.deleteReservation(map);
				}
				
				// 픽업 상태가 "픽업 대기중"일 경우 (재고 +1)_픽업 취소
				if(map.get("RESERVATION_STATUS").toString().equals("픽업 대기중")){
					resultMap = reservationService.deletePickup(map);
				}
				
				Map<String, Object> detailMap = reservationService.selectPickupDetail(map);
				resultMap.put("RESERVATION_STATUS", detailMap.get("RESERVATION_STATUS"));

				return resultMap;

			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return null;
	}
}
