package sk.notice.service;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) throws Exception;

	int selectNoticeCount(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> selectNoticeDetail(Map<String, Object> map) throws Exception;

}
