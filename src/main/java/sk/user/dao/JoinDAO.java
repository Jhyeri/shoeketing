package sk.user.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("joinDAO")
public class JoinDAO extends AbstractDAO {

	// 이메일 중복체크
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectEmailCheck(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("join.selectEmailCheck", map);
	}

	

	public int selectDelCount(Map<String, Object> map) throws Exception {
		return (int) selectOne("join.selectDelCount", map);
	}

	public int selectDelGB(Map<String, Object> map) throws Exception {
		return (int) selectOne("join.selectDelGB", map);
	}

	// 회원가입 성공
	public void insertMember(Map<String, Object> map) throws Exception {
		insert("join.insertMember", map);
	}

	// 폰 인증
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectbNumAuth(Map<String, Object> map) {

		return (Map<String, Object>) selectOne("join.selectbNumAuth", map);
	}

	// 브랜드 회원가입 성공
	public void insertBrand(Map<String, Object> map) throws Exception {
		insert("join.insertBrand", map);
	}

	// 매장 위치정보 확인
	public Map<String, Object> selectshopLocationInfo(Map<String, Object> map) {

		return (Map<String, Object>) selectOne("join.selectshopLocationInfo", map);
	}

	// 매장 회원가입 성공
	public int insertShop(Map<String, Object> map) throws Exception {
		return (int) insert("join.insertShop", map);
	}

}