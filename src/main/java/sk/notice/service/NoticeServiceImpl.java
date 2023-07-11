package sk.notice.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import sk.notice.dao.NoticeDAO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	@Resource(name="noticeDAO")
	private NoticeDAO noticeDAO;

	@Override
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception {
		return noticeDAO.selectNoticeList(map);
	}

	@Override
	public int selectNoticeCount(Map<String, Object> map) throws Exception {
		return noticeDAO.selectNoticeCount(map);
	}

	@Override
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception {
		return noticeDAO.selectNoticeDetail(map);
	}
}
