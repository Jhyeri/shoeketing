package sk.notice.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("noticeDAO")
public class NoticeDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {
		System.out.println("selectNoticeList : " + map);
		return (List<Map<String, Object>>) selectPagingList("notice.selectNoticeList", map);
	}

	public int selectNoticeCount(Map<String, Object> map) throws Exception {
		System.out.println("selectNoticeCount : " + map);
		return (int) selectOne("notice.selectNoticeCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) {
		System.out.println("selectNoticeDetail : " + map);
		return (Map<String, Object>) selectOne("notice.selectNoticeDetail", map);
	}
}
