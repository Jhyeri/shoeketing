package sk.item.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.item.service.StockService;

@RestController
public class StockController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "stockService")
	private StockService stockService;

	@Resource(name = "sessionService")
	private CommonService sessionService;

	@ResponseBody
	@GetMapping(value = "/shopPage/stockList")
	public ModelAndView shopStockList(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 매장 상품 재고 리스트 ######");
		ModelAndView mv = new ModelAndView("stockList");

		int page = 1;

		if (map.get("page") != null && map.get("page") != "") {
			page = Integer.parseInt(map.get("page").toString());
		}
		mv.addObject("page", page);

		if (map.get("searchType") != null && map.get("searchType") != "") {
			mv.addObject("searchType", map.get("searchType"));
		}

		if (map.get("keyword") != null && map.get("keyword") != "") {
			mv.addObject("keyword", map.get("keyword"));
		}

		return mv;
	}

	// 상품명/모델명 검색 시, ajax 구현
	@ResponseBody
	@PostMapping(value = "/shopPage/stockList/paging")
	public ModelAndView shopStockList_ajax(@RequestParam Map<String, Object> map, HttpSession session)
			throws Exception {
		log.debug("###### 매장 상품 재고 리스트 ######");
		ModelAndView mv = new ModelAndView("jsonView");

		// 재고 리스트 토탈개수 (Ex, 상품이 14줄이면 토탈개수 14)
		int stockCount = stockService.selectStockCount(map, session);
		List<Map<String, Object>> shopStockList = stockService.selectStockList(map, session);

		mv.addObject("shopStockList", shopStockList);
		mv.addObject("stockCount", stockCount);
		mv.addObject("SHOP_NUM", sessionService.getSessionShop(session, "SHOP_NUM"));

		return mv;
	}

	// ajax 구현
	@ResponseBody
	@PostMapping(value = "/shopPage/stockModify")
	public Map<String, Object> shopStockModify(@RequestParam Map<String, Object> map, HttpSession session)
			throws Exception {
		log.debug("###### 매장 상품 재고 수량 변경 ######");

		Map<String, Object> updateResult = stockService.updateStock(map, session);

		return updateResult;
	}

	@RequestMapping(value = "/goods/stockSearchForm")
	public ModelAndView stockSearchForm(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 실시간 재고 검색폼 ######");
		ModelAndView mv = new ModelAndView("stockSearchForm");

		String goodsName = null;
		String brandName = null;
		String goodsSize = null;

		if (map.get("goodsName") != null && map.get("goodsName") != "") {
			goodsName = map.get("goodsName").toString();
		}

		if (map.get("brandName") != null && map.get("brandName") != "") {
			brandName = map.get("brandName").toString();
		}

		if (map.get("goodsSize") != null && map.get("goodsSize") != "") {
			goodsSize = map.get("goodsSize").toString();
		}

		// 로그인 한 회원 정보 세션에서 가져오기
		String memName = sessionService.getSession(session, "MEM_NAME");
		String memEmail = (String) session.getAttribute("session_MEM_ID");

		mv.addObject("MEM_NAME", memName);
		mv.addObject("MEM_EMAIL", memEmail);
		mv.addObject("goodsName", goodsName);
		mv.addObject("brandName", brandName);
		mv.addObject("goodsSize", goodsSize);

		return mv;
	}

	@PostMapping(value = "/goods/stockSearch")
	public ModelAndView ShopSearch(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 실시간 재고 소유 매장 리스트 검색 ######");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> resultList = stockService.selectShopStockList(map);
		mv.addObject("list", resultList);
		if (resultList.size() > 0) {
			int count = stockService.selectShopStockCount(map);
			mv.addObject("TOTAL", count);
		} else {
			mv.addObject("TOTAL", 0);
		}

		return mv;
	}

	@ResponseBody
	@PostMapping(value = "/goods/stockShopInfo")
	public Map<String, Object> stockShopInfo(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 실시간 재고 소유 매장 상세정보 ######");
		Map<String, Object> resultMap = stockService.selectStockShopInfo(map);

		return resultMap;
	}

}
