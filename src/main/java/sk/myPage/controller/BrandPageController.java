package sk.myPage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.myPage.service.BrandPageService;

@Controller
public class BrandPageController {
	Logger log = LogManager.getLogger(this.getClass());

	@Resource(name = "brandPageService")
	private BrandPageService brandPageService;
	
	@Resource(name = "sessionService")
	private CommonService sessionService;
	
	@GetMapping(value = "/brandPage")
	public ModelAndView brandPage(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 브랜드 마이 페이지 메인 ######");
		ModelAndView mv = new ModelAndView("brandPageMain");
		
		return mv;
	}

	@GetMapping(value = "/brandPage/accountModifyForm")
	public ModelAndView brandModifyForm(@RequestParam Map<String, Object> map, HttpSession session)
			throws Exception {
		log.debug("###### 브랜드 기본 정보 수정 폼 ######");
		ModelAndView mv = new ModelAndView("brandModifyForm"); 

		Map<String, Object> brandInfoMap = brandPageService.selectBrandInfo(map, session);
		
		System.out.println("brandInfoMap : " + brandInfoMap);
		mv.addObject("brandInfoMap", brandInfoMap);

		return mv;
	}

	// ajax 구현완료
	@ResponseBody
	@PostMapping(value = "/brandPage/accountModify")
	public Map<String, Object> brandModify(@RequestParam Map<String, Object> map, MultipartHttpServletRequest request, HttpServletRequest sessionRequest) throws Exception {
		log.debug("###### 브랜드 기본 정보 수정 ######");

		System.out.println("map 확인 : " + map);

		Map<String, Object> resultMap = brandPageService.updateBrandInfo(map, request);
		System.out.println("resultMap 확인 : " + resultMap);
		
		// 기본 정보 수정시, 브랜드 로고 파일 다시 세션에 올리기
		HttpSession session = sessionRequest.getSession();
		if(resultMap != null) {
			session.setAttribute("session_BRAND_LOGO_FILE", map.get("BRAND_LOGO_FILE"));
		}
		
		return resultMap;
	}

	@GetMapping(value = "/brandPage/shopList")
	public ModelAndView shopList(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 브랜드 입점 매장 리스트 ######");
		ModelAndView mv = new ModelAndView("shopList"); 

		List<Map<String, Object>> shopList = brandPageService.selectShopList(map, session);

		mv.addObject("shopList", shopList); 

		// 해당 브랜드 입점 매장 토탈 개수
		int shopCount = brandPageService.selectShopCount(map, session);
		System.out.println("shopCount 확인 : " + shopCount);

		return mv;
	}
	
	@PostMapping(value = "/brandPage/shopList/paging")
	public ModelAndView shopList_paging(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 브랜드 입점 매장 리스트 ######");
		ModelAndView mv = new ModelAndView("jsonView"); 

		List<Map<String, Object>> shopList = brandPageService.selectShopList(map, session);
		mv.addObject("shopList", shopList); 

		if (shopList.size() > 0) {
			int shopCount = brandPageService.selectShopCount(map, session); // 해당 브랜드 입점 매장 토탈 개수
			System.out.println("shopCount 확인 : " + shopCount); 
			mv.addObject("TOTAL", shopCount);
		} else {
			mv.addObject("TOTAL", 0);
		}

		return mv;
	}

	@GetMapping(value = "/brandPage/shopRequestList")
	public ModelAndView shopRequestList(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 브랜드 매장 입점 요청 리스트 ######");
		ModelAndView mv = new ModelAndView("shopRequestList");

//		List<Map<String, Object>> shopRequestList = brandPageService.selectRequestShopList(map, session);
//		mv.addObject("shopRequestList", shopRequestList); 

		return mv;
	}
	
	@PostMapping(value = "/brandPage/shopRequestList/paging")
	public ModelAndView shopRequestList_paging(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 브랜드 매장 입점 요청 리스트 ######");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> shopRequestList = brandPageService.selectRequestShopList(map, session);
		mv.addObject("shopRequestList", shopRequestList); 
		
		if (shopRequestList.size() > 0) {
			int shopRequestCount = brandPageService.selectRequestShopCount(map, session); // 해당 브랜드 입점 요청 매장 토탈 개수
			System.out.println("shopRequestCount 확인 : " + shopRequestCount); 
			mv.addObject("TOTAL", shopRequestCount);
		} else {
			mv.addObject("TOTAL", 0);
		}


		return mv;
	}


	// ajax 구현
	@ResponseBody
	@PostMapping(value = "/brandPage/shopJoinApprove")
	public Map<String, Object> shopJoinApprove(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드 매장 입점 승인 ######");
		
		// 브랜드가 매장 입점 승인 (매장 가입 승인여부 Y로 변경됨)_승인시, 트리거 동작해서 해당 브랜드의 전체 상품이 해당 매장의 상품으로
		// 자동등록됨
		Map<String, Object> result = brandPageService.updateShopJoinApprove(map);

		return result;
	}
	
