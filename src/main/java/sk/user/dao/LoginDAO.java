package sk.user.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("loginDAO")
public class LoginDAO extends AbstractDAO{
	
	// 로그인 체크
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectId(Map<String, Object> map) throws Exception {
		System.out.println("selectId : " + map);
		return (Map<String, Object>) selectOne("login.selectMemberId", map);
		// 이메일에 해당하는 회원정보를 가져옴
	}
	
	// 아이디찾기
	public String findIdWithPhone(Map<String, Object> map) throws Exception {
		System.out.println("findIdWithPhone : " + map);
		
		return (String) selectOne("login.findIdWithPhone", map);
		// 이름과 생년월일에 해당하는 아이디 가져오기
	}

	// 비밀번호 찾기
	@SuppressWarnings("unchecked")
	public Map<String, Object> findPwWithEmail(Map<String, Object> map) throws Exception {
		System.out.println("findPwWithEmail : " + map);
		return (Map<String, Object>) selectOne("login.findPwWithEmail", map);
		// 이름과 이메일에 해당하는 비밀번호 가져오기
	}
	
	// 재발급한 비밀번호로 업데이트 updatePassword
	public void updatePassword(Map<String, Object> map) throws Exception {
		System.out.println("updatePassword : " + map);
		
		update("login.updatePassword", map);

	}
	
	// 브랜드 로그인
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectIdBrand(Map<String, Object> map) throws Exception {
		System.out.println("selectIdBrand : " + map);
		return (Map<String, Object>) selectOne("login.selectBrandId", map);
	}
	
	// 매장 로그인
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectIdShop(Map<String, Object> map) throws Exception {
		System.out.println("selectIdShop : " + map);
		return (Map<String, Object>) selectOne("login.selectShopId", map);
	}	
}
