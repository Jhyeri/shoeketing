package sk.common.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import sk.user.service.MailService;

@RestController
public class MailHandler {
	
	@Resource(name = "mailService")
	private MailService mailService;
	
	@RequestMapping(value = "/join/emailAuth")
	@ResponseBody
	public String mailCheck(@RequestParam Map<String, Object> map) throws Exception {
		System.out.println("이메일을 확인해주세요.");
		System.out.println("map: " + map);
		return mailService.joinEmail(map);
	}
}