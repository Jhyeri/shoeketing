package sk.item.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface StockService {

	// 매장별 상품 재고 리스트 (최신상품순 정렬, 다음은 사이즈 오름차순 정렬)
	public List<Map<String, Object>> selectStockList(Map<String, Object> map, HttpSession session) throws Exception;

	// 재고 리스트 토탈개수
	public int selectStockCount(Map<String, Object> map, HttpSession session) throws Exception;

	// 재고 수량 업데이트
	public Map<String, Object> updateStock(Map<String, Object> map, HttpSession session) throws Exception;

	// 검색한 재고를 가지는 매장 리스트
	public List<Map<String, Object>> selectShopStockList(Map<String, Object> map) throws Exception;

	// 검색한 재고를 가지는 매장 수
	public int selectShopStockCount(Map<String, Object> map) throws Exception;

	// 매장 선택 시 매장 정보 가져오기
	public Map<String, Object> selectStockShopInfo(Map<String, Object> map) throws Exception;
}
