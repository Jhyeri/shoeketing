package sk.myPage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.common.service.InformService;
import sk.cs.service.CSService;
import sk.myPage.service.ShopPageService;

@Controller
public class ShopPageController {
	Logger log = LogManager.getLogger(this.getClass());

	@Resource(name = "shopPageService")
	private ShopPageService shopPageService;

	@Resource(name = "csService")
	private CSService csService;

	@Resource(name = "informService")
	private InformService informService;

	@Resource(name = "sessionService")
	private CommonService sessionService;

	@GetMapping(value = "/shopPage")
	public ModelAndView shopPage(Map<String, Object> map) throws Exception {
		log.debug("###### 매장 마이 페이지 메인 ######");
		ModelAndView mv = new ModelAndView("shopPage");

		return mv;
	}

	@GetMapping(value = "/shopPage/accountModifyForm")
	public ModelAndView shopModifyForm(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 매장 기본 정보 수정 폼 ######");
		ModelAndView mv = new ModelAndView("shopModifyForm");

		map.put("SHOP_NUM", sessionService.getSessionShop(session, "SHOP_NUM"));

		Map<String, Object> shopInfoMap = shopPageService.selectShopInfo(map);
		mv.addObject("shopInfoMap", shopInfoMap);

		return mv;
	}

	// ajax 구현
	@ResponseBody
	@PostMapping(value = "/shopPage/accountModify")
	public Map<String, Object> shopModify(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 기본 정보 수정 ######");

		Map<String, Object> updateResultMap = shopPageService.updateShopInfo(map);

		return updateResultMap;
	}

	@GetMapping(value = "/shopPage/csList")
	public ModelAndView shopCSList(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 매장 문의 내역 리스트 ######");
		ModelAndView mv = new ModelAndView("shopCSList");

//		// 매장 문의내역 글 토탈 개수, 문의내역 리스트
//		int shopCSCount = csService.selectShopCSCount(map, session);
//		List<Map<String, Object>> shopCSList = csService.selectShopCSList(map, session);
//
//		mv.addObject("shopCSCount", shopCSCount);
//		mv.addObject("shopCSList", shopCSList);
//
//		Map<String, Object> shopCSMap = new HashMap<>(); // shopCSList에서 꺼낸 맵 저장해줄 shopCSMap
//		List<Map<String, Object>> csReplyStatusList = new ArrayList<>(); // 답변이 있는지 여부 리턴해서 리스트로 묶어주기
//
//		// shopCSList에서 하나씩 꺼내서 Map에 저장해주고
//		for (int i = 0; i < shopCSList.size(); i++) {
//			shopCSMap = shopCSList.get(i);
//
//			// shopCSMap에서 CS_NUM 꺼내와서 csNum 변수에 저장해주고, 문의글번호로 댓글 있는지 확인해서 Map으로 가져오기
//			int csNum = Integer.parseInt(shopCSMap.get("CS_NUM").toString());
//			map.put("CS_NUM", csNum);
//			System.out.println("map 확인!!!! " + map);
//
//			Map<String, Object> csReplyMap = new HashMap<>();
//			csReplyMap = csService.selectCSReply(map);
//			System.out.println("csReplyMap 확인 " + csReplyMap);
//
//			Map<String, Object> csReplyStatusMap = new HashMap<>();
//
//			// 답변이 있을경우 처리 상태는 "답변 완료", 없을경우 "답변 대기중"으로 csReplyStatusMap에 저장
//			if (csReplyMap != null && !csReplyMap.isEmpty()) {
//				csReplyStatusMap.put("csReplyStatus", "답변 완료");
//			} else {
//				csReplyStatusMap.put("csReplyStatus", "답변 대기중");
//			}
//
//			System.out.println("csReplyStatusMap : " + csReplyStatusMap);
//
//			// csReplyStatusMap을 List에 하나씩 더해주기
//			csReplyStatusList.add(csReplyStatusMap);
//		}
//
//		System.out.println("csReplyStatusList : " + csReplyStatusList);
//		mv.addObject("csReplyStatusList", csReplyStatusList);

		return mv;
	}

