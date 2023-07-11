package sk.common.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CommonController {

	Log log = LogFactory.getLog(this.getClass());
	
	@GetMapping(value = "/image/display")
	@ResponseBody
	public ResponseEntity<byte[]> display(String fileName, HttpServletRequest request) throws Exception {
		ResponseEntity<byte[]> result = null;
		log.debug("############### fileName : " + fileName);
//		String filePath_temp = request.getServletContext().getRealPath("/resources/uploadImage/");
		String filePath_temp = "C:\\goods_image\\"; // 로컬 경로에 업로드

		File file = new File(filePath_temp + fileName);

		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}
	
}
