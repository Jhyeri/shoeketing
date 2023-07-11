package sk.myPage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import sk.common.service.CommonService;
import sk.common.util.FileUtils;
import sk.myPage.dao.BrandPageDAO;

//BrandPageService 구현클래스

@Service("brandPageService")
public class BrandPageServiceImpl implements BrandPageService {

	@Resource(name = "brandPageDAO")
	private BrandPageDAO brandPageDAO;
	
	@Resource(name="sessionService")
	private CommonService commonService;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;

	// 브랜드 기본정보 조회
	@Override
	public Map<String, Object> selectBrandInfo(Map<String, Object> map, HttpSession session) throws Exception {
		// 세션에 로그인한 브랜드 회원의 정보중 BRAND_NUM 꺼내와서 map에 넣어주기
		map.put("BRAND_NUM", commonService.getSessionBrand(session, "BRAND_NUM"));

		return brandPageDAO.selectBrandInfo(map);
	}
	
	// 브랜드 로고파일 조회 - selectOne()
	public Map<String, Object> selectBrandPageInfo(Map<String, Object> map) throws Exception{
		
		return brandPageDAO.selectBrandPageInfo(map);
	}

	// 브랜드 기본정보 수정
	@Override
	public Map<String, Object> updateBrandInfo(Map<String, Object> map, MultipartHttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		Map<String, Object> updateMap = fileUtils.parseUpdateFileInfo(map, request);
		System.out.println("updateMap 이름 확인 : " + updateMap);
		
		//map.put("BRAND_LOGO_FILE", updateImg.get("BRAND_LOGO_FILE"));
		int updateResult = brandPageDAO.updateBrandInfo(updateMap);

		if (updateResult == 1) {
			resultMap.put("updateResult", "pass");
		} else {
			resultMap.put("updateResult", "fail");
		}

		return resultMap;
	}

	// 브랜드 입점 매장 리스트(5줄)
	@Override
	public List<Map<String, Object>> selectShopList(Map<String, Object> map, HttpSession session)
			throws Exception {

		// 세션에 로그인한 브랜드회원의 정보중 BRAND_NAME 가져와서 map에 넣어주기
		map.put("BRAND_NAME", commonService.getSessionBrand(session, "BRAND_NAME"));
		
//		// 임시로 리스트 페이징 START랑 END값 넣어주기 (추후 수정. 한페이지에 5줄씩 표시)
//		map.put("START", 1);
//		map.put("END", 5);

		return brandPageDAO.selectShopList(map);
	}

	// 브랜드 입점 매장 토탈 개수
	@Override
	public int selectShopCount(Map<String, Object> map, HttpSession session) throws Exception {

		// 세션에 로그인한 브랜드회원의 정보중 BRAND_NAME 가져와서 map에 넣어주기
		map.put("BRAND_NAME", commonService.getSessionBrand(session, "BRAND_NAME"));

		return brandPageDAO.selectShopCount(map);
	}

	// 브랜드 매장 입점 요청 리스트 = 매장 가입 승인 리스트(아직 승인 전. 5줄)
	@Override
	public List<Map<String, Object>> selectRequestShopList(Map<String, Object> map, HttpSession session)
			throws Exception {

		// 세션에 로그인한 브랜드회원의 정보중 BRAND_NAME 가져와서 map에 넣어주기
		map.put("BRAND_NAME", commonService.getSessionBrand(session, "BRAND_NAME"));

		// 임시로 리스트 페이징 START랑 END값 넣어주기 (추후 수정. 한페이지에 5줄씩 표시)
//		map.put("START", 1);
//		map.put("END", 5);

		return brandPageDAO.selectRequestShopList(map);
	}

	// 브랜드 입점 요청 매장 토탈 개수 (아직 승인 전)
	@Override
	public int selectRequestShopCount(Map<String, Object> map, HttpSession session) throws Exception {

		// 세션에 로그인한 브랜드회원의 정보중 BRAND_NAME 가져와서 map에 넣어주기
		map.put("BRAND_NAME", commonService.getSessionBrand(session, "BRAND_NAME"));
		
		return brandPageDAO.selectRequestShopCount(map);
	}

	// 브랜드 매장 입점 요청 승인
	@Override
	public Map<String, Object> updateShopJoinApprove(Map<String, Object> map) throws Exception {

		Map<String, Object> resultMap = new HashMap<>();
		map.put("SHOP_NUM", map.get("SHOP_NUM"));
		
		int result = brandPageDAO.updateShopJoinApprove(map);
		
		if(result == 1) {
			resultMap.put("result", "pass");
		}else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	// 브랜드 매장 입점 요청 거부
	@Override
	public Map<String, Object> updateShopJoinReject(Map<String, Object> map) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		map.put("SHOP_NUM", map.get("SHOP_NUM"));
		
		int result = brandPageDAO.updateShopJoinReject(map);
		
		if(result == 1) {
			resultMap.put("result", "pass");
		}else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

	// 브랜드가 입점한 매장 삭제(탈퇴)
	// 트리거 사용해서 상품 테이블에 있는 해당 매장 상품들도 모두 삭제
	@Override
	public Map<String, Object> deleteShop(Map<String, Object> map) throws Exception {
		// 브랜드가 입점 매장 삭제시, 해당 매장에 등록되어 있던 상품 모두 함께 삭제(트리거)
		map.put("SHOP_NUM", map.get("SHOP_NUM"));

		// 매장을 삭제한 결과를 int타입으로 저장(삭제 정상적으로 했으면 1, 아니면 0)
		int result = brandPageDAO.deleteShop(map);
		Map<String, Object> deleteResult = new HashMap<String, Object>();

		if (result == 1) {
			deleteResult.put("deleteResult", "pass");
			System.out.println(deleteResult);
		} else {
			deleteResult.put("deleteResult", "fail");
			System.out.println(deleteResult);
		}

		return deleteResult;
	}

	// 브랜드 입점/입점요청 매장 위치 조회
	@Override
	public Map<String, Object> selectShopLocationInfo(Map<String, Object> map) throws Exception {
		Map<String, Object> shopInfoMap = new HashMap<>();
			
		map.put("SHOP_NUM", map.get("SHOP_NUM"));

		shopInfoMap = brandPageDAO.selectShopLocationInfo(map);
		
		return shopInfoMap;
	}

	// 브랜드관 상품 썸네일 이미지 조회 (image order 1)
	@Override
	public Map<String, Object> selectGoodsThumbnail(Map<String, Object> map) throws Exception {

		map.put("TOTAL_GOODS_NUM", map.get("TOTAL_GOODS_NUM"));

		return brandPageDAO.selectGoodsThumbnail(map);
	}

	// 브랜드관 최신 상품 리스트 (최신 상품 5개)
	@Override
	public List<Map<String, Object>> selectNewGoodsList(Map<String, Object> map) throws Exception {
		
		return brandPageDAO.selectNewGoodsList(map);
	}

	// 브랜드관 랭킹 5인 상품 리스트 (인기 상품 5개)
	@Override
	public List<Map<String, Object>> selectGoodsRankingList(Map<String, Object> map) throws Exception {
		
		return brandPageDAO.selectGoodsRankingList(map);
	}

}
