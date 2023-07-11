package sk.cs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import sk.common.dao.InformDAO;
import sk.common.service.CommonService;
import sk.cs.dao.CSDAO;

@Service("csService")
public class CSServiceImpl implements CSService {

	@Resource(name = "csDAO")
	private CSDAO csDAO;

	@Resource(name = "informDAO")
	private InformDAO informDAO;
	
	@Resource(name = "sessionService")
	private CommonService sessionService;

	// 매장 문의내역 리스트(10줄)
	@Override
	public List<Map<String, Object>> selectShopCSList(Map<String, Object> map, HttpSession session) throws Exception {
		System.out.println("selectShopCSList 서비스 파라미터 : " + map);
		
		map.put("SHOP_NUM", sessionService.getSessionShop(session, "SHOP_NUM"));

		List<Map<String, Object>> shopCSList = csDAO.selectShopCSList(map);

		return shopCSList;
	}

	// 매장 문의내역 글 토탈 개수 (int 타입으로 리턴)
	@Override
	public int selectShopCSCount(Map<String, Object> map, HttpSession session) throws Exception {
		System.out.println("selectShopCSCount 서비스 파라미터 : " + map);
		
		map.put("SHOP_NUM", sessionService.getSessionShop(session, "SHOP_NUM"));
		map.put("START", 1);
		map.put("END", 10);

		int shopCSCount = csDAO.selectShopCSCount(map);

		return shopCSCount;
	}

	// 매장 문의내역 상세보기
	@Override
	public Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectCSDetail 서비스 파라미터 : " + map);
		
		map.put("CS_NUM", map.get("CS_NUM"));

		Map<String, Object> csDetailMap = csDAO.selectCSDetail(map);
		
		return csDAO.selectCSDetail(map);
	}

	// 매장 문의내역 댓글 조회
	@Override
	public Map<String, Object> selectCSReply(Map<String, Object> map) throws Exception {

		map.put("CS_NUM", map.get("CS_NUM"));

		return csDAO.selectCSReply(map);
	}

	// 매장 문의내역 댓글(답변) 작성. 작성시 해당 회원에게 알림 가도록 알림도 추가필요
	@Override
	public Map<String, Object> insertCSReply(Map<String, Object> map) throws Exception {
		System.out.println("insertCSReply 서비스 파라미터 : " + map);

		map.put("CS_REPLY_NUM", map.get("CS_REPLY_NUM")); 
		map.put("CS_REPLY_CONTENT", map.get("CS_REPLY_CONTENT")); 

		// 문의 댓글 작성결과 insertReplyResult에 저장
		int insertReply = csDAO.insertCSReply(map);

		Map<String, Object> insertReplyResult = new HashMap<String, Object>();

		// 추후 ajax로 구현
		if (insertReply == 1) {
			insertReplyResult.put("result", "pass");
		} else {
			insertReplyResult.put("result", "fail");
		}

		// 문의 댓글 작성시, 회원에게 알림
		String str = "문의하신 글에 답변이 달렸습니다.";
		map.put("INFORM_CONTENT", str);
		//map.put("MEM_NUM", 2); // 추후 ajax로 해당 회원 MEM_NUM 보내주기,, 추후 수정!
		map.put("INFORM_TYPE", 3); // 문의글 답변 작성시 알림유형3

		informDAO.insertInform(map, str);

		System.out.println("map 확인 : " + map);

		return insertReplyResult;
	}

	// 나의 문의 내역
	@Override
	public List<Map<String, Object>> selectCSList(Map<String, Object> map) throws Exception {
		System.out.println("selectCSList 서비스 파라미터 : " + map);
		return csDAO.selectCSList(map);
	}
	
	
	//나의 문의 삭제
	@Override
	public void deleteCS(Map<String, Object> map) throws Exception {
		System.out.println("deleteCS 서비스 파라미터 : " + map);
		csDAO.deleteCS(map);
		
	}

	// 문의 개수
	@Override
	public int SelectCSCount(Map<String, Object> map) throws Exception {
		System.out.println("SelectCSCount 서비스 파라미터 : " + map);
		return csDAO.SelectCSCount(map);
	}

	
	// 문의할 매장찾기 지점 리스트
	@Override
	public List<Map<String, Object>> selectShopList(Map<String, Object> map) throws Exception {
		System.out.println("selectShopList 서비스 파라미터 : " + map);
		return csDAO.selectShopList(map);
	}

	// 지점 총 개수
	@Override
	public int selectShopCount(Map<String, Object> map) throws Exception {
		System.out.println("selectShopCount 서비스 파라미터 : " + map);
		return csDAO.selectShopCount(map);
	}

	// 문의 작성하기
	@Override
	public void insertCS(Map<String, Object> map) throws Exception {
		System.out.println("insertCS 서비스 파라미터 : " + map);
		csDAO.insertCS(map);
	}

}