	@PostMapping(value = "/shopPage/csList/paging")
	public ModelAndView shopCSList_paging(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 매장 문의 내역 리스트 ######");
		ModelAndView mv = new ModelAndView("jsonView");

		// 매장 문의내역 글 토탈 개수, 문의내역 리스트
		List<Map<String, Object>> shopCSList = csService.selectShopCSList(map, session);
		mv.addObject("shopCSList", shopCSList);

		if (shopCSList.size() > 0) {
			int shopCSCount = csService.selectShopCSCount(map, session); // 매장 문의글 토탈 개수
			System.out.println("shopCSCount 확인 : " + shopCSCount);
			mv.addObject("TOTAL", shopCSCount);
		} else {
			mv.addObject("TOTAL", 0);
		}

		Map<String, Object> shopCSMap = new HashMap<>(); // shopCSList에서 꺼낸 맵 저장해줄 shopCSMap
		List<Map<String, Object>> csReplyStatusList = new ArrayList<>(); // 답변이 있는지 여부 리턴해서 리스트로 묶어주기

		// shopCSList에서 하나씩 꺼내서 Map에 저장해주고
		for (int i = 0; i < shopCSList.size(); i++) {
			shopCSMap = shopCSList.get(i);

			// shopCSMap에서 CS_NUM 꺼내와서 csNum 변수에 저장해주고, 문의글번호로 댓글 있는지 확인해서 Map으로 가져오기
			int csNum = Integer.parseInt(shopCSMap.get("CS_NUM").toString());
			map.put("CS_NUM", csNum);
			System.out.println("map 확인!!!! " + map);

			Map<String, Object> csReplyMap = new HashMap<>();
			csReplyMap = csService.selectCSReply(map);
			System.out.println("csReplyMap 확인 " + csReplyMap);

			Map<String, Object> csReplyStatusMap = new HashMap<>();

			// 답변이 있을경우 처리 상태는 "답변 완료", 없을경우 "답변 대기중"으로 csReplyStatusMap에 저장
			if (csReplyMap != null && !csReplyMap.isEmpty()) {
				csReplyStatusMap.put("csReplyStatus", "답변 완료");
			} else {
				csReplyStatusMap.put("csReplyStatus", "답변 대기중");
			}

			System.out.println("csReplyStatusMap : " + csReplyStatusMap);

			// csReplyStatusMap을 List에 하나씩 더해주기
			csReplyStatusList.add(csReplyStatusMap);
		}

		System.out.println("csReplyStatusList : " + csReplyStatusList);
		mv.addObject("csReplyStatusList", csReplyStatusList);

		return mv;
	}

	@PostMapping(value = "/shopPage/csDetail_ajax")
	public ModelAndView shopCSDetail(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 문의 내역 상세 보기 ######");
		ModelAndView mv = new ModelAndView("shopCSDetail_ajax");

		Map<String, Object> csDetailMap = csService.selectCSDetail(map);
		Map<String, Object> csReplyMap = csService.selectCSReply(map);

		// 답변 여부 string타입으로 선언
		String csReplyStatus = null;

		// 답변이 있는지 여부 확인해서 문자열 올려주기
		if (csReplyMap != null && !csReplyMap.isEmpty()) {
			csReplyStatus = "답변 완료";
		} else {
			csReplyStatus = "답변 대기중";
		}

		mv.addObject("csDetailMap", csDetailMap);
		mv.addObject("csReplyMap", csReplyMap);
		mv.addObject("csReplyStatus", csReplyStatus);

		return mv;
	}

	// ajax 구현
	@ResponseBody
	@PostMapping(value = "/shopPage/csReplyWrite")
	public Map<String, Object> shopCSReplyWrite(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 문의내역 답변작성 ######"); // 문의 답변 작성시 inform쪽 insertInform도 호출

		Map<String, Object> insertCSReplyResult = csService.insertCSReply(map);
		System.out.println("insertCSReplyResult 확인 : " + insertCSReplyResult);

		return insertCSReplyResult;
	}

	// StockContoller ShopSearch() 메서드에 구현
//	@GetMapping(value = "/shopDetail")
//	public ModelAndView shopDetail(Map<String, Object> map) throws Exception {
//		log.debug("###### 매장 상세정보 조회 ######");
//		ModelAndView mv = new ModelAndView("testMain"); // 추후 수정
//
//		// 매장 상세정보 및 제품번호, 사이즈에 해당하는 재고수량
//		Map<String, Object> shopInfoMap = shopPageService.selectShopInfo(map);
//		int shopGoodsAmount = shopPageService.selectGoodsAmount(map);
//
//		mv.addObject("shopInfoMap", shopInfoMap);
//		mv.addObject("shopGoodsAmount", shopGoodsAmount);
//
//		System.out.println("shopInfoMap 확인 : " + shopInfoMap);
//		System.out.println("shopGoodsAmount 확인 : " + shopGoodsAmount);
//
//		return mv;
//	}

}
