package sk.main.service;


import java.util.List;
import java.util.Map;

public interface MainService {
	
	public List<Map<String, Object>> BrandSearch(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> ShopSearch(Map<String, Object> map) throws Exception;
	
	int selectShopCount(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> GoodsSearch(Map<String, Object> map) throws Exception;
	
}