package sk.cs.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface CSService {

	//나의 문의 리스트 가져오기
	public List<Map<String, Object>> selectCSList(Map<String, Object> map) throws Exception;
	
	//나의 문의 개수 가져오기
	public int SelectCSCount(Map<String, Object> map) throws Exception;
	 
	//지점 리스트 가져오기
	public List<Map<String, Object>> selectShopList(Map<String, Object> map) throws Exception;	
	
	//지점 총 개수 가져오기
	public int selectShopCount(Map<String, Object> map) throws Exception;
	
	//문의글 작성
	public void insertCS (Map<String, Object> map) throws Exception;
	
	//삭제 처리 추가 예정
	public void deleteCS(Map<String, Object> map) throws Exception;
	
	// 매장 문의내역 리스트(10줄)
	public List<Map<String, Object>> selectShopCSList(Map<String, Object> map, HttpSession session) throws Exception;
	
	// 매장 문의내역 글 토탈 개수 (int 타입으로 리턴)
	public int selectShopCSCount(Map<String, Object> map, HttpSession session) throws Exception;
	
	// 매장 문의내역 상세보기
	public Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception;
	
	// 매장 문의내역 댓글 조회 
	public Map<String, Object> selectCSReply(Map<String, Object> map) throws Exception;
	
	// 매장 문의내역 댓글(답변) 작성. 작성시 해당 회원에게 알림 가도록 알림도 추가필요
	public Map<String, Object> insertCSReply(Map<String, Object> map) throws Exception;
	
	
}
