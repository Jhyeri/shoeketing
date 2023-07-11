package sk.item.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import sk.common.dao.AbstractDAO;

@Repository("goodsDAO")
public class GoodsDAO extends AbstractDAO {

	// 브랜드 전체 상품 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBrandGoodsList(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandGoodsList : " + map);

		return (List<Map<String, Object>>) selectPagingList("goods.selectBrandGoodsList", map);
	}

	// 브랜드 전체 상품 토탈 개수
	public int selectBrandGoodsCount(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandGoodsCount : " + map);

		return (int) selectOne("goods.selectBrandGoodsCount", map);
	}

	// 브랜드 상품 등록
	public int insertGoods(Map<String, Object> map) throws Exception {
		System.out.println("insertGoods : " + map);

		return (int) insert("goods.insertGoods", map);
	}

	// 상품 등록시, 상품 상세(사이즈) 삽입
	public int insertGoodsDetail(Map<String, Object> map) throws Exception {
		System.out.println("insertGoodsDetail : " + map);

		return (int) insert("goods.insertGoodsDetail", map);
	}

	// 상품 등록시, 상품 이미지 삽입
	public int insertGoodsImage(Map<String, Object> map) throws Exception {
		System.out.println("insertGoodsImage : " + map);

		return (int) insert("goods.insertGoodsImage", map);
	}

	// 브랜드에 해당하는 매장 이름 및 매장번호 조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectShopNumName(Map<String, Object> map) throws Exception {
		System.out.println("selectShopNumName : " + map);
		return (List<Map<String, Object>>) selectList("goods.selectShopNumName", map);
	}

	// 브랜드가 상품 등록시, 해당 브랜드의 매장들도 상품 등록
	public int insertShopGoodsAddByBrand(Map<String, Object> map) throws Exception {
		System.out.println("insertShopGoodsAddByBrand : " + map);

		return (int) insert("goods.insertShopGoodsAddByBrand", map);
	}
	
	public int deleteGoods(Map<String, Object> map) throws Exception {
		System.out.println("deleteGoods : " + map);

		return (int) update("goods.deleteGoods", map);
	}

	// 상품 이미지 삭제 deleteGoodsImage
	public int deleteGoodsImage(Map<String, Object> map) throws Exception {
		System.out.println("deleteGoodsImage : " + map);

		return (int) update("goods.deleteGoodsImage", map);
	}

	// 상품 이미지 수정
	public int updateGoodsImageModify(Map<String, Object> map) throws Exception {
		System.out.println("updateGoodsImageModify : " + map);

		return (int) update("goods.updateGoodsImageModify", map);
	}

	// 상품 수정 (상품 상세정보 수정,사이즈만 따로)
	public int updateGoodsModify(Map<String, Object> map) throws Exception {
		System.out.println("updateGoodsModify : " + map);

		return (int) update("goods.updateGoodsModify", map);
	}

	// 상품 상세 삭제(상품 수정시, 원래 선택되어 있던 사이즈 전체 삭제)
	public int deleteGoodsDetail(Map<String, Object> map) throws Exception {
		System.out.println("deleteGoodsDetail : " + map);

		return (int) delete("goods.deleteGoodsDetail", map);
	}
	
	// 해당 제품에 해당하는 사이즈 재고 1개라도 있는 매장 총 개수
	public int selectShopCountFromStockOfSize(Map<String, Object> map) throws Exception {
		System.out.println("selectShopCountFromStockOfSize : " + map);

		return (int) selectOne("goods.selectShopCountFromStockOfSize", map);
	}
	
	// 해당 제품에 해당하는 사이즈 재고 총 개수
	public int selectGoodsAmountFromStockOfSize(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsAmountFromStockOfSize : " + map);

		return (int) selectOne("goods.selectGoodsAmountFromStockOfSize", map);
	}
	
	//브랜드가 해당 상품 사이즈 삭제할경우 (매장재고 0이라는 가정 하) 매장별 상품 삭제
	public int deleteShopGoodsFromDeleteByBrand(Map<String, Object> map) throws Exception{
		System.out.println("deleteShopGoodsFromDeleteByBrand : " + map);
		
		return (int) delete("goods.deleteShopGoodsFromDeleteByBrand", map);
	}


	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllGoodsList(Map<String, Object> map) throws Exception {
		System.out.println("allGoodsList : " + map);
		return (List<Map<String, Object>>) selectPagingList("goods.selectAllGoodsList", map);
	}

	public int selectAllGoodsCount(Map<String, Object> map) throws Exception {
		System.out.println("selectAllGoodsCount : " + map);
		return (int) selectOne("goods.selectAllGoodsCount", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllBrandList(Map<String, Object> map) throws Exception {
		System.out.println("selectAllBrandList : " + map);
		return (List<Map<String, Object>>) selectList("goods.selectAllBrandList", map);
	}

	@SuppressWarnings("unchecked")
	public List<String> selectBrandList(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandList : " + map);
		return (List<String>) selectList("goods.selectBrandList", map);
	}

	public int selectGoodsLike(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsLike : " + map);
		return (int) selectOne("goods.selectGoodsLike", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBrandDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectBrandDetail : " + map);
		return (Map<String, Object>) selectOne("goods.selectBrandDetail", map);
	}

	// 브랜드 상품 상세조회
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsDetail : " + map);
		return (List<Map<String, Object>>) selectList("goods.selectGoodsDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoodsImage(Map<String, Object> map) throws Exception {
		System.out.println("selectGoodsDetail : " + map);
		return (List<Map<String, Object>>) selectList("goods.selectGoodsImage", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReviewDetail(Map<String, Object> map) throws Exception {
		System.out.println("selectReviewDetail : " + map);
		return (List<Map<String, Object>>) selectList("goods.selectReviewDetail", map);
	}

	public int selectReviewCount(Map<String, Object> map) throws Exception {
		System.out.println("selectReviewCount : " + map);
		return (int) selectOne("goods.selectReviewCount", map);
	}

	public int insertGoodsLike(Map<String, Object> map) throws Exception {
		System.out.println("insertGoodsLike : " + map);
		return (int) insert("goods.insertGoodsLike", map);
	}

	public int deleteGoodsLike(Map<String, Object> map) throws Exception {
		System.out.println("deleteGoodsLike : " + map);
		return (int) delete("goods.deleteGoodsLike", map);
	}

	public int updateGoodsLikeCountIncrease(Map<String, Object> map) throws Exception {
		System.out.println("updateGoodsLikeCountIncrease : " + map);
		return (int) update("goods.updateGoodsLikeCountIncrease", map);
	}

	public int updateGoodsLikeCountDecrease(Map<String, Object> map) throws Exception {
		System.out.println("updateGoodsLikeCountDecrease : " + map);
		return (int) update("goods.updateGoodsLikeCountDecrease", map);
	}
}
