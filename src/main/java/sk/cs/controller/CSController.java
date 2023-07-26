package sk.cs.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.cs.service.CSService;

@RestController
public class CSController {
	
	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "csService")
	private CSService csService;

	// 세션의 정보를 가져오기 위해
	@Resource(name = "sessionService")
	private CommonService sessionService;

	
	//문의 내역 리스트 (빈 JSP 사용)
	@GetMapping(value="/myPage/csList")
	public ModelAndView csList(Map<String, Object> map, HttpSession session) throws Exception { 
			log.debug("###### 나의 문의내역 ######");
			ModelAndView mv = new ModelAndView("csList");
			
			return mv;
			
	}
	
	// 나의 문의 리스트
	@PostMapping(value = "/myPage/csList/paging")
	public ModelAndView csListPaging(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 나의 문의내역 페이징 ######");
		ModelAndView mv = new ModelAndView("jsonView"); // View 설정

		// 세션의 MEM_NUM을 map에 넣어주기
		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));
		System.out.println("CSList 컨트롤러 map : " + map);

		// 리스트 가져오는 쿼리 실행
		List<Map<String, Object>> list = csService.selectCSList(map);
		
		//댓글 리스트 가져오기 (처리상태 구분을 위해 필요)
		List<Map<String, Object>> csList = new ArrayList<>();
		Map<String, Object> replyMap = new HashMap<>();
	
		for(Map<String, Object> cs : list) {
			replyMap = csService.selectCSReply(cs);
			
			if(replyMap != null && !replyMap.isEmpty()) {
				Map<String, Object> csMap = new HashMap<>();
				csMap.put("CS_STATUS", "답변 완료");
				csMap.put("CS_DATE", cs.get("CS_DATE"));
				csMap.put("CS_NUM", cs.get("CS_NUM"));
				csMap.put("CS_TITLE", cs.get("CS_TITLE"));
				csList.add(csMap);
			} else {
				Map<String, Object> csMap = new HashMap<>();
				csMap.put("CS_STATUS", "답변 대기");
				csMap.put("CS_DATE", cs.get("CS_DATE"));
				csMap.put("CS_NUM", cs.get("CS_NUM"));
				csMap.put("CS_TITLE", cs.get("CS_TITLE"));
				csList.add(csMap);
			}
			System.out.println("csList : " + csList);	
		}
		
		int count = csService.SelectCSCount(map);
		
		mv.addObject("CSList", csList);
		mv.addObject("TOTAL", count);

		return mv;
	}

	// 문의 작성 폼
	@RequestMapping(value = "/myPage/csWriteForm")
	public ModelAndView csWriteForm(Map<String, Object> map) throws Exception {
		log.debug("###### 문의 작성 폼 ######");
		ModelAndView mv = new ModelAndView("csWriteForm");

		return mv;
	}
	
	
	//문의할 매장찾기 (빈 JSP 사용)
	@GetMapping(value="/myPage/findShop")
	public ModelAndView findShop(Map<String, Object> map) throws Exception {
		log.debug("###### 문의 작성 폼 매장 리스트 가져오기 ######");
		ModelAndView mv = new ModelAndView("jsonView");
		
		return mv;
	}
	
	//문의할 매장찾기 (지점 리스트 가져오기)
	@PostMapping(value="/myPage/findShop/paging")
	public ModelAndView findShopPaging(@RequestParam String keyword) throws Exception {
		log.debug("###### 문의 작성 폼 매장 리스트 가져오기 ######");
		ModelAndView mv = new ModelAndView("jsonView");
		
		Map<String, Object> map = new HashMap<>();
		
		if(keyword != null && !keyword.equals("")) {
			System.out.println("keyword : " + keyword);
			keyword.trim();
			map.put("keyword", keyword);
		}
		
		//지점 리스트 가져오기
		List<Map<String, Object>> shopList = csService.selectShopList(map);
		System.out.println("shopList map : " + shopList);
		
		//지점 수 가져오기
		int count = csService.selectShopCount(map);
		
		mv.addObject("shopList", shopList);
		mv.addObject("TOTAL", count);
		
		return mv;
	}
	
	//문의할 매장찾기 (지점 리스트 가져오기) - AJAX
	@RequestMapping(value="/myPage/findShopAjax")
	public ModelAndView findShopAjax(@RequestParam String keyword) throws Exception {
		log.debug("###### 문의 작성 폼 매장 찾기 ajax ######");
		ModelAndView mv = new ModelAndView("shopList_ajax");
		
		Map<String, Object> map = new HashMap<>();
		
		if(keyword != null && !keyword.equals("")) {
			keyword.trim();
			map.put("keyword", keyword);
		}
		
		//지점 리스트 가져오기
		List<Map<String, Object>> shopList = csService.selectShopList(map);
		System.out.println("shopList map : " + shopList);
		
		mv.addObject("shopList", shopList);
		
		return mv;
	}
	
	@RequestMapping(value= "/myPage/csDetail")
	public ModelAndView csDetail(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 문의 상세보기 ######");
		ModelAndView mv = new ModelAndView("jsonView");
		  
		System.out.println("csDetail map : " + map);
		//글내용 가져오기
		Map<String, Object> resultMap = csService.selectCSDetail(map);
		
		//댓글 가져오기
		Map<String, Object> replyMap = csService.selectCSReply(map);
		//CS_REPLY_NUM도 가져오지만 필요하지 않기 때문에 댓글내용만 꺼내서 resultMap에 추가함
		if(replyMap != null && !replyMap.isEmpty()) {
			resultMap.put("CS_REPLY_CONTENT", replyMap.get("CS_REPLY_CONTENT").toString());
		}
		
		System.out.println("resultMap : " + resultMap);
		
		mv.addObject("result",resultMap);
		
		return mv;
	}
	
	@RequestMapping(value="/myPage/csWrite")
	public void csWrite(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 문의글 등록 ######");
		System.out.println("csWrite 파라미터 : " + map);
		
		//현재 로그인한 사용자를 작성자로 맵에 저장
		map.put("CS_WRITER", sessionService.getSession(session, "MEM_NUM"));
		System.out.println("csWrite map : " + map);
		csService.insertCS(map);
	}
	
	
	@RequestMapping(value="/myPage/csDelete")
	public void csDelete(@RequestBody Map<String, Object> map) throws Exception {
		log.debug("###### 문의 삭제 ######");
		
		System.out.println("csDelete map : " + map);

		csService.deleteCS(map);
	}

}
