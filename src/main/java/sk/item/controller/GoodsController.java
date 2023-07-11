package sk.item.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.item.service.GoodsService;

@RestController
public class GoodsController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "goodsService")
	private GoodsService goodsService;

	@Resource(name = "sessionService")
	private CommonService commonService;

	@GetMapping(value = "/brandPage/goodsList")
	public ModelAndView goodsList(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 브랜드회원 전체상품 리스트 ######");
		ModelAndView mv = new ModelAndView("goodsList");

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

	// 브랜드 회원 정보 전체 상품 리스트
	@PostMapping(value = "/brandPage/goodsList/paging")
	public ModelAndView goodsListPaging(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 브랜드회원 전체상품 리스트 페이징 ######");
		ModelAndView mv = new ModelAndView("jsonView");

		System.out.println("BRAND_NAME : " + commonService.getSessionBrand(session, "BRAND_NAME"));
		map.put("BRAND_NAME", commonService.getSessionBrand(session, "BRAND_NAME"));

		System.out.println("map : " + map);

		// 전체상품 리스트 가져오기
		List<Map<String, Object>> list = goodsService.selectBrandGoodsList(map);

		// 브랜드의 상품 전체 개수 가져오기
		int count = goodsService.selectBrandGoodsCount(map);

		System.out.println("브랜드 전체상품 리스트 : " + list);
		mv.addObject("list", list);
		mv.addObject("keyword", map.get("keyword"));
		mv.addObject("searchType", map.get("searchType"));
		// 검색 후 화면에 검색어와 검색조건이 유지되도록 파라미터를 뷰로 전송
		mv.addObject("TOTAL", count); // 브랜드 전체 상품 토탈 개수
		return mv;
	}

	@RequestMapping(value = "/goods/totalList")
	public ModelAndView allGoodsList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### allGoodsList ######");
		ModelAndView mv = new ModelAndView("allGoodsList");

		List<Map<String, Object>> brandList = goodsService.selectAllBrandList(map);
		mv.addObject("brandList", brandList);

		return mv;
	}

	@PostMapping(value = "/goods/totalList/paging")
	public ModelAndView allGoodsListPaging(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### allGoodsListPaging ######");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> list = goodsService.selectAllGoodsList(map);
		int count = goodsService.selectAllGoodsCount(map);

		System.out.println("count: " + count);
		System.out.println("list: " + list);
		System.out.println("map: " + map);

		if (list.size() > 0) {
			mv.addObject("TOTAL", count);
		} else {
			mv.addObject("TOTAL", 0);
		}

		mv.addObject("list", list);
		return mv;
	}

	@PostMapping(value = "/goods/totalList/brandList")
	public ModelAndView brandListInAllGoodsList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### brandListInAllGoodsList ######");
		ModelAndView mv = new ModelAndView("jsonView");

		List<String> brandList = goodsService.selectBrandList(map);
		mv.addObject("brandList", brandList);

		return mv;
	}

	@RequestMapping(value = "/goods/goodsDetail")
	public ModelAndView goodsDetail(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### goodsDetail ######");
		System.out.println("goodsDeatil map : " + map);
		ModelAndView mv = new ModelAndView("goodsDetail");
		map.put("MEM_NUM", commonService.getSession(session, "MEM_NUM"));

		List<Map<String, Object>> goodsDetailList = goodsService.selectGoodsDetail(map);
		List<Map<String, Object>> goodsImageList = goodsService.selectGoodsImage(map);
		Map<String, Object> goodsReviewPercentMap = goodsService.selectReviewPercent(map);
		int checkGoodsLike = goodsService.selectGoodsLike(map);

		mv.addObject("goodsDetailList", goodsDetailList);
		mv.addObject("goodsImageList", goodsImageList);
		mv.addObject("goodsReviewPercent", goodsReviewPercentMap);
		mv.addObject("checkGoodsLike", checkGoodsLike);

		return mv;
	}

