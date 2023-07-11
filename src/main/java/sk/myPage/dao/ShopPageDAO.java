package sk.myPage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("shopPageDAO")
public class ShopPageDAO extends AbstractDAO{
	
	// 매장 기본정보 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectShopInfo(Map<String, Object> map) throws Exception {
		System.out.println("selectShopInfo 파라미터 : " + map);

		return (Map<String, Object>) selectOne("shopPage.selectShopInfo", map);
	}
	
	// 매장의 해당 브랜드 로고 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBrandLogoFileOfShop(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandLogoFileOfShop 파라미터 : " + map);

		return (Map<String, Object>) selectOne("shopPage.selectBrandLogoFileOfShop", map);
	}
	
	
	// 매장 기본정보 수정 - update() 
	public int updateShopInfo(Map<String, Object> map) throws Exception {
		System.out.println("updateShopInfo 파라미터 : " + map);

		return (int) update("shopPage.updateShopInfo", map);
	}
	
	
	// 매장별 재고수량 조회 - selectOne()
	public int selectGoodsAmount(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsAmount 파라미터 : " + map);

		return (int) selectOne("shopPage.selectGoodsAmount", map);
	}

	
}
