package sk.admin.service;

import java.util.List;
import java.util.Map;

public interface AdminUserService {

	List<Map<String, Object>> selectMemberList(Map<String, Object> map) throws Exception;

	int selectMemberCount(Map<String, Object> map) throws Exception;

	Map<String, Object> selectMemberDetail(Map<String, Object> map) throws Exception;

	int deleteMember(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectShopList(Map<String, Object> map) throws Exception;

	int selectShopCount(Map<String, Object> map) throws Exception;

	Map<String, Object> selectShopDetail(Map<String, Object> map) throws Exception;

	int deleteShop(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectBrandList(Map<String, Object> map) throws Exception;

	int selectBrandCount(Map<String, Object> map) throws Exception;

	Map<String, Object> selectBrandDetail(Map<String, Object> map) throws Exception;

	int deleteBrand(Map<String, Object> map) throws Exception;
}
