package sk.myPage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("memberPageDAO")
public class MemberPageDAO extends AbstractDAO {

	// 회원정보 가져오기
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAccountInfo(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("memberPage.selectAccountInfo", map);
	}

	// 회원정보 수정 처리
	public void updateAccountModify(Map<String, Object> map) throws Exception {
		update("memberPage.updateAccountModify", map);
	}

	// 비밀번호 확인 (탈퇴 전)
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectPwCheck(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("memberPage.selectPw", map);
	}

	// 예약상태 확인 (탈퇴 전)
	public int selectReservationStatus(Map<String, Object> map) throws Exception {
		return (int) selectOne("memberPage.selectReservationStatus", map);
	}

	// 회원 탈퇴 처리
	public void deleteAccount(Map<String, Object> map) throws Exception {
		update("memberPage.deleteAccount", map);
	}

	// 찜목록 리스트 가져오기
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsLikeList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectPagingList("memberPage.selectGoodsLikeList", map);
	}

	// 찜목록 개수 가져오기
	public int selectGoodsLikeCount(Map<String, Object> map) throws Exception {
		return (int) selectOne("memberPage.selectGoodsLikeCount", map);
	}
	
	//찜 취소 (delete 처리)
	public void deleteGoodsLike(Map<String, Object> map) throws Exception {
		delete("memberPage.deleteGoodsLike", map);
	}
	
	//찜 취소 시, TOTAL_GOODS_LIKE_COUNT -1 처리
	public void updateGoodsLikeCountDecrease(Map<String, Object> map) throws Exception {
		update("memberPage.updateGoodsLikeCountDecrease", map);
	}
	

}
