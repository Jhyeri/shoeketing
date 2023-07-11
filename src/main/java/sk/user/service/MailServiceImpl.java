package sk.user.service;

import java.security.SecureRandom;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import sk.user.dao.LoginDAO;

//https://devofroad.tistory.com/43
@Service("mailService")
public class MailServiceImpl implements MailService {

	@Autowired
	private JavaMailSender javaMailSender;
	
	@Resource(name = "loginDAO")
	private LoginDAO loginDAO;
	

	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	// 1) 랜덤 비밀번호 생성(10자리 랜덤 값)
	public String createRamdomPassword(int size) {
        char[] charSet = new char[] {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                '!', '@', '#', '$', '%', '^', '&' };

        StringBuffer sb = new StringBuffer();
        SecureRandom sr = new SecureRandom();
        sr.setSeed(new Date().getTime());

        int idx = 0;
        int len = charSet.length;
        for (int i=0; i<size; i++) {
            // idx = (int) (len * Math.random());
            idx = sr.nextInt(len);    // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다.
            sb.append(charSet[idx]);
        }

        return sb.toString();
    }
	
	// 2) 랜덤 비밀번호 생성(RandomStringUtils 이용한 랜덤 값)
	public String getPassword(int size) {
        return RandomStringUtils.randomAlphanumeric(size);
    }
	
	@Override
	public String joinEmail(Map<String, Object> map) throws Exception {
		System.out.println("map: " + map);
		Map<String, Object> pw = loginDAO.findPwWithEmail(map);
		String pww = "";
		
		if (pw == null) {
		    pww = "";
		} else {
			// 랜덤 비밀번호 재발급 후 DB에 업데이트 (2가지중 1 선택)
			pww = createRamdomPassword(10);
//			pww = getPassword(10);
			map.put("UPDATE_PASSWORD", pww);
			loginDAO.updatePassword(map);
		    //pww = pw.get("MEM_PW").toString();
		}
		System.out.println("pww: " + pww);
		
		if(pww == "" || pww == null) {
			return "fail";
		} else {
			String setFrom = "shoeketing@gmail.com"; // email-config에 설정한 자신의 이메일 주소를 입력
			String toMail = (String) map.get("MEM_EMAIL");
			String title = "슈케팅 임시 비밀번호가 발급되었습니다."; // 이메일 제목
			String content = "슈케팅을 방문해주셔서 감사합니다." + // html 형식으로 작성 !
					"<br><br>" + "고객님의 임시 비밀번호는 " + pww + "입니다." + "<br>" + "해당 비밀번호로 로그인해주세요."; // 이메일 내용 삽입
			mailSend(setFrom, toMail, title, content);
			
			return "success";	
		}
	}

	@Override
	public void mailSend(String setFrom, String toMail, String title, String content) {
		MimeMessage message = javaMailSender.createMimeMessage();
		// true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
			helper.setText(content, true);
			javaMailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

}
