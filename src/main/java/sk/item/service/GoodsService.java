package sk.item.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

public interface GoodsService {

	// 브랜드 전체 상품 리스트
	public List<Map<String, Object>> selectBrandGoodsList(Map<String, Object> map) throws Exception;

	// 브랜드 전체 상품 토탈 개수
	public int selectBrandGoodsCount(Map<String, Object> map) throws Exception;

	// 브랜드 상품 등록
	public Map<String, Object> insertGoods(Map<String, Object> map, HttpSession session, MultipartFile[] uploadFile, List<String> goodsSizeList)
			throws Exception;

	// 상품 등록시, 상품 상세(사이즈) 삽입
	public int insertGoodsDetail(Map<String, Object> map) throws Exception;

	// 상품 등록시, 상품 이미지 삽입
	public int insertGoodsImage(Map<String, Object> map, MultipartFile[] uploadGoodsImg) throws Exception;

	// 브랜드에 해당하는 매장 이름 및 매장번호 조회
	public List<Map<String, Object>> selectShopNumName(Map<String, Object> map) throws Exception;

	// 브랜드가 상품 등록시, 해당 브랜드의 매장들도 상품 등록
	public int insertShopGoodsAddByBrand(Map<String, Object> map) throws Exception;
	
//	// 상품 이미지 삭제 deleteGoodsImage
//	public int deleteGoodsImage(Map<String, Object> map) throws Exception;
	
	// 상품 삭제- 상품, 이미지, 사이즈 (deleteGoods + deleteGoodsImage + deleteGoodsDetail)
	public Map<String, Object> deleteGoods(Map<String, Object> map) throws Exception;
	
	// 상품 수정- 이미지, 사이즈 (updateGoodsImageModify + updateGoodsModify)
	public Map<String, Object> updateGoods(MultipartFile[] uploadGoodsImg, Map<String, Object> map, List<String> goodsSizeList, HttpSession session) throws Exception;
	
//	// 상품 이미지 수정 
//	public int updateGoodsImageModify(Map<String, Object> map) throws Exception;
//	
//	// 상품 수정 (상품 상세정보 수정,사이즈만 따로)
//	public int updateGoodsModify(Map<String, Object> map) throws Exception;
	
//	// 상품 상세 삭제(상품 수정시, 원래 선택되어 있던 사이즈 전체 삭제) 
//	public int deleteGoodsDetail(Map<String, Object> map) throws Exception;

	// 해당 제품에 해당하는 사이즈 재고 1개라도 있는 매장 총 개수
	public int selectShopCountFromStockOfSize(Map<String, Object> map) throws Exception;
	
	// 해당 제품에 해당하는 사이즈 재고 총 개수
	public int selectGoodsAmountFromStockOfSize(Map<String, Object> map) throws Exception;
	
	//브랜드가 해당 상품 사이즈 삭제할경우 (매장재고 0이라는 가정 하) 매장별 상품 삭제
	public int deleteShopGoodsFromDeleteByBrand(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectAllGoodsList(Map<String, Object> map) throws Exception;

	int selectAllGoodsCount(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectAllBrandList(Map<String, Object> map) throws Exception;

	public List<String> selectBrandList(Map<String, Object> map) throws Exception;

	public int selectGoodsLike(Map<String, Object> map) throws Exception;

	public Map<String, Object> selectBrandDetail(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectGoodsDetail(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectGoodsImage(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> selectReviewDetail(Map<String, Object> map) throws Exception;

	public Map<String, Object> selectReviewPercent(Map<String, Object> map) throws Exception;

	public int insertGoodsLike(Map<String, Object> map) throws Exception;

	public int deleteGoodsLike(Map<String, Object> map) throws Exception;

	public int updateGoodsLikeCountIncrease(Map<String, Object> map) throws Exception;

	public int updateGoodsLikeCountDecrease(Map<String, Object> map) throws Exception;
}