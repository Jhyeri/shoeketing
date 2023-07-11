package sk.admin.service;

import java.util.List;
import java.util.Map;

public interface AdminBoardService {

	List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	int selectNoticeCount(Map<String, Object> map) throws Exception;

	int insertNotice(Map<String, Object> map) throws Exception;

	Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception;

	int updateNoticeModify(Map<String, Object> map) throws Exception;

	int adminDeleteNotice(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectTotalGoodsList(Map<String, Object> map) throws Exception;

	int selectTotalGoodsListCount(Map<String, Object> map) throws Exception;

	int adminDeleteGoods(Map<String, Object> map) throws Exception;

	void adminDeleteGoodsImage(Map<String, Object> map) throws Exception;
}
