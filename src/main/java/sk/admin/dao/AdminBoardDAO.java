package sk.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("adminBoardDAO")
public class AdminBoardDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {
		System.out.println("selectNoticeList 파라미터" + map);

		return (List<Map<String, Object>>) selectPagingList("adminBoard.selectNoticeList", map);
	}

	public int selectNoticeCount(Map<String, Object> map) throws Exception {
		System.out.println("selectNoticeList 파라미터" + map);

		return (int) selectOne("adminBoard.selectNoticeCount", map);
	}

	public int insertNotice(Map<String, Object> map) throws Exception {
		System.out.println("insertNotice 파라미터 : " + map);

		return (int) insert("adminBoard.insertNotice", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectReportDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminBoard.selectNoticeDetail", map);
	}

	public int updateNoticeModify(Map<String, Object> map) throws Exception {
		System.out.println("updateNoticeModify 파라미터 : " + map);

		return (int) update("adminBoard.updateNoticeModify", map);
	}

	public int deleteNotice(Map<String, Object> map) throws Exception {
		System.out.println("deleteNotice 파라미터 : " + map);

		return (int) update("adminBoard.deleteNotice", map);
	}

	public int adminDeleteGoods(Map<String, Object> map) throws Exception {
		System.out.println("adminDeleteNotice 파라미터 : " + map);

		return (int) update("adminBoard.deleteGoods", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectTotalGoodsList(Map<String, Object> map) throws Exception {
		System.out.println("selectTotalGoodsList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectPagingList("adminBoard.selectTotalGoodsList", map);
	}

	public int selectTotalGoodsListCount(Map<String, Object> map) throws Exception {
		System.out.println("selectTotalGoodsListCount 파라미터 : " + map);

		return (int) selectOne("adminBoard.selectTotalGoodsListCount", map);
	}

	public int adminDeleteGoodsImage(Map<String, Object> map) throws Exception {
		System.out.println("adminDeleteGoodsImage 파라미터 : " + map);

		return (int) update("adminBoard.deleteGoodsImage", map);
	}

}
