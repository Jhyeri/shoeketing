package sk.common.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

@Service(value = "sessionService")
public class CommonService {

	// session_MEM_INFO의 회원정보 가져오는 메소드
	// 이메일, 비밀번호는 이미 별도로 세션영역에 저장해서 포함 안 했음

	// 회원정보 하나만 가져오는 메소드
	public String getSession(HttpSession session, String key) throws Exception {

		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("session_MEM_INFO");
		String info = "";

		if (sessionMap != null) {
			if (key.equals("MEM_NAME")) {
				info = (String) sessionMap.get("MEM_NAME");

			} else if (key.equals("MEM_PHONE")) {
				info = (String) sessionMap.get("MEM_PHONE");

			} else if (key.equals("MEM_INFORM_AGREE")) {
				info = (String) sessionMap.get("MEM_INFORM_AGREE");

			} else if (key.equals("MEM_NUM")) {
				info = sessionMap.get("MEM_NUM").toString();

			} else if (key.equals("MEM_PICKUP_COUNT")) {
				info = sessionMap.get("MEM_PICKUP_COUNT").toString();
				
			} else if(key.equals("MEM_GRADE")) {
				info = (String) sessionMap.get("MEM_GRADE");
			}
		}
		return info;
	}

	// 여러개의 회원정보를 가져올 때 사용
	public Map<String, Object> getSessions(HttpSession session, String[] keys) throws Exception {
//			String info = "";
		Map<String, Object> infoMap = new HashMap<>();
		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("session_MEM_INFO");

		for (String key : keys) {

			if (key.equals("MEM_NAME")) {
				infoMap.put("MEM_NAME", sessionMap.get("MEM_NAME"));

			} else if (key.equals("MEM_NUM")) {
				infoMap.put("MEM_NUM", sessionMap.get("MEM_NUM").toString());

			} else if (key.equals("MEM_PHONE")) {
				infoMap.put("MEM_PHONE", sessionMap.get("MEM_PHONE"));

			} else if (key.equals("MEM_INFORM_AGREE")) {
				infoMap.put("MEM_INFORM_AGREE", sessionMap.get("MEM_INFORM_AGREE"));

			} else if (key.equals("MEM_DEL_GB")) {
				infoMap.put("MEM_DEL_GB", sessionMap.get("MEM_DEL_GB"));

			} else if (key.equals("MEM_ADMIN")) {
				infoMap.put("MEM_ADMIN", sessionMap.get("MEM_ADMIN"));

			} else if (key.equals("MEM_GRADE")) {
				infoMap.put("MEM_GRADE", sessionMap.get("MEM_GRADE"));
			} else if (key.equals("MEM_GRADE")) {
				infoMap.put("MEM_PICKUP_COUNT", sessionMap.get("MEM_PICKUP_COUNT").toString());
			}
		}
		return infoMap;
	}

	// 브랜드 회원정보 하나만 가져오는 메소드
	public String getSessionBrand(HttpSession session, String key) throws Exception {

		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("session_BRNAD_INFO");
		String info = "";
		Map<String, Object> map = new HashMap<>();

		if (key.equals("BRAND_NAME")) {
			info = (String) sessionMap.get("BRAND_NAME");

		} else if (key.equals("BRAND_NUM")) {
			info = sessionMap.get("BRAND_NUM").toString();

		} else if (key.equals("BRAND_ID")) {
			info = (String) sessionMap.get("BRAND_ID");

		}

		return info;
	}

	// 매장 회원정보 하나만 가져오는 메소드
	public String getSessionShop(HttpSession session, String key) throws Exception {

		Map<String, Object> sessionMap = (Map<String, Object>) session.getAttribute("session_SHOP_INFO");
		String info = "";
		Map<String, Object> map = new HashMap<>();

		if (key.equals("SHOP_NAME")) {
			info = (String) sessionMap.get("SHOP_NAME");

		} else if (key.equals("SHOP_NUM")) {
			info = sessionMap.get("SHOP_NUM").toString();

		} else if (key.equals("SHOP_ID")) {
			info = (String) sessionMap.get("SHOP_ID");

		}

		return info;
	}

}
