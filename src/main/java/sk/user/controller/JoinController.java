package sk.user.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import sk.user.service.JoinService;

@RestController
public class JoinController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "joinService")
	private JoinService joinService;
	// ServiceImpl 객체 주입
	// @Service를 통해 joinService란 이름으로 빈 등록했던 ServiceImpl

	// 회원가입 폼 띄우기
	@RequestMapping(value = "/memberJoinForm")
	public ModelAndView memberJoinForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 회원가입 ######");

		ModelAndView mv = new ModelAndView("memberJoinForm"); // tiles이름 (tiles.xml에서 이름에 해당하는 jsp 주소를 확인할 수 있음

		return mv;
	}

	@RequestMapping(value = "/memberJoin/emailCheck")
	public @ResponseBody String emailCheck(String MEM_EMAIL) throws Exception {
		log.debug("###### 이메일 중복 확인 ######");
		Map<String, Object> emailMap = new HashMap<>();
		emailMap.put("MEM_EMAIL", MEM_EMAIL);
		
		System.out.println(emailMap);

		String result = ""; // 이메일 중복확인 후 결과를 해당 변수에 받아온다

		Map<String, Object> map = joinService.selectEmailCheck(emailMap);

		if (map != null) {
			result = "fail";
		} else {
			result = "success";
		}

		return result;
	}

	
	//폰인증
	@RequestMapping(value = "/phoneCheck", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) throws Exception { // 휴대폰 문자보내기
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);//난수 생성

		joinService.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		
		return Integer.toString(randomNumber);
	}
	
	

	@RequestMapping(value = "/memberJoin/joinAvailable")
	public @ResponseBody String joinAvailable(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 회원가입 가능 여부 검토 ######");
		
		int check = joinService.selectDelGB(map);
		    System.out.println("check : " + check);

		    String result = "";

			if (check == 1) {
				// DB에 회원가입 처리 전, 회원 탈퇴한 이력이 있고 7일 지났는지 여부 확인
				int delCount = joinService.selectDelCount(map);
				System.out.println("delCount : " + delCount);

				if (delCount == 0) { // 회원 탈퇴 후 7일이 지나지 않았을 경우
					result = "fail";
				} else { // 회원 탈퇴 후 7일이 지났거나, 혹은 처음으로 가입할 경우
					// DB에 회원가입 처리
					joinService.insertMember(map);
					result = "success";
				}
			} else {
				joinService.insertMember(map);
				result = "success";
			}

			return result;
	}

	// 회원 가입 성공
	@PostMapping(value = "/memberJoin/joinSuccess")
	public ModelAndView memberInsertMember(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 회원가입 성공 ######");

		ModelAndView mv = new ModelAndView("main");
		
		joinService.insertMember(map);

		return mv;
	}
	

	//브랜드회원가입
	@GetMapping(value = "/brandJoinForm")
	public ModelAndView brandJoinForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 브랜드 회원가입 ######");
		ModelAndView mv = new ModelAndView("brandJoinForm");
		return mv;
	}
	
	//사업자 등록번호
	@RequestMapping(value = "/brand/bNumAuth")
	public ModelAndView bNumAuth(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 사업자 등록번호 인증 ######");
		System.out.println("map: " + map);
		ModelAndView mv = new ModelAndView("bNumAuth");
		return mv;
	}

	//브랜드 회원가입 성공
	@PostMapping(value = "/brandJoin/joinSuccess")
	public ModelAndView brandInsertMember(@RequestParam Map<String, Object> map, MultipartHttpServletRequest request) throws Exception {
		log.debug("###### 브랜드회원가입 성공 ######");

		ModelAndView mv = new ModelAndView("main");
		joinService.insertBrand(map, request);

		return mv;
	}

	//매장 회원가입
	@GetMapping(value = "/shopJoinForm")
	public ModelAndView shopJoinForm(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 회원가입 ######");
		ModelAndView mv = new ModelAndView("shopJoinForm");
		return mv;
	}

	@GetMapping(value = "/shop/locationInfo")
	public ModelAndView shopLocationInfo(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 위치 정보 확인 ######");
		ModelAndView mv = new ModelAndView("shopLocationInfo");
		return mv;
	}

	@PostMapping(value = "/shop/joinSuccess")
	public ModelAndView shopJoinSuccess(@RequestParam Map<String, Object> map) throws Exception {
		log.debug("###### 매장 회원가입성공 ######");
		ModelAndView mv = new ModelAndView("main");
		joinService.insertShop(map);

		return mv;
	}

}
