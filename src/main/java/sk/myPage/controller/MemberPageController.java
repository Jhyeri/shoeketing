package sk.myPage.controller;

 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.myPage.service.MemberPageService;

@RestController
public class MemberPageController {
	
	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "memberPageService")
	private MemberPageService memberPageService;
	
	@Resource(name="sessionService")
	private CommonService sessionService;
	
	
	//마이페이지 메인
	@RequestMapping(value="/myPage")
	public ModelAndView myPageMain(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("----------- 일반회원 마이페이지 메인 ----------");
		
		ModelAndView mv = new ModelAndView("myPageMain");
		
		return mv;
	}
	
	//회원정보 수정 폼
	@RequestMapping(value="/myPage/accountModifyForm")
	public ModelAndView accountModifyForm(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("----------- 일반회원 회원정보 수정 폼 ----------");
		
		ModelAndView mv = new ModelAndView("accountModifyForm");
		Map<String, Object> resultMap = new HashMap<>();
				
		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM")); //세션의 회원번호를 map에 저장
		resultMap = memberPageService.selectAccountInfo(map); //쿼리실행
		System.out.println("selectAccountInfo 조회결과 : "+ resultMap);
		
		//출력할 때 폰번호 자리 나누기
		String phone = (String)resultMap.get("MEM_PHONE");
		String phone1 = phone.substring(0, 3);
		String phone2 = phone.substring(3, 7);
		String phone3 = phone.substring(7, 11);
		String phoneNum = phone1+"-"+phone2+"-"+phone3;
		System.out.println("출력될 폰 번호 : " + phoneNum);
		resultMap.put("MEM_PHONE", phoneNum);
		
		mv.addObject("MEM_INFO", resultMap);
		
		return mv;
	}
	
	//회원정보 수정
	@PostMapping(value="/myPage/accountModify")
	public void accountModify(@RequestParam(value="agreeCheck", required=false) boolean check, @RequestParam Map<String, Object> map) throws Exception {
		log.debug("----------- 일반회원 회원정보 수정 처리 ----------");
		
		
		//알림 동의 체크박스
		if(check) { //체크했으면
			map.put("MEM_INFORM_AGREE", "Y");
		} else {
			map.put("MEM_INFORM_AGREE", "N");
		}
		
		memberPageService.accountModify(map);
		
	}

	//회원 탈퇴 폼
	@GetMapping(value="/myPage/accountDeleteForm")
	public ModelAndView accountDeleteForm(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("----------- 일반회원 탈퇴 페이지 ----------");
		ModelAndView mv = new ModelAndView("accountDeleteForm");
		
		return mv;

	}
	 
	//비밀번호 확인
	@PostMapping(value="/myPage/accountDeleteForm", consumes = MediaType.APPLICATION_JSON_VALUE)
	//consumes = 전송 받을 데이터 타입이 json
	public Map<String, Object> checkPw(@RequestBody Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("----------- 일반회원 회원 비밀번호 확인 ----------");
		String dbPw = ""; 
		String pw ="";
		int count = 0;
		Map<String, Object> result = new HashMap<>();
		map.put("MEM_EMAIL", (String)session.getAttribute("session_MEM_ID"));
		
			//DB에서 비밀번호 꺼내오기
			dbPw = String.valueOf(memberPageService.pwCheck(map).get("MEM_PW"));
			//입력한 비밀번호
			pw = String.valueOf(map.get("MEM_PW").toString());
			System.out.println("DB 비밀번호 : " + dbPw + ", 입력한 비밀번호 : " + pw);
			
			if(dbPw.equals(pw)) { //비밀번호가 일치하면
				
				//예약상태가 픽업대기중인 건의 개수를 확인
				map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
				
				count = memberPageService.selectReservationStatus(map); //쿼리실행
				
					if(count>0) { //픽업대기중인 예약건이 있다면 탈퇴 불가
					result.put("result", "deleteFail" );
					} else { //픽업대기중인 예약건이 없다면 탈퇴 가능
						result.put("result", "success");
					}
				
			} else if(!dbPw.equals(pw)) { //비밀번호가 일치하지 않으면
				result.put("result", "pwfail");
			}
			
			System.out.println(result.get("result").toString());
			
		return result;
	}

	//탈퇴 처리
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/myPage/accountDelete")
	public void accountDelete(HttpSession session) throws Exception {
		log.debug("----------- 일반회원 회원 탈퇴 처리 ----------");
		Map<String, Object> map= new HashMap<>();
			
		if(session != null) {
			map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
			memberPageService.deleteAccount(map); //탈퇴 처리
			session.invalidate();//탈퇴 후 로그아웃 처리
		}
	}
	
	//찜목록 (빈 JSP 사용)
	@GetMapping(value="/myPage/goodsLikeList")
	public ModelAndView goodsLikeList(HttpServletRequest request, HttpSession session, Map<String, Object> map) throws Exception {
		log.debug("----------- 찜 목록 ----------");
		ModelAndView mv = new ModelAndView("goodsLikeList");
		
	
		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
	
		int count = memberPageService.goodsLikeCount(map);
		
		mv.addObject("goodsLikeCount", count);
		
		return mv;
		
	}
	
	//찜목록 페이징
	@PostMapping(value="/myPage/goodsLikeList/paging")
	public ModelAndView goodsLikeListPaging(HttpServletRequest request, HttpSession session) throws Exception {
		log.debug("----------- 찜 목록 페이징 ----------");
		ModelAndView mv = new ModelAndView("jsonView");
		Map<String, Object> map = new HashMap<>();
		List<Map<String, Object>> goodsLikeList = new ArrayList<>();
		

		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
		goodsLikeList = memberPageService.goodsLikeList(map);
		mv.addObject("goodsLikeList", goodsLikeList);

		
		//찜 개수
		int count = memberPageService.goodsLikeCount(map);
		mv.addObject("TOTAL", count);
		
		return mv;
	}
	
	//찜취소
	@GetMapping(value="/myPage/goodsUnlike", consumes = MediaType.APPLICATION_JSON_VALUE)
	public void goodsUnlike(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("----------- 찜 취소 ----------");

		System.out.println("찜 취소 파라미터 : " + map);
		
		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
		//찜 취소 처리 (delete처리)
		memberPageService.deleteGoodsLike(map);
		
		//TOTAL_GOODS_LIKE_COUNT -1처리
		memberPageService.updateGoodsLikeCountDecrease(map);
		
	}

	
	
}
