package sk.item.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.item.service.ReservationService;

@RestController
public class ReservationController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "reservationService")
	private ReservationService reservationService;
	
	@Resource(name="sessionService")
	private CommonService commonService;
	
	@GetMapping(value = "/myPage/reservationList")
	public ModelAndView reservationList(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 내가 픽업 예약한 리스트 ######");
		ModelAndView mv = new ModelAndView("reservationList");
		
//		List<Map<String, Object>> pickupList = reservationService.selectPickupList(map, session);
//		int pickupCount = reservationService.selectPickupCount(map, session);
//		
//		mv.addObject("pickupList", pickupList);
//		mv.addObject("pickupCount", pickupCount);
		
		return mv;
	}
	
	@PostMapping(value = "/myPage/reservationList/paging")
	public ModelAndView reservationList_paging(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 내가 픽업 예약한 리스트 ######");
		ModelAndView mv = new ModelAndView("jsonView");
		
		List<Map<String, Object>> pickupList = reservationService.selectPickupList(map, session);
		mv.addObject("pickupList", pickupList);
		
		if (pickupList.size() > 0) {
			int pickupCount = reservationService.selectPickupCount(map, session); // 픽업 예약 토탈 개수
			System.out.println("pickupCount 확인 : " + pickupCount); 
			mv.addObject("TOTAL", pickupCount);
		} else {
			mv.addObject("TOTAL", 0);
		}
		
		return mv;
	}

	@GetMapping(value = "/myPage/reservationDetail")
	public ModelAndView reservationDetail(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 픽업 예약 상세보기 ######");
		ModelAndView mv = new ModelAndView("reservationDetail");
		System.out.println("map확인: " + map);
		Map<String, Object> pickupDetailMap = reservationService.selectPickupDetail(map);
		
		mv.addObject("pickupDetailMap", pickupDetailMap);
		
		return mv;
	}
	
	//TossPaymentsController에 구현 (reservationCancel() 메서드)
//	@PostMapping(value = "/myPage/reservationDelete")
//	public Map<String, Object> reservationDelete(@RequestParam Map<String, Object> map) throws Exception {
//		log.debug("###### 픽업 예약 취소 ######");
//		System.out.println("map 확인 : " + map);
//		
//		Map<String, Object> result = new HashMap<>();
//		
//		// 픽업 상태가 "예약 대기중"일 경우
//		if(map.get("RESERVATION_STATUS").toString().equals("예약 대기중")){
//			result = reservationService.deleteReservation(map);
//		}
//		
//		// 픽업 상태가 "픽업 대기중"일 경우
//		if(map.get("RESERVATION_STATUS").toString().equals("픽업 대기중")){
//			result = reservationService.deletePickup(map);
//		}
//		
//		Map<String, Object> detailMap = reservationService.selectPickupDetail(map);
//		result.put("RESERVATION_STATUS", detailMap.get("RESERVATION_STATUS"));
//		
//		return result;
//	}

	@GetMapping(value = "/shopPage/reservationList")
	public ModelAndView shopReservationList(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 매장 픽업 예약 요청 리스트 ######");
		ModelAndView mv = new ModelAndView("reservationRequestList"); 

//		List<Map<String, Object>> reservaionList = reservationService.selectReservationRequestList(map, session);
//		int reservationCount = reservationService.selectReservationCount(map, session);
//		System.out.println("reservationList 확인 : " + reservaionList);
//		System.out.println("reservationCount 확인 : " + reservationCount);
//		
//		mv.addObject("reservationList", reservaionList);
	
		return mv;
	}
	
	@PostMapping(value = "/shopPage/reservationList/paging")
	public ModelAndView shopReservationList_paging(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 매장 픽업 예약 요청 리스트 ######");
		ModelAndView mv = new ModelAndView("jsonView"); 

		List<Map<String, Object>> reservationList = reservationService.selectReservationRequestList(map, session);
		System.out.println("reservationList 확인 : " + reservationList);
		mv.addObject("reservationList", reservationList);

		if (reservationList.size() > 0) {
			int reservationCount = reservationService.selectReservationCount(map, session); // 픽업 예약 요청 토탈 개수
			System.out.println("reservationCount 확인 : " + reservationCount); 
			mv.addObject("TOTAL", reservationCount);
		} else {
			mv.addObject("TOTAL", 0);
		}
		
		return mv;
	}

	// Ajax
	@ResponseBody
	@PostMapping(value = "/shopPage/reservationApprove")
	public Map<String, Object> shopReservationApprove(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 픽업 예약 승인 ######");

		Map<String, Object> resultMap = reservationService.updateReservationApprove(map);
		
		// 예약 승인한 후, ajax를 사용해 '픽업 대기중'으로 변경해주기 위해 resultMap에 상태 put 
		Map<String, Object> detailMap = reservationService.selectPickupDetail(map);
		resultMap.put("RESERVATION_STATUS", detailMap.get("RESERVATION_STATUS"));
		
		System.out.println("resultMap 확인 : " + resultMap);
		
		return resultMap;
	}
	
	// Ajax
	@ResponseBody
	@PostMapping(value = "/shopPage/pickUpSuccess")
	public Map<String, Object> shopPickUpSuccess(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 픽업 완료 (회원 픽업 O) ######");
		
		// 픽업 완료 버튼 클릭시, 픽업 상태 변경 + 회원 픽업 횟수 변경
		Map<String, Object> resultMap = reservationService.shopPickUpSuccess(map);
		
		// 픽업 예약 상태 '픽업 완료'로 변경
		Map<String, Object> detailMap = reservationService.selectPickupDetail(map);
		resultMap.put("RESERVATION_STATUS", detailMap.get("RESERVATION_STATUS"));
		
		System.out.println("resultMap 확인 : " + resultMap);
		
		return resultMap;
	}
	

	// TossPaymentsController_reservationCancel()
	// Ajax
