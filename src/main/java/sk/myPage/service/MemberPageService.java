package sk.myPage.service;

import java.util.List;
import java.util.Map;

public interface MemberPageService {

	//회원정보 가져오기
	Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception;
	 
	//회원정보수정
	void accountModify(Map<String, Object> map) throws Exception;
	
	//비밀번호 확인
	Map<String, Object> pwCheck(Map<String, Object> map) throws Exception;
	
	//예약상태 확인
	int selectReservationStatus(Map<String, Object> map) throws Exception;
	
	//회원 탈퇴처리(N->Y)
	void deleteAccount(Map<String, Object> map) throws Exception;
	 
	//찜목록 리스트
	List<Map<String, Object>> goodsLikeList(Map<String, Object> map) throws Exception;
	
	//찜목록 개수
	int goodsLikeCount(Map<String, Object> map) throws Exception;

	//찜 취소
	public void deleteGoodsLike(Map<String, Object> map) throws Exception;

	//찜 취소 시 TOTAL_GOODS테이블의 TOTAL_LIKE_COUNT -1처리
	public void updateGoodsLikeCountDecrease(Map<String, Object> map) throws Exception;
}
