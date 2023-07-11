package sk.review.controller;


import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import sk.common.service.CommonService;
import sk.review.service.ReviewService;

@RestController
public class ReviewController {

	Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name="reviewService")
	private ReviewService reviewService;
	
	// 세션의 정보를 가져오기 위해
	@Resource(name = "sessionService")
	private CommonService sessionService;
	
	@RequestMapping(value="/myPage/reviewWrite")
	public void reviewWrite(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 리뷰 등록하기 ######");
		
		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
		System.out.println("reviewWrite 컨트롤러 map : " + map);
		
		//리뷰 등록 처리
		reviewService.insertReview(map);
		
		//리뷰 평점 평균 계산
		reviewService.updateGoodsReviewScoreAvg(map);
		
	}
	
	//리뷰 작성여부 검사 (리뷰 1회만 작성 가능)
	@RequestMapping(value="/myPage/checkReviewExists")
	public int checkReviewExists(@RequestBody Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 리뷰 작성여부 검사하기 ######");
		
		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
		
		return reviewService.selectReviewCount(map);
	}
	
	
	
}