//	@ResponseBody
//	@PostMapping(value = "/shopPage/reservationCancel")
//	public Map<String, Object> shopReservationCancel(@RequestParam Map<String, Object> map) throws Exception {
//		log.debug("###### 매장 픽업 취소 ######");
//		
//		Map<String, Object> resultMap = new HashMap<>();
//		
//		map.put("RESERVATION_NUM", map.get("RESERVATION_NUM"));
//		map.put("RESERVATION_STATUS", map.get("RESERVATION_STATUS"));
//		
//		// 픽업 상태가 "예약 대기중"일 경우 (재고변동 X)_예약 거부
//		if(map.get("RESERVATION_STATUS").toString().equals("예약 대기중")){
//			resultMap = reservationService.deleteReservation(map);
//		}
//		
//		// 픽업 상태가 "픽업 대기중"일 경우 (재고 +1)_픽업 취소
//		if(map.get("RESERVATION_STATUS").toString().equals("픽업 대기중")){
//			resultMap = reservationService.deletePickup(map);
//		}
//		
//		Map<String, Object> detailMap = reservationService.selectPickupDetail(map);
//		resultMap.put("RESERVATION_STATUS", detailMap.get("RESERVATION_STATUS"));
//		
//		return resultMap;
//
//	}

	// 토스 페이먼츠 api (TossPaymentsController)
//	@GetMapping(value = "/reservationForm")
//	public ModelAndView reservationForm(Map<String, Object> map) throws Exception {
//		log.debug("###### 상품 픽업 예약 폼 ######");
//		ModelAndView mv = new ModelAndView("testMain"); // 추후 수정
//
//		return mv;
//	}
//
//	@GetMapping(value = "/makeReservation")
//	public ModelAndView makeReservation(Map<String, Object> map) throws Exception {
//		log.debug("###### 픽업 예약금 결제 ######");
//		ModelAndView mv = new ModelAndView("testMain"); // 추후 수정
//
//		return mv;
//	}
//
//	@GetMapping(value = "/reservationSuccess")
//	public ModelAndView reservationSuccess(Map<String, Object> map) throws Exception {
//		log.debug("###### 픽업 예약금 결제 성공 ######");
//		ModelAndView mv = new ModelAndView("testMain"); // 추후 수정
//
//		return mv;
//	}

}
