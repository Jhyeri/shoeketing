package sk.common.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import sk.common.dao.InformDAO;

@Service("informService")
public class InformServiceImpl implements InformService {

	@Resource(name = "informDAO")
	private InformDAO informDAO;

	// 새로운 공지사항이 작성되면 알림
	@Override
	public void insertInform(Map<String, Object> map, String str) throws Exception {

		informDAO.insertInform(map, str);
	}

	// 알림 리스트 조회(알림 리스트는 페이징 X)
	@Override
	public List<Map<String, Object>> informList(Map<String, Object> map) throws Exception {

		return informDAO.informList(map);
	}

	// 알림 확인
	@Override
	public void confirmUpdate(Map<String, Object> map) throws Exception {

		informDAO.confirmUpdate(map);

	}

	@Override
	public int informCount(Map<String, Object> map) throws Exception {
		return informDAO.informCount(map);
	}

}
