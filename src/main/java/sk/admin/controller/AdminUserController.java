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
import org.springframework.web.servlet.ModelAndView;

import sk.admin.service.AdminUserService;

@Controller
public class AdminUserController {

	@Resource(name = "adminUserService")
	private AdminUserService adminUserService;

	Log log = LogFactory.getLog(this.getClass());

	@GetMapping(value = "/admin/memberList")
	public ModelAndView adminMemberList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 일반회원 리스트 ##########");
		ModelAndView mv = new ModelAndView("adminMemberList");

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

	@PostMapping(value = "/admin/memberList/paging")
	public ModelAndView adminMemberListPaging(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 일반회원 리스트 페이징 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> memberList = adminUserService.selectMemberList(map);
		mv.addObject("memberList", memberList);

		int TOTAL = 0;
		if (memberList.size() > 0) {
			TOTAL = adminUserService.selectMemberCount(map);
		} else {
			TOTAL = 0;
		}
		mv.addObject("TOTAL", TOTAL);

		System.out.println("map: " + map);

		return mv;
	}

	@GetMapping(value = "/admin/memberDetail")
	public ModelAndView adminMemberDetail(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 일반회원 상세보기 ##########");
		ModelAndView mv = new ModelAndView("adminMemberDetail");

		Map<String, Object> memberMap = adminUserService.selectMemberDetail(map);
		mv.addObject("memberMap", memberMap);

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

	@PostMapping(value = "/admin/memberDelete")
	public ModelAndView adminMemberDelete(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 일반회원 탈퇴 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		int result = adminUserService.deleteMember(map);
		mv.addObject("result", result);

		return mv;
	}

	@GetMapping(value = "/admin/shopList")
	public ModelAndView adminShopList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 매장회원 리스트 ##########");
		ModelAndView mv = new ModelAndView("adminShopList");

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

	@PostMapping(value = "/admin/shopList/paging")
	public ModelAndView adminShopListPaging(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 매장회원 리스트 페이징 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> shopList = adminUserService.selectShopList(map);
		mv.addObject("shopList", shopList);

		int TOTAL = 0;
		if (shopList.size() > 0) {
			TOTAL = adminUserService.selectShopCount(map);
		} else {
			TOTAL = 0;
		}
		mv.addObject("TOTAL", TOTAL);

		System.out.println("map: " + map);

		return mv;
	}

	@GetMapping(value = "/admin/shopDetail")
	public ModelAndView adminShopDetail(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 매장회원 상세보기 ##########");
		ModelAndView mv = new ModelAndView("adminShopDetail");

		Map<String, Object> shopMap = adminUserService.selectShopDetail(map);
		mv.addObject("shopMap", shopMap);

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

	@PostMapping(value = "/admin/shopDelete")
	public ModelAndView adminShopDelete(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 매장회원 탈퇴 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		int result = adminUserService.deleteShop(map);
		mv.addObject("result", result);

		return mv;
	}

	@GetMapping(value = "/admin/brandList")
	public ModelAndView adminBrandList(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 브랜드회원 리스트 ##########");
		ModelAndView mv = new ModelAndView("adminBrandList");

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

	@PostMapping(value = "/admin/brandList/paging")
	public ModelAndView adminBrandListPaging(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 브랜드회원 리스트 페이징 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		List<Map<String, Object>> brandList = adminUserService.selectBrandList(map);
		mv.addObject("brandList", brandList);

		int TOTAL = 0;
		if (brandList.size() > 0) {
			TOTAL = adminUserService.selectBrandCount(map);
		} else {
			TOTAL = 0;
		}
		mv.addObject("TOTAL", TOTAL);

		System.out.println("map: " + map);

		return mv;
	}

	@GetMapping(value = "/admin/brandDetail")
	public ModelAndView adminBrandDetail(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 브랜드회원 상세보기 ##########");
		ModelAndView mv = new ModelAndView("adminBrandDetail");

		Map<String, Object> brandMap = adminUserService.selectBrandDetail(map);
		mv.addObject("brandMap", brandMap);

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

	@PostMapping(value = "/admin/brandDelete")
	public ModelAndView adminBrandDelete(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("######### 관리자 페이지 브랜드회원 탈퇴 ##########");
		ModelAndView mv = new ModelAndView("jsonView");

		int result = adminUserService.deleteBrand(map);
		mv.addObject("result", result);

		return mv;
	}
}
