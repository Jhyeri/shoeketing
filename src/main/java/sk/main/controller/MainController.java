package sk.main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import sk.common.service.CommonService;
import sk.common.service.InformService;
import sk.main.service.MainService;

@RestController
public class MainController {

	@Resource(name = "mainService")
	private MainService mainService;

	@Resource(name = "informService")
	private InformService informService;

	@Resource(name = "sessionService")
	private CommonService commonService;

	Log log = LogFactory.getLog(this.getClass());

	@GetMapping(value = "/main")
	public ModelAndView main(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### SHOEKETING 메인페이지 ######");
		ModelAndView mv = new ModelAndView("main");
		return mv;
	}

	@RequestMapping(value = "/totalSearch")
	public ModelAndView totalSearch(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### totalSearch ######");
		ModelAndView mv = new ModelAndView("totalSearch");

		Object keyword = map.get("keyword");
		if (keyword == null || ((String) keyword).isEmpty()) {
			return mv;
		}
		mv.addObject("keyword", keyword);
		System.out.println("keyword: " + keyword);

		List<Map<String, Object>> brandList = mainService.BrandSearch(map);
		List<Map<String, Object>> goodsList = mainService.GoodsSearch(map);
		List<Map<String, Object>> shopList = mainService.ShopSearch(map);

		mv.addObject("brandList", brandList);
		mv.addObject("shopList", shopList);
		mv.addObject("goodsList", goodsList);
		
		// 더보기 로직 실행 시(totalSearch.jsp 187번행) List<Map<String, Object>> 대신 List<JsonObject>가 필요함
		List<JsonObject> goodsJson = new ArrayList<>();
		
		for(Map<String, Object> goodsMap : goodsList) {
			Gson gson = new Gson();
	        JsonObject json = gson.toJsonTree(goodsMap).getAsJsonObject();
	        goodsJson.add(json);
		}
		mv.addObject("goodsJson", goodsJson);
		
		List<JsonObject> shopJson = new ArrayList<>();
		
		for(Map<String, Object> shopMap : shopList) {
			Gson gson = new Gson();
	        JsonObject json = gson.toJsonTree(shopMap).getAsJsonObject();
	        shopJson.add(json);
		}
		mv.addObject("shopJson", shopJson);
		
		return mv;
	}

	@RequestMapping(value = "/totalSearch_ajax")
	public Map<String, Object> totalSearch_ajax(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### totalSearch_ajax ######");

		Map<String, Object> info = new HashMap<String, Object>();

		Object keyword = map.get("keyword");
		if (keyword == null || ((String) keyword).isEmpty()) {
			return info;
		}
		info.put("keyword", keyword);

		System.out.println("keyword: " + keyword);

		List<Map<String, Object>> barndList = mainService.BrandSearch(map);
		List<Map<String, Object>> shopList = mainService.ShopSearch(map);
		List<Map<String, Object>> goodsList = mainService.GoodsSearch(map);

		info.put("brandList", barndList);
		info.put("shopList", shopList);
		info.put("goodsList", goodsList);

		return info;
	}

	@RequestMapping(value = "/inform")
	public ModelAndView inform(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 알림 조회 ######");
		ModelAndView mv = new ModelAndView("inform_ajax");

		map.put("MEM_NUM", commonService.getSession(session, "MEM_NUM"));
		List<Map<String, Object>> resultList = informService.informList(map);

		mv.addObject("informList", resultList);

		return mv;
	}

	@RequestMapping(value = "/inform/confirmUpdate")
	public void informConfirmUpdate(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 알림 확인 ######");

		informService.confirmUpdate(map);
	}
}
