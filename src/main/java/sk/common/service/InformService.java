package sk.common.service;

import java.util.List;
import java.util.Map;

public interface InformService {
	// 새로운 공지사항이 작성되면 알림
	public void insertInform(Map<String, Object> map, String str) throws Exception;

	// 알림 리스트 조회(알림 리스트는 페이징 X)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> informList(Map<String, Object> map) throws Exception;

	// 알림 확인
	public void confirmUpdate(Map<String, Object> map) throws Exception;

	public int informCount(Map<String, Object> map) throws Exception;

}
