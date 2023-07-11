package sk.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("adminUserDAO")
public class AdminUserDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMemberList(Map<String, Object> map) throws Exception {
		System.out.println("selectMemberList 파라미터" + map);

		return (List<Map<String, Object>>) selectPagingList("adminUser.selectMemberList", map);
	}

	public int selectMemberCount(Map<String, Object> map) throws Exception {
		System.out.println("selectMemberCount 파라미터" + map);

		return (int) selectOne("adminUser.selectMemberCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMemberDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectMemberDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminUser.selectMemberDetail", map);
	}

	public int deleteMember(Map<String, Object> map) throws Exception {
		System.out.println("deleteMember 파라미터" + map);

		return (int) update("adminUser.deleteMember", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectShopList(Map<String, Object> map) throws Exception {
		System.out.println("selectShopList 파라미터" + map);

		return (List<Map<String, Object>>) selectPagingList("adminUser.selectShopList", map);
	}

	public int selectShopCount(Map<String, Object> map) throws Exception {
		System.out.println("selectShopCount 파라미터" + map);

		return (int) selectOne("adminUser.selectShopCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectShopDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectShopDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminUser.selectShopDetail", map);
	}

	public int deleteShop(Map<String, Object> map) throws Exception {
		System.out.println("deleteShop 파라미터" + map);

		return (int) update("adminUser.deleteShop", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBrandList(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandList 파라미터" + map);

		return (List<Map<String, Object>>) selectPagingList("adminUser.selectBrandList", map);
	}

	public int selectBrandCount(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandCount 파라미터" + map);

		return (int) selectOne("adminUser.selectBrandCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBrandDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandDetail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("adminUser.selectBrandDetail", map);
	}

	public int deleteBrand(Map<String, Object> map) throws Exception {
		System.out.println("deleteBrand 파라미터" + map);

		return (int) update("adminUser.deleteBrand", map);
	}
}