	// ajax 구현
	@ResponseBody
	@PostMapping(value = "/brandPage/shopJoinReject")
	public Map<String, Object> shopJoinReject(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드 매장 입점 거부 ######");

		// 브랜드가 매장 입점 거부 (매장 탈퇴여부 Y로 변경됨)
		Map<String, Object> result = brandPageService.updateShopJoinReject(map);
		 
		return result;
	}

	// ajax 구현 
	@ResponseBody
	@PostMapping(value = "/brandPage/shopDelete")
	public Map<String, Object> shopDelete(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드 입점 매장 삭제(탈퇴) ######");
		
		Map<String, Object> result = brandPageService.deleteShop(map);

		return result;
	}

	@ResponseBody
	@PostMapping(value = "/brandPage/shopLocationInfo")
	public Map<String, Object> shopLocationInfo(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드 입점/입점요청 매장 위치 조회 ######");

		Map<String, Object> shopLocationInfoMap = brandPageService.selectShopLocationInfo(map);

		return shopLocationInfoMap;
	}

	// 브랜드관
	@GetMapping(value = "/brand/main")
	public ModelAndView brandInfo(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드관 메인 페이지 ######");
		ModelAndView mv = new ModelAndView("brandInfo"); // 추후 수정

		System.out.println("BRAND_NUM 확인 : " + map.get("BRAND_NUM"));
		
		// 브랜드관에 표시할 정보
		Map<String, Object> brandPageInfoMap = brandPageService.selectBrandPageInfo(map);
		System.out.println("brandPageInfoMap 확인 : " + brandPageInfoMap);
		mv.addObject("brandPageInfoMap", brandPageInfoMap);
		
		// 최신 상품 리스트(5개)
		List<Map<String, Object>> recentGoodsList = brandPageService.selectNewGoodsList(map);
		System.out.println("recentGoodsList 확인 : " + recentGoodsList);

		Map<String, Object> recentGoodsMap = new HashMap<String, Object>();
		List<Map<String, Object>> recentGoodsThumbnailList = new ArrayList<Map<String, Object>>();

		// recentGoodsList에서 하나씩 꺼내서 Map에 저장
		for (int i = 0; i < recentGoodsList.size(); i++) {
			recentGoodsMap = recentGoodsList.get(i);

			// recentGoodsMap에서 TOTAL_GOODS_NUM 꺼내서 int타입의 totalGoodsNum 변수에 저장하고 그 값을 map에
			// 넣어주기 (상품 썸네일 조회해서 가져오기 위해서)
			int totalGoodsNum = Integer.parseInt(recentGoodsMap.get("TOTAL_GOODS_NUM").toString());
			map.put("TOTAL_GOODS_NUM", totalGoodsNum);

			// 최신 상품 리스트 썸네일 가져와서 Map에 저장하고, recentGoodsThumbnailList에 추가
			Map<String, Object> recentGoodsThumbnailMap = brandPageService.selectGoodsThumbnail(map);
			recentGoodsThumbnailList.add(recentGoodsThumbnailMap);
		}

		// 최신 상품 리스트랑, 그 리스트에 있는 상품의 썸네일 리스트 jsp로 올리기
		mv.addObject("recentGoodsList", recentGoodsList);
		mv.addObject("recentGoodsThumbnailList", recentGoodsThumbnailList);

		// 인기 상품 리스트(찜순으로 5개)
		List<Map<String, Object>> rankingGoodsList = brandPageService.selectGoodsRankingList(map);
		System.out.println("rankingGoodsList 확인 : " + rankingGoodsList);

		Map<String, Object> rankingGoodsMap = new HashMap<String, Object>();
		List<Map<String, Object>> rankingGoodsThumbnailList = new ArrayList<Map<String, Object>>();

		Map<String, Object> map2 = new HashMap<String, Object>();

		// rankingGoodsList에서 하나씩 꺼내서 Map에 저장
		for (int i = 0; i < rankingGoodsList.size(); i++) {
			rankingGoodsMap = rankingGoodsList.get(i);

			// rankingGoodsMap에서 TOTAL_GOODS_NUM 꺼내서 int타입의 totalGoodsNum 변수에 저장하고 그 값을
			// map2에 넣어주기 (상품 썸네일 조회해서 가져오기 위해서)
			int totalGoodsNum = Integer.parseInt(rankingGoodsMap.get("TOTAL_GOODS_NUM").toString());
			map2.put("TOTAL_GOODS_NUM", totalGoodsNum);

			// 인기 상품 리스트 썸네일 가져와서 Map에 저장해주고, rankingGoodsThumbnailList에 추가
			Map<String, Object> rankingGoodsThumbnailMap = brandPageService.selectGoodsThumbnail(map2);
			rankingGoodsThumbnailList.add(rankingGoodsThumbnailMap);
		}

		// 인기상품 리스트랑, 그 리스트에 있는 상품의 썸네일 리스트 jsp로 올리기
		mv.addObject("rankingGoodsList", rankingGoodsList);
		mv.addObject("rankingGoodsThumbnailList", rankingGoodsThumbnailList);

		return mv;
	}

}
