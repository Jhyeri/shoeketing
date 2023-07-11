package sk.user.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import sk.user.dao.LoginDAO;

@Service("loginService")
public class LoginServiceImpl implements LoginService{
	
	@Resource(name = "loginDAO")
	private LoginDAO loginDAO;
	
	@Override
	public Map<String, Object> selectId(Map<String, Object> map) throws Exception {
		return loginDAO.selectId(map);
	}

	@Override
	public String findIdWithPhone(String userPhoneNumber, int randomNumber, String MEM_NAME) throws Exception {
		String api_key = "NCSOZ2I0JHF1B2S5";
	    String api_secret = "EKMITVG0WHE4P6CMJWHZFB2ANYBW6XLO";
	    Message coolsms = new Message(api_key, api_secret);
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("MEM_NAME", MEM_NAME);
	    map.put("MEM_PHONE", userPhoneNumber);
	    
	    String MEM_EMAIL = loginDAO.findIdWithPhone(map);
	    if(MEM_EMAIL != null) {
	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNumber);    // 수신전화번호
	    params.put("from", "01021282629");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    params.put("text", "[TEST] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
	    return MEM_EMAIL;
	    
	    }else {
	    	return "error";
	    }
		
	}

	@Override
	public Map<String, Object> findPwWithEmail(Map<String, Object> map) throws Exception {

		return loginDAO.findPwWithEmail(map);
	}

	@Override
	public Map<String, Object> selectIdBrand(Map<String, Object> map) throws Exception {
		
		return loginDAO.selectIdBrand(map);
	}

	@Override
	public Map<String, Object> selectIdShop(Map<String, Object> map) throws Exception {
		
		return loginDAO.selectIdShop(map);
	}
}
