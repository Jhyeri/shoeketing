package sk.item.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("reservationDAO")
public class ReservationDAO extends AbstractDAO {

	// 나의 픽업 예약 리스트 (일반회원)
	// selectPickupList
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPickupList(Map<String, Object> map) throws Exception {
		System.out.println("selectPickupList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectPagingList("reservation.selectPickupList", map);
	}

	// 픽업 예약 리스트 토탈개수 (일반회원)
	// selectPickupCount
	public int selectPickupCount(Map<String, Object> map) throws Exception {
		System.out.println("selectPickupCount 파라미터 : " + map);

		return (int) selectOne("reservation.selectPickupCount", map);
	}

	// 픽업 예약 상세조회
	// selectPickupDetail
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPickupDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectPickupDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("reservation.selectPickupDetail", map);
	}

	// 예약 취소. 일반 회원/매장이 예약 대기중인 상태에서 예약 취소 혹은, 매장이 픽업 승인 거부. 이때는 재고변동 X
	// deleteReservation
	public int deleteReservation(Map<String, Object> map) throws Exception {
		System.out.println("deleteReservation 파라미터 : " + map);

		return (int) update("reservation.deleteReservation", map);
	}

	// 픽업 대기중. 일반 회원/매장이 픽업 대기중인 상태에서 픽업 예약 취소. 이때는 재고변동 O
	// deletePickup
	public int deletePickup(Map<String, Object> map) throws Exception {
		System.out.println("deletePickup 파라미터 : " + map);

		return (int) update("reservation.deletePickup", map);
	}

	// 픽업 취소 후 재고 +1
	// updateStockIncrease
	public int updateStockIncrease(Map<String, Object> map) throws Exception {
		System.out.println("updateStockIncrease 파라미터 : " + map);

		return (int) update("reservation.updateStockIncrease", map);
	}

	// 픽업 예약 요청 리스트 (매장)
	// selectReservationRequestList
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReservationRequestList(Map<String, Object> map) throws Exception {
		System.out.println("selectReservationRequestList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectPagingList("reservation.selectReservationRequestList", map);
	}

	// 해당매장의 총 픽업 예약개수 (매장)
	// selectReservationCount
	public int selectReservationCount(Map<String, Object> map) throws Exception {
		System.out.println("selectReservationCount 파라미터 : " + map);

		return (int) selectOne("reservation.selectReservationCount", map);
	}

	// 픽업 예약 승인 (매장)
	// updateReservationApprove
	public int updateReservationApprove(Map<String, Object> map) throws Exception {
		System.out.println("updateReservationApprove 파라미터 : " + map);

		return (int) update("reservation.updateReservationApprove", map);
	}

	// 픽업 예약 승인시, 재고 -1 (매장)
	// updateStockDecrease
	public int updateStockDecrease(Map<String, Object> map) throws Exception {
		System.out.println("updateStockDecrease 파라미터 : " + map);

		return (int) update("reservation.updateStockDecrease", map);
	}

	// 예약금 결제 성공
	// insertReservation
	public int insertReservation(Map<String, Object> map) throws Exception {
		System.out.println("insertReservation 파라미터 : " + map);

		return (int) insert("reservation.insertReservation", map);
	}

	// orderId 가져오기
	// selectOrderId
	public long selectOrderId(Map<String, Object> map) throws Exception {
		System.out.println("selectOrderId 파라미터 : " + map);

		return (long) selectOne("reservation.selectOrderId", map);
	}

	// 매장이 픽업 완료버튼 클릭시, 픽업 상태변경
	public int updateReservationStatusAfterPickUp(Map<String, Object> map) throws Exception {
		System.out.println("updateReservationStatusAfterPickUp 파라미터 : " + map);

		return (int) update("reservation.updateReservationStatusAfterPickUp", map);
	}

	// 매장이 픽업 완료버튼 클릭시, 회원 픽업 횟수 변경
	public int updateMemberPickupCountAfterPickUp(Map<String, Object> map) throws Exception {
		System.out.println("updateMemberPickupCountAfterPickUp 파라미터 : " + map);

		return (int) update("reservation.updateMemberPickupCountAfterPickUp", map);
	}

}
