package sk.review.service;

import java.util.Map;

public interface ReviewService {

	public void insertReview(Map<String, Object> map) throws Exception;
	
	public void updateGoodsReviewScoreAvg(Map<String, Object> map) throws Exception;
	
	public int selectReviewCount(Map<String, Object> map) throws Exception;
}
