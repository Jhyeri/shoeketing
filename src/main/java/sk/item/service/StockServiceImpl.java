package sk.item.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import sk.common.service.CommonService;
import sk.item.dao.StockDAO;
import sk.myPage.dao.ShopPageDAO;

@Service("stockService")
public class StockServiceImpl implements StockService {

	@Resource(name = "stockDAO")
	private StockDAO stockDAO;

	@Resource(name = "shopPageDAO")
	private ShopPageDAO shopPageDAO;
	
	@Resource(name = "sessionService")
	private CommonService sessionService;

	// 매장별 상품 재고 리스트 (최신 상품순 정렬, 다음은 사이즈 오름차순 정렬)
	@Override
	public List<Map<String, Object>> selectStockList(Map<String, Object> map, HttpSession session) throws Exception {

		map.put("SHOP_NUM", sessionService.getSessionShop(session, "SHOP_NUM"));
		map.put("searchType", map.get("searchType"));  
		map.put("keyword", map.get("keyword")); 
		map.put("START", 1);
		map.put("END", 5);

		List<Map<String, Object>> shopStockList = stockDAO.selectStockList(map);

		return shopStockList;
	}

	// 재고 리스트 토탈개수 (Ex, 상품이 14줄이면 토탈개수 14)
	@Override
	public int selectStockCount(Map<String, Object> map, HttpSession session) throws Exception {

		map.put("SHOP_NUM", sessionService.getSessionShop(session, "SHOP_NUM"));
		int stockCount = stockDAO.selectStockCount(map);

		return stockCount;
	}

	// 재고 수량 업데이트. 수량 업데이트 ajax로 구현예정
	@Override
	public Map<String, Object> updateStock(Map<String, Object> map, HttpSession session) throws Exception {

		Map<String, Object> updateStockResult = new HashMap<>();

		// SHOP_GOODS_AMOUNT, SHOP_NUM, TOTAL_GOODS_NUM, SHOP_GOODS_SIZE
		map.put("SHOP_GOODS_AMOUNT", map.get("SHOP_GOODS_AMOUNT"));
		map.put("SHOP_NUM", sessionService.getSessionShop(session, "SHOP_NUM"));
		map.put("TOTAL_GOODS_NUM", map.get("TOTAL_GOODS_NUM"));
		map.put("SHOP_GOODS_SIZE", map.get("SHOP_GOODS_SIZE"));

		int updateResult = stockDAO.updateStock(map);

		// 업데이트 한 결과 map에 담아서 리턴
		if (updateResult == 1) {
			updateStockResult.put("result", "pass");
		} else {
			updateStockResult.put("result", "fail");
		}

		System.out.println("updateStockResult : " + updateStockResult);

		return updateStockResult;
	}

	// 검색한 재고를 가지는 매장 리스트
	@Override
	public List<Map<String, Object>> selectShopStockList(Map<String, Object> map) throws Exception {
		return stockDAO.selectShopStockList(map);
	}

	// 검색한 재고를 가지는 매장 수
	@Override
	public int selectShopStockCount(Map<String, Object> map) throws Exception {
		return stockDAO.selectShopStockCount(map);
	}

	// 매장 선택 시 매장정보 조회
	@Override
	public Map<String, Object> selectStockShopInfo(Map<String, Object> map) throws Exception {
		return shopPageDAO.selectShopInfo(map);
	}

}
