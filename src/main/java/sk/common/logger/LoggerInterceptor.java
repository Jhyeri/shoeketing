package sk.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {

	protected Log log = LogFactory.getLog(this.getClass());

	// 컨트롤러가 호출되기 전에 실행
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		String URICheck = request.getRequestURI();

		// 로그 메세지 출력
		if (log.isDebugEnabled() && URICheck.indexOf("/sk/assets/") == -1 && URICheck.indexOf("/sk/image/display") == -1
				&& URICheck.indexOf("/sk/inform-ws") == -1 && URICheck != null && URICheck != "") {
			log.debug(
					"======================================          START         ======================================");
			log.debug(" Request URI \t:  " + request.getRequestURI());
		}

		return super.preHandle(request, response, handler);
	}

	// 컨트롤러가 실행된 후에 호출됨
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		String URICheck = request.getRequestURI();

		if (log.isDebugEnabled() && URICheck.indexOf("/sk/assets/") == -1 && URICheck.indexOf("/sk/image/display") == -1
				&& URICheck.indexOf("/sk/inform-ws") == -1 && URICheck != null && URICheck != "") {
			log.debug(
					"======================================           END          ======================================\n");
		}
	}

}
