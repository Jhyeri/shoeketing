package sk.common.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import sk.common.service.CommonService;
import sk.common.service.InformService;

public class InformCountInterceptor extends HandlerInterceptorAdapter {

	@Resource(name = "informService")
	private InformService informService;

	@Resource(name = "sessionService")
	private CommonService commonService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		String MEM_NUM = commonService.getSession(session, "MEM_NUM");
		int count = 0;
		if (MEM_NUM != "" && MEM_NUM != null) {
			Map<String, Object> map = new HashMap<>();
			map.put("MEM_NUM", MEM_NUM);
			count = informService.informCount(map);

		}
		if (modelAndView != null) {
			modelAndView.addObject("informCount", count);
		}
	}

}
