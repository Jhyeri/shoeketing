package sk.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import sk.myPage.service.ShopPageService;
import sk.user.service.LoginService;

@RestController
public class LoginController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "loginService")
	private LoginService loginService;

	@Resource(name = "shopPageService")
	private ShopPageService shopPageService;

	@GetMapping(value = "/loginSelect/member")
	public ModelAndView loginSelectMember(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 일반로그인 선택 페이지 ######");
		ModelAndView mv = new ModelAndView("loginSelectMember");
		return mv;
	}

	@GetMapping(value = "/loginSelect/shop")
	public ModelAndView loginSelectShop(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장회원 로그인 선택 페이지 ######");
		ModelAndView mv = new ModelAndView("loginSelectShop");
		return mv;
	}

	@GetMapping(value = "/loginSelect/brand")
	public ModelAndView loginSelectBrand(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드회원 로그인 선택 페이지 ######");
		ModelAndView mv = new ModelAndView("loginSelectBrand");
		return mv;
	}

	@GetMapping(value = "/loginSelect")
	public ModelAndView loginSelect(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 회원 로그인 선택 페이지 ######");
		ModelAndView mv = new ModelAndView("loginSelect");
		return mv;
	}

	@GetMapping(value = "/memberLoginForm")
	public ModelAndView memberLoginForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 일반 회원 로그인 폼 ######");
		ModelAndView mv = new ModelAndView("memberLoginForm");
		return mv;
	}

	@PostMapping(value = "/memberLogin")
	public String login(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		log.debug("###### 로그인 ######");
		// ModelAndView mv = new ModelAndView("jsonView");
		String result = "";
		System.out.println("로그인 요청에 들어온 Map : " + map.toString());

		// 입력받은 아이디를 꺼내 변수 id에 저장
		Map<String, Object> member = loginService.selectId(map);
		log.debug("아이디 : " + (String) map.get("MEM_EMAIL"));

		HttpSession session = request.getSession();

		if (member == null) { // 가져온 데이터가 없으면
			result = "emailfail";
			log.debug("맵이 비어있음");
		} else { // 가져온 데이터가 있으면
			if (member.get("MEM_PW").equals(map.get("MEM_PW"))) { // 비밀번호 비교
				// 세션영역에 회원정보 올리기
				session.setAttribute("session_MEM_ID", map.get("MEM_EMAIL"));
				session.setAttribute("session_MEM_PW", map.get("MEM_PW"));
				session.setAttribute("session_MEM_INFO", member);
				session.setAttribute("session_MEM_GRADE", member.get("MEM_GRADE"));
				session.setAttribute("session_MEM_ADMIN", member.get("MEM_ADMIN"));

				// 로그인 유지 체크했을 경우
				if (map.get("useCookie") != null) {
					log.debug("############# 로그인 유지 체크");
					System.out.println("로그인 유지 체크 여부 : " + map.get("useCookie"));

					// 쿠키 생성
					Cookie cookie1 = new Cookie("emailCookie", (String) map.get("MEM_EMAIL"));
					Cookie cookie2 = new Cookie("pwCookie", (String) map.get("MEM_PW"));

					// 쿠키에 대한 설정
					Cookie[] cookies = { cookie1, cookie2 };
					for (int i = 0; i < cookies.length; i++) {
						// 유효시간 설정 (일주일)
						cookies[i].setMaxAge(60 * 60 * 24 * 7);

						cookies[i].setHttpOnly(true);

						// 쿠키 경로 설정
						cookies[i].setPath("/");

						// response로 쿠키 전달
						response.addCookie(cookies[i]);
					}
				}
				result = "success";

				log.debug("로그인 통과, 세션에 저장");

			} else { // 비밀번호가 일치하지 않을 때
				result = "pwfail";

				log.debug("비밀번호 틀림");
			}

		}
		// result 출력
		log.debug(result);

		// mv.addObject("result", result);

		// return mv;
		return result;
	}

	@GetMapping(value = "/brandLoginForm")
	public ModelAndView brandLoginForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드 회원 로그인 폼 ######");
		ModelAndView mv = new ModelAndView("brandLoginForm");
		return mv;
	}

	@RequestMapping(value = "/brandLogin")
	public String brandLogin(@RequestParam Map<String, Object> map, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		log.debug("###### 브랜드 회원 로그인 ######");
		// ModelAndView mv = new ModelAndView("jsonView");
		String result = "";
		System.out.println("로그인 요청에 들어온 Map : " + map.toString());

		// 입력받은 아이디를 꺼내 변수 id에 저장
		Map<String, Object> brand = loginService.selectIdBrand(map);
		log.debug("아이디 : " + (String) map.get("BRAND_ID"));

		HttpSession session = request.getSession();

		if (brand == null) { // 가져온 데이터가 없으면
			result = "idfail";
			log.debug("맵이 비어있음");
		} else { // 가져온 데이터가 있으면
			if (brand.get("BRAND_PW").equals(map.get("BRAND_PW"))) { // 비밀번호 비교
				// 세션영역에 회원정보 올리기
				session.setAttribute("session_BRAND_ID", map.get("BRAND_ID"));
				session.setAttribute("session_BRAND_PW", map.get("BRAND_PW"));
				session.setAttribute("session_BRAND_LOGO_FILE", brand.get("BRAND_LOGO_FILE"));
				session.setAttribute("session_BRAND_NAME", brand.get("BRAND_NAME"));
				session.setAttribute("session_BRNAD_INFO", brand);

				result = "success";

				log.debug("로그인 통과, 세션에 저장");

			} else { // 비밀번호가 일치하지 않을 때
				result = "pwfail";

				log.debug("비밀번호 틀림");
			}

		}
		// result 출력
		log.debug(result);

		// mv.addObject("result", result);

		// return mv;
		return result;
	}

	@GetMapping(value = "/shopLoginForm")
	public ModelAndView shopLoginForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 회원 로그인 폼 ######");
		ModelAndView mv = new ModelAndView("shopLoginForm");
		return mv;
	}

	@RequestMapping(value = "/shopLogin")
	public String shopLogin(@RequestParam Map<String, Object> map, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		log.debug("###### 매장 회원 로그인 ######");
		// ModelAndView mv = new ModelAndView("jsonView");
		String result = "";
		System.out.println("로그인 요청에 들어온 Map : " + map.toString());

		// 입력받은 아이디를 꺼내 변수 id에 저장
		Map<String, Object> shop = loginService.selectIdShop(map);

		log.debug("아이디 : " + (String) map.get("SHOP_ID"));

		HttpSession session = request.getSession();

		if (shop == null) { // 가져온 데이터가 없으면
			result = "idfail";
			log.debug("맵이 비어있음");
		} else { // 가져온 데이터가 있으면
			if (shop.get("SHOP_PW").equals(map.get("SHOP_PW"))) { // 비밀번호 비교
				// 세션영역에 회원정보 올리기
				session.setAttribute("session_SHOP_ID", map.get("SHOP_ID"));
				session.setAttribute("session_SHOP_PW", map.get("SHOP_PW"));
				session.setAttribute("session_SHOP_NAME", shop.get("SHOP_NAME"));
				session.setAttribute("session_SHOP_INFO", shop);

				result = "success";

				log.debug("로그인 통과, 세션에 저장");

			} else { // 비밀번호가 일치하지 않을 때
				result = "pwfail";
				log.debug("비밀번호 틀림");
			}
		}

		// 로그인 한 매장의 브랜드정보 받아서, 해당 브랜드 로고 세션에 올려주기
		Map<String, Object> shopBrandLogoFile = shopPageService.selectBrandLogoFileOfShop(map, request.getSession());
		session.setAttribute("session_SHOP_BRAND_LOGO_FILE", shopBrandLogoFile.get("BRAND_LOGO_FILE"));

		log.debug(result);
		return result;

	}

	@RequestMapping(value = "/logout")
	public void logout(@CookieValue(value = "emailCookie", required = false) Cookie emailCookie,
			@CookieValue(value = "pwCookie", required = false) Cookie pwCookie, @RequestParam Map<String, Object> map,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.debug("###### 로그아웃 ######");
		ModelAndView mv = new ModelAndView("redirect:/main");
		HttpSession session = request.getSession();
		if (session != null) {
			// 로그아웃 시 쿠키 삭제하기
			if ((emailCookie != null) && (pwCookie != null)) { // 쿠키가 존재하면
				System.out.println("#########쿠키 삭제하기 #######");
				Cookie cookie1 = new Cookie("emailCookie", ""); // 쿠키의 값을 비움
				Cookie cookie2 = new Cookie("pwCookie", "");

				System.out.println("삭제할 쿠키 : " + emailCookie.toString() + ", " + pwCookie.toString());

				Cookie[] cookies = { cookie1, cookie2 };
				for (int i = 0; i < cookies.length; i++) {
					cookies[i].setMaxAge(0);
					// 쿠키의 유효시간을 0으로 지정하면 쿠키가 삭제됨
					cookies[i].setPath("/");
					// 쿠키 경로 설정. 쿠키를 생성할 때와 똑같이 지정해야만 삭제가 된다.
					response.addCookie(cookies[i]);
				}
			}
			session.invalidate();
		}
	}

	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> sendSMS(@RequestParam("phone") String userPhoneNumber,
			@RequestParam("MEM_NAME") String MEM_NAME) throws Exception { // 휴대폰 문자보내기
		int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);// 난수 생성

		String result = loginService.findIdWithPhone(userPhoneNumber, randomNumber, MEM_NAME);

		System.out.println("MEM_NAME: " + MEM_NAME);

//		ModelAndView mv = new ModelAndView();
//		mv.addObject("MEM_EMAIL", MEM_EMAIL);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("randomNumber", randomNumber);

		return resultMap;
	}

	@RequestMapping(value = "/findPw")
	public ModelAndView findPw(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 비밀번호 찾기 ######");
		ModelAndView mv = new ModelAndView("findPw");

		String pw = (String) map.get("MEM_PW");
		mv.addObject("MEM_PW", pw);

		return mv;
	}
}
