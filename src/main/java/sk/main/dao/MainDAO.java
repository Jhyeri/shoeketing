package sk.main.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;


@Repository("mainDAO")
public class MainDAO extends AbstractDAO{
	
	// 브랜드 검색
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> BrandSearch(Map<String, Object> map) throws Exception {
		System.out.println("BrandSearch : " + map);
		return (List<Map<String, Object>>) selectList("main.selectBrandList", map);
		// 브랜드 리스트 가져오기
	}
	
	//매장 검색
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> ShopSearch(Map<String, Object> map)throws Exception{
		System.out.println("ShopSearch : " + map);
		return (List<Map<String, Object>>) selectList("main.selectShopList", map);
		//매장 리스트 가져오기
	}
	
	public int selectShopCount(Map<String, Object> map) throws Exception{
		System.out.println("selectShopCount : " + map);
		return (int) selectOne("main.selectShopCount", map);
	}
	
	//상품 검색
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> GoodsSearch(Map<String, Object> map)throws Exception{
		System.out.println("GoodsSearch : " + map);
		return (List<Map<String, Object>>) selectList("main.selectGoodsList", map);
		//상품 리스트 가져오기
	}
	
	

}
