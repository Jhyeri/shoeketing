package sk.myPage.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface ShopPageService {
	
	// 매장 기본정보 조회
	public Map<String, Object> selectShopInfo(Map<String, Object> map) throws Exception;
	
	// 매장의 해당 브랜드 로고 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBrandLogoFileOfShop(Map<String, Object> map, HttpSession session) throws Exception;
	
	// 매장 기본정보 수정 
	public Map<String, Object> updateShopInfo(Map<String, Object> map) throws Exception;
	
	// 매장별 재고수량 조회 
	public int selectGoodsAmount(Map<String, Object> map) throws Exception;
	
}
