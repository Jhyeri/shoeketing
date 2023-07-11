package sk.myPage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("brandPageDAO")
public class BrandPageDAO extends AbstractDAO {

	// 브랜드 기본정보 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBrandInfo(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandInfo 파라미터 : " + map);

		return (Map<String, Object>) selectOne("brandPage.selectBrandInfo", map);
	}

	// 브랜드 로고파일 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBrandPageInfo(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandPageInfo 파라미터 : " + map);
		
		return(Map<String, Object>) selectOne("brandPage.selectBrandPageInfo", map);
	}
	
	// 브랜드 기본정보 수정 - update()
	public int updateBrandInfo(Map<String, Object> map) throws Exception {
		System.out.println("updateBrandInfo 파라미터 : " + map);

		return (int) update("brandPage.updateBrandInfo", map);
	}

	// 브랜드 입점 매장 리스트(5줄) - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectShopList(Map<String, Object> map) throws Exception {
		System.out.println("selectShopList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectPagingList("brandPage.selectShopList", map);
	}

	// 브랜드 입점 매장 토탈 개수 (int 타입으로 리턴)
	public int selectShopCount(Map<String, Object> map) throws Exception {
		System.out.println("selectShopCount 파라미터 : " + map);

		return (int) selectOne("brandPage.selectShopCount", map);
	}

	// 브랜드 매장 입점 요청 리스트 = 매장 가입 승인 리스트(아직 승인 전. 5줄) - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectRequestShopList(Map<String, Object> map) throws Exception {
		System.out.println("selectRequestShopList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectPagingList("brandPage.selectRequestShopList", map);
	}

	// 브랜드 입점 요청 매장 토탈 개수 (아직 승인 전) (int 타입으로 리턴)
	public int selectRequestShopCount(Map<String, Object> map) throws Exception {
		System.out.println("selectRequestShopCount 파라미터 : " + map);

		return (int) selectOne("brandPage.selectRequestShopCount", map);
	}

	// 브랜드 매장 입점 요청 승인 - update()
	public int updateShopJoinApprove(Map<String, Object> map) throws Exception {
		System.out.println("updateShopJoinApprove 파라미터 : " + map);

		return (int) update("brandPage.updateShopJoinApprove", map);
	}

	// 브랜드 매장 입점 요청 거부 - update()
	public int updateShopJoinReject(Map<String, Object> map) throws Exception {
		System.out.println("updateShopJoinReject 파라미터 : " + map);

		return (int) update("brandPage.updateShopJoinReject", map);
	}

	// 브랜드가 입점한 매장 삭제(탈퇴) - update()
	// 트리거 사용해서 상품 테이블에 있는 해당 매장 상품들도 모두 삭제
	public int deleteShop(Map<String, Object> map) throws Exception {
		System.out.println("deleteShop 파라미터 : " + map);

		return (int) update("brandPage.deleteShop", map);
	}

	// 브랜드 입점/입점요청 매장 위치 조회 - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectShopLocationInfo(Map<String, Object> map) throws Exception {
		System.out.println("selectShopLocationInfo 파라미터 : " + map);

		return (Map<String, Object>) selectOne("brandPage.selectShopLocationInfo", map);
	}

	// 브랜드관 상품 썸네일 이미지 조회 (image order 1) - selectOne()
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGoodsThumbnail(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsThumbnail 파라미터 : " + map);

		return (Map<String, Object>) selectOne("brandPage.selectGoodsThumbnail", map);
	}

	// 브랜드관 최신 상품 조회 (최신 상품 5개) - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNewGoodsList(Map<String, Object> map) throws Exception {
		System.out.println("selectNewGoodsList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("brandPage.selectNewGoodsList", map);
	}

	// 브랜드관 랭킹 5인 상품(인기상품 5개) 조회 - selectList()
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsRankingList(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsRankingList 파라미터 : " + map);

		return (List<Map<String, Object>>) selectList("brandPage.selectGoodsRankingList", map);
	}

}
