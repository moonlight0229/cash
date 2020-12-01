package kr.co.gdu.cash.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.gdu.cash.service.NoticeService;

@Controller
public class IndexController {
	@Autowired private NoticeService noticeService;
	
	// 메인에 최근 3달간의 수입/지출 내역과 최근 공지사항 5개 출력
	@GetMapping(value = {"/admin/index"})
	public String index(Model model) {
		Map<String, Object> map = noticeService.getNoticeAndInOutList();
		model.addAttribute("noticeList", map.get("noticeList"));
		model.addAttribute("inOutList", map.get("inOutList"));
		return "index";
	}
}