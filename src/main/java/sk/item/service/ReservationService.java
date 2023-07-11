package sk.item.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface ReservationService {

	//  나의 픽업 예약 리스트 (일반회원)
	public List<Map<String, Object>> selectPickupList(Map<String, Object> map, HttpSession session) throws Exception;
	
	// 픽업 예약 리스트 토탈개수 (일반회원)
	public int selectPickupCount(Map<String, Object> map, HttpSession session) throws Exception;
	
	// 픽업 예약 상세조회
	public Map<String, Object> selectPickupDetail(Map<String, Object> map) throws Exception;
	
	// 예약 취소. 일반 회원/매장이 예약 대기중인 상태에서 예약 취소 혹은, 매장이 픽업 승인 거부. 이때는 재고변동 X
	public Map<String, Object> deleteReservation(Map<String, Object> map) throws Exception;
	
	// 픽업 대기중. 일반 회원/매장이 픽업 대기중인 상태에서 픽업 예약 취소. 이때는 재고변동 O
	public Map<String, Object> deletePickup(Map<String, Object> map) throws Exception;
	
	// 픽업 취소 후 재고 +1
	public Map<String, Object> updateStockIncrease(Map<String, Object> map) throws Exception;
	
	// 픽업 예약 요청 리스트 (매장)
	public List<Map<String, Object>> selectReservationRequestList(Map<String, Object> map, HttpSession session) throws Exception;
	
	// 해당매장의 총 픽업 예약개수 (매장)
	public int selectReservationCount(Map<String, Object> map, HttpSession session) throws Exception;
	
	// 픽업 예약 승인 (매장)
	public Map<String, Object> updateReservationApprove(Map<String, Object> map) throws Exception;
	
	// 픽업 예약 승인시, 재고 -1 (매장)
	public Map<String, Object> updateStockDecrease(Map<String, Object> map) throws Exception;
	
	// 예약금 결제 성공
	public Map<String, Object> insertReservation(Map<String, Object> map, HttpSession session) throws Exception; 
	
	// 매장이 픽업 완료버튼 클릭시, 픽업 상태변경 + 회원 픽업 횟수 변경
	public Map<String, Object> shopPickUpSuccess(Map<String, Object> map) throws Exception;

	//주문번호 max 조회
	long selectOrderId(Map<String, Object> map) throws Exception;
	
}
