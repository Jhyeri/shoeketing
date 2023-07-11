package sk.user.service;

import java.util.Map;

public interface LoginService {

	Map<String, Object> selectId(Map<String, Object> map) throws Exception;

	Map<String, Object> findPwWithEmail(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectIdBrand(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectIdShop(Map<String, Object> map) throws Exception;

	String findIdWithPhone(String userPhoneNumber, int randomNumber, String MEM_NAME)throws Exception;

}
