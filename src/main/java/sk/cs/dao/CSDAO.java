package sk.cs.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("csDAO")
public class CSDAO extends AbstractDAO {
	
	Log log = LogFactory.getLog(this.getClass());

	// 나의 문의 리스트 가져오기
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCSList(Map<String, Object> map) throws Exception {
		System.out.println("selectCSList 파라미터 : " + map);
		return (List<Map<String, Object>>) selectPagingList("cs.selectCSList", map);
	}

	// 나의 문의 개수 가져오기
	public int SelectCSCount(Map<String, Object> map) throws Exception {
		System.out.println("SelectCSCount 파라미터 : " + map);
		return (int) selectOne("cs.selectCSCount", map);
	}

	// 지점 리스트 가져오기
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectShopList(Map<String, Object> map) throws Exception {
		System.out.println("selectShopList 파라미터 : " + map);
		return (List<Map<String, Object>>) selectPagingList("cs.selectShopListSearch", map);
	}
	
	// 지점 총 개수 가져오기
	public int selectShopCount(Map<String, Object> map) throws Exception {
		System.out.println("selectShopCount 파라미터 : " + map);
		return (int) selectOne("cs.selectShopCount", map);
	}

	// 문의글 작성처리
	public void insertCS(Map<String, Object> map) throws Exception {
		System.out.println("insertCS 파라미터 : " + map);
		insert("cs.insertCS", map);
	}
	
	//글 삭제처리
	public void deleteCS(Map<String, Object> map) throws Exception {
		System.out.println("deleteCS 파라미터 : " + map);
		update("cs.deleteCS", map);
	}

	// 매장 문의내역 리스트(10줄) - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectShopCSList(Map<String, Object> map) throws Exception {
		System.out.println("selectShopCSList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectPagingList("cs.selectShopCSList", map);
	}

	// 매장 문의내역 글 토탈 개수 (int 타입으로 리턴) - selectOne()
	public int selectShopCSCount(Map<String, Object> map) throws Exception {
		System.out.println("selectShopCSCount 파라미터 : " + map);

		return (int) selectOne("cs.selectShopCSCount", map);
	}

	// 매장 문의내역 상세보기 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCSDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectCSDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("cs.selectCSDetail", map);
	}

	// 매장 문의내역 댓글 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectCSReply(Map<String, Object> map) throws Exception {
		System.out.println("selectCSReply 파라미터 : " + map);

		return (Map<String, Object>) selectOne("cs.selectCSReply", map);
	}

	// 매장 문의내역 댓글(답변) 작성. 알림 가도록 하는건 Inform쪽에 작성(insertInform)
	public int insertCSReply(Map<String, Object> map) throws Exception {
		System.out.println("insertCSReply 파라미터 : " + map);

		return (int) insert("cs.insertCSReply", map);
	}

}
