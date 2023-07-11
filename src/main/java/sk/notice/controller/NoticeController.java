package sk.notice.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import sk.notice.service.NoticeService;

@RestController
public class NoticeController {

	@Resource(name = "noticeService")
	private NoticeService noticeService;

	Log log = LogFactory.getLog(this.getClass());

	@RequestMapping(value = "/noticeList")
	public ModelAndView noticeList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### noticeList ######");
		ModelAndView mv = new ModelAndView("noticeList");

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

	@RequestMapping(value = "/noticeList/paging")
	public ModelAndView selectBoardList(@RequestParam Map<String, Object> map) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> list = noticeService.selectNoticeList(map);
		mv.addObject("list", list);
		if (list.size() > 0) {
			int count = noticeService.selectNoticeCount(map);
			mv.addObject("TOTAL", count);
		} else {
			mv.addObject("TOTAL", 0);
		}

		return mv;
	}

	@RequestMapping(value = "/noticeDetail")
	public ModelAndView noticeDetail(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### noticeDetail ######");
		ModelAndView mv = new ModelAndView("noticeDetail");

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

		Map<String, Object> noticeDetail = noticeService.selectNoticeDetail(map);
		mv.addObject("noticeDetail", noticeDetail);

		return mv;
	}
}
