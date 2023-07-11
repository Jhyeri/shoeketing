package sk.common.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("informDAO")
public class InformDAO extends AbstractDAO {
	// 새로운 공지사항이 작성되면 알림 - insert()
	public void insertInform(Map<String, Object> map, String str) throws Exception {

		System.out.println("insertInform 파라미터 : " + map);

		insert("inform.insertInform", map);
	}

	// 알림 리스트 조회(알림 리스트는 페이징 X) - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> informList(Map<String, Object> map) throws Exception {
		System.out.println("informList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("inform.informList", map);
	}

	// 알림 확인 - update()
	public void confirmUpdate(Map<String, Object> map) throws Exception {
		System.out.println("confirmUpdate 파라미터 : " + map);

		update("inform.confirmUpdate", map);
	}

	public int informCount(Map<String, Object> map) throws Exception {
		System.out.println("informCount 파라미터 : " + map);

		return (int) selectOne("inform.informCount", map);
	}
}
