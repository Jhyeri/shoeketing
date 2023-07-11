package sk.admin.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import sk.admin.dao.AdminUserDAO;

@Service("adminUserService")
public class AdminUserServiceImpl implements AdminUserService {

	@Resource(name = "adminUserDAO")
	private AdminUserDAO adminUserDAO;

	@Override
	public List<Map<String, Object>> selectMemberList(Map<String, Object> map) throws Exception {

		return adminUserDAO.selectMemberList(map);
	}

	@Override
	public int selectMemberCount(Map<String, Object> map) throws Exception {
		return adminUserDAO.selectMemberCount(map);
	}

	@Override
	public Map<String, Object> selectMemberDetail(Map<String, Object> map) throws Exception {

		return adminUserDAO.selectMemberDetail(map);
	}

	@Override
	public int deleteMember(Map<String, Object> map) throws Exception {
		return adminUserDAO.deleteMember(map);
	}

	@Override
	public List<Map<String, Object>> selectShopList(Map<String, Object> map) throws Exception {

		return adminUserDAO.selectShopList(map);
	}

	@Override
	public int selectShopCount(Map<String, Object> map) throws Exception {
		return adminUserDAO.selectShopCount(map);
	}

	@Override
	public Map<String, Object> selectShopDetail(Map<String, Object> map) throws Exception {

		return adminUserDAO.selectShopDetail(map);
	}

	@Override
	public int deleteShop(Map<String, Object> map) throws Exception {
		return adminUserDAO.deleteShop(map);
	}

	@Override
	public List<Map<String, Object>> selectBrandList(Map<String, Object> map) throws Exception {

		return adminUserDAO.selectBrandList(map);
	}

	@Override
	public int selectBrandCount(Map<String, Object> map) throws Exception {
		return adminUserDAO.selectBrandCount(map);
	}

	@Override
	public Map<String, Object> selectBrandDetail(Map<String, Object> map) throws Exception {

		return adminUserDAO.selectBrandDetail(map);
	}

	@Override
	public int deleteBrand(Map<String, Object> map) throws Exception {
		return adminUserDAO.deleteBrand(map);
	}

}
