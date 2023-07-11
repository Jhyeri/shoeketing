package sk.item.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import sk.common.service.CommonService;
import sk.item.service.BasketService;

@RestController
public class BasketController {

	Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "sessionService")
	private CommonService sessionService;

	@Resource(name = "basketService")
	private BasketService basketService;

	@RequestMapping(value = "/basket/basketList")
	public ModelAndView basketList(Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 장바구니 리스트 ######");
		ModelAndView mv = new ModelAndView("basketList");

		map.put("BASKET_MEM_NUM", sessionService.getSession(session, "MEM_NUM"));

		List<Map<String, Object>> list = basketService.selectBasketList(map);
		long orderId = basketService.selectOrderId(map);

		mv.addObject("list", list);
		mv.addObject("orderId", orderId);
		return mv;
	}

	@RequestMapping(value = "/basket/basketAdd")
	public ModelAndView basketAdd(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		log.debug("###### 장바구니 추가 ######");
		ModelAndView mv = new ModelAndView("jsonView");

		map.put("MEM_NUM", sessionService.getSession(session, "MEM_NUM"));

		int result = basketService.insertBasket(map);
		if (result == 1) {
			mv.addObject("result", "success");
		} else if (result == 2) {
			mv.addObject("result", "full");
		} else {
			mv.addObject("result", "fail");
		}

		return mv;
	}

	@PostMapping(value = "/basket/basketDelete")
	public void basketDelete(@RequestBody List<String> basketList, HttpSession session) throws Exception {
		log.debug("###### 장바구니 삭제 ######");
		System.out.println("컨트롤러 파라미터 : " + basketList);

		Map<String, Object> map = new HashMap<>();

		// 여러개 선택하여 삭제할 수 있으므로 반복문 처리
		for (String basket : basketList) {
			map.put("BASKET_NUM", basket);
			System.out.println("BASKET_NUM : " + basket);

			// 맵에 세션의 mem_num 넣어주기
			map.put("BASKET_MEM_NUM", sessionService.getSession(session, "MEM_NUM"));

			// 삭제 처리 쿼리 실행
			basketService.deleteBasket(map);
		}
	}

}