//   @RequestMapping(value="/brandPage/goodsModifyForm")
//   public ModelAndView goodsModifyForm(Map<String, Object> map, HttpSession session) throws Exception {
//      log.debug("###### goodsModifyForm ######");
//      System.out.println("goodsModifyForm map : " + map);
//      ModelAndView mv = new ModelAndView("goodsWriteForm");
//      
//      //TOTAL_GOODS_NUM
//      
//      return mv;
//   }
	// 상품명
	// 모델번호
	// 카테고리
	// 가격
	// 사이즈
	// 파일

	@ResponseBody
	@GetMapping(value = "/goods/goodsLike")
	public String goodsLike(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {

		map.put("MEM_NUM", commonService.getSession(session, "MEM_NUM"));
		int isSuccess = goodsService.insertGoodsLike(map);

		String result = "";
		if (isSuccess == 1) {
			goodsService.updateGoodsLikeCountIncrease(map);
			result = "success";
		} else {
			result = "fail";
		}

		return result;
	}

	@ResponseBody
	@GetMapping(value = "/goods/goodsUnlike")
	public String goodsUnlike(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {

		map.put("MEM_NUM", commonService.getSession(session, "MEM_NUM"));
		int isSuccess = goodsService.deleteGoodsLike(map);

		String result = "";
		if (isSuccess == 1) {
			goodsService.updateGoodsLikeCountDecrease(map);
			result = "success";
		} else {
			result = "fail";
		}
		return result;
	}

	@GetMapping(value = "/brandPage/goodsWriteForm")
	public ModelAndView goodsWriteForm(Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드 상품 등록 폼 ######");
		ModelAndView mv = new ModelAndView("goodsWriteForm");

		return mv;
	}

	@PostMapping(value = "/brandPage/goodsWrite")
	public Map<String, Object> goodsWrite(MultipartFile[] uploadGoodsImg, @RequestParam Map<String, Object> map,
			@RequestParam(value="GOODS_DETAIL_SIZE") List<String> goodsSizeList, HttpSession session) throws Exception {
		log.debug("###### 브랜드 상품 등록 ######");
		log.debug("GOODS_DETAIL_SIZE 확인 : " + goodsSizeList);

		Map<String, Object> goodsWrite = new HashMap<>();

		goodsWrite = goodsService.insertGoods(map, session, uploadGoodsImg, goodsSizeList);
		System.out.println("goodsWrite Map 확인 : " + goodsWrite);
			

		//Map<String, Object> goodsWrite = goodsService.insertGoods(map, session, uploadGoodsImg);
		return goodsWrite;
	}

	// 상품 수정 폼
	@GetMapping(value = "/brandPage/goodsModifyForm")
	public ModelAndView goodsModifyForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드관 상품 수정 폼 ######");
		ModelAndView mv = new ModelAndView("goodsModifyForm");

		// 해당 상품 상세정보, 이미지 정보 폼으로 넘기기
		List<Map<String, Object>> goodsDetailMapList = goodsService.selectGoodsDetail(map);
		List<Map<String, Object>> goodsImageMapList = goodsService.selectGoodsImage(map);

		Map<String, Object> goodsDetailMap = goodsDetailMapList.get(0);
		List<Map<String, Object>> goodsImageList = new ArrayList<>();
		List<Map<String, Object>> goodsSizeList = new ArrayList<>();

		for (int i = 0; i < goodsImageMapList.size(); i++) {
			Map<String, Object> goodsImageMap = new HashMap<>();
			goodsImageMap.put("GOODS_IMAGE_STD", goodsImageMapList.get(i).get("GOODS_IMAGE_STD"));
			goodsImageList.add(goodsImageMap);
		}

		for (int i = 0; i < goodsDetailMapList.size(); i++) {
			Map<String, Object> goodsSizeMap = new HashMap<>();
			goodsSizeMap.put("GOODS_DETAIL_SIZE", goodsDetailMapList.get(i).get("GOODS_DETAIL_SIZE"));
			goodsSizeList.add(goodsSizeMap);
		}
		log.debug("goodsSizeList 확인 : " + goodsSizeList);

		mv.addObject("goodsDetailMap", goodsDetailMap);
		mv.addObject("goodsImageList", goodsImageList);
		mv.addObject("goodsSizeList", goodsSizeList);

		return mv;
	}
	
	// 상품 수정폼에서 사이즈 별 재고 있는 매장 수/재고개수 ajax로 표시 
	@PostMapping(value = "/brandPage/goodsModifyForm/sizeCheck")
	public ModelAndView goodsModifyFormSizeCheck(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드관 상품 수정 폼 사이즈 ajax처리 ######");
		ModelAndView mv = new ModelAndView("jsonView");
	
		// 해당 상품 사이즈가 있는 매장개수 + 총 재고개수 
		int shopCount = goodsService.selectShopCountFromStockOfSize(map);
		int goodsAmount = goodsService.selectGoodsAmountFromStockOfSize(map);
		
		log.debug("shopCount 확인 : " + shopCount);
		log.debug("goodsAmount 확인 : " + goodsAmount);
		
		mv.addObject("shopCount", shopCount);
		mv.addObject("goodsAmount", goodsAmount);
		
		return mv;
	}
	
	
	// 상품 수정
	@PostMapping(value = "/brandPage/goodsModify")
	public Map<String, Object> goodsModify(MultipartFile[] uploadGoodsImg, @RequestParam Map<String, Object> map, 
			@RequestParam(value="GOODS_DETAIL_SIZE_new") List<String> goodsSizeList, HttpSession session) throws Exception {
		log.debug("###### 브랜드관 상품 수정 ######");
	
		log.debug("GOODS_DETAIL_SIZE 확인 : " + map.get("GOODS_DETAIL_SIZE"));
		
		//log.debug("goodsSizeList_old 확인 : " + goodsSizeList_old);
		log.debug("goodsSizeList 확인 : " + goodsSizeList);
		
		//if(map.get("GOODS_DETAIL_SIZE_old").equals("goodsSizeList"));
		
		Map<String, Object> goodsModifyResultMap = goodsService.updateGoods(uploadGoodsImg, map, goodsSizeList, session);

		// 추후 FileUtils 구현하고 작성
		return goodsModifyResultMap;
	}

	// 상품 삭제
	@PostMapping(value = "/brandPage/goodsDelete")
	public Map<String, Object> goodsDelete(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드관 상품 삭제 ######");
		log.debug("###### map 확인 ###### : " + map);

		Map<String, Object> goodsDeleteResultMap = goodsService.deleteGoods(map);

		return goodsDeleteResultMap;
	}

}