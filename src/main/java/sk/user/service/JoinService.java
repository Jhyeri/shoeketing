package sk.user.service;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;


public interface JoinService {

	// 이메일 중복확인
	Map<String, Object> selectEmailCheck(Map<String, Object> map) throws Exception;
	
	
	// 회원탈퇴 후 7일 지났는지 여부 확인
	int selectDelCount(Map<String, Object> map) throws Exception;

	// 회원탈퇴 이력 확인
	int selectDelGB(Map<String, Object> map) throws Exception;
	
	// 회원가입 성공 처리
	void insertMember(Map<String, Object> map) throws Exception;

	// 사업자등록번호 인증
	Map<String, Object> selectbNumAuth(Map<String, Object> map) throws Exception;
	
	// 브랜드 회원가입 처리
	void insertBrand(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception;
	
	// 매장 위치정보 확인
	Map<String, Object> selectshopLocationInfo(Map<String, Object> map) throws Exception;
	
	// 매장 회원가입 처리
	void insertShop(Map<String, Object> map) throws Exception;

	// 폰인증
	void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) throws Exception;

	
}

