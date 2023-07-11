package sk.item.service;

import java.util.List;
import java.util.Map;

public interface BasketService {

	// 장바구니 리스트
	public List<Map<String, Object>> selectBasketList(Map<String, Object> map) throws Exception;

	// 장바구니 추가
	int insertBasket(Map<String, Object> map) throws Exception;

	// 장바구니 삭제
	void deleteBasket(Map<String, Object> map) throws Exception;

	//주문번호 max 조회
	long selectOrderId(Map<String, Object> map) throws Exception;
	
}
