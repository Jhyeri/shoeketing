package sk.user.service;

import java.util.Map;

public interface MailService {

//	public void makeRandomNumber();

	public String joinEmail(Map<String, Object> map) throws Exception;

	public void mailSend(String setFrom, String toMail, String title, String content);

}
