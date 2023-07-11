package sk.admin.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import sk.admin.service.AdminBoardService;

@Controller
public class AdminBoardController {

	@Resource(name = "adminBoardService")
	private AdminBoardService adminBoardService;

	Log log = LogFactory.getLog(this.getClass());

	@GetMapping(value = "/admin/noticeList")
	public ModelAndView adminNoticeList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 공지사항 리스트 ##########");
		ModelAndView mv = new ModelAndView("adminNoticeList");

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

	@PostMapping(value = "/admin/noticeList/paging")
	public ModelAndView adminNoticeListPaging(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 공지사항 리스트 페이징 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> noticeList = adminBoardService.selectNoticeList(map);
		mv.addObject("noticeList", noticeList);
		int TOTAL = 0;
		if (noticeList.size() > 0) {
			TOTAL = adminBoardService.selectNoticeCount(map);
		} else {
			TOTAL = 0;
		}
		mv.addObject("TOTAL", TOTAL);

		System.out.println("map: " + map);
		return mv;
	}

	@GetMapping(value = "/admin/noticeDetail")
	public ModelAndView adminNoticeDetail(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 공지사항 상세보기 ##########");
		ModelAndView mv = new ModelAndView("adminNoticeDetail");

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

		System.out.println("map: " + map);

		Map<String, Object> noticeDetail = adminBoardService.selectNoticeDetail(map);
		mv.addObject("noticeDetail", noticeDetail);
		return mv;
	}

	@GetMapping(value = "/admin/noticeWriteForm")
	public ModelAndView adminNoticeWriteForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 공지사항 작성 폼 ##########");
		ModelAndView mv = new ModelAndView("adminNoticeWriteForm");

		return mv;
	}

	@ResponseBody
	@PostMapping(value = "/admin/noticeWrite")
	public int adminNoticeWrite(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 공지사항 작성 ##########");

		int result = adminBoardService.insertNotice(map);
		return result;

	}

	@GetMapping(value = "/admin/noticeModifyForm")
	public ModelAndView adminNoticeModifyForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 공지사항 수정 폼 ##########");
		ModelAndView mv = new ModelAndView("adminNoticeModifyForm");

		Map<String, Object> noticeDetail = adminBoardService.selectNoticeDetail(map);
		mv.addObject("noticeDetail", noticeDetail);

		return mv;
	}

	@ResponseBody
	@PostMapping(value = "/admin/noticeModify")
	public int adminNoticeModify(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 공지사항 수정 ##########");

		int result = adminBoardService.updateNoticeModify(map);
		return result;

	}

	@ResponseBody
	@PostMapping(value = "/admin/noticeDelete")
	public int adminDeleteNotice(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 공지 사항 삭제 ##########");

		int result = adminBoardService.adminDeleteNotice(map);
		return result;
	}

	@GetMapping(value = "/admin/goodsTotalList")
	public ModelAndView adminGoodsTotalList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 상품 전체 리스트 ##########");
		ModelAndView mv = new ModelAndView("adminGoodsTotalList");

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

	@PostMapping(value = "/admin/goodsTotalList/paging")
	public ModelAndView adminGoodsTotalListPaging(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 상품 전체 리스트 페이징 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> resultList = adminBoardService.selectTotalGoodsList(map);
		int count = 0;
		if (resultList.size() > 0) {
			count = adminBoardService.selectTotalGoodsListCount(map);
		} else {
			count = 0;
		}

		mv.addObject("list", resultList);
		mv.addObject("TOTAL", count);

		return mv;
	}

	@PostMapping(value = "/admin/goodsDelete")
	public ModelAndView adminDeleteGoods(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 상품 삭제 ##########");
		ModelAndView mv = new ModelAndView("jsonView");
		int result = adminBoardService.adminDeleteGoods(map);
		String message = null;
		if (result > 0) {
			message = "success";
		} else if (result == 0) {
			message = "fail";
		}
		mv.addObject("result", message);
		return mv;
	}

}
