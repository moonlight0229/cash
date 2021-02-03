package kr.co.gdu.cash.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.gdu.cash.service.NoticeService;
import kr.co.gdu.cash.vo.Notice;
import kr.co.gdu.cash.vo.NoticeForm;

@Controller
public class NoticeController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired private NoticeService noticeService;
	
	// 공지사항 목록 출력
	@GetMapping("/admin/noticeList/{currentPage}")
	public String noticeList(Model model,
			@PathVariable(value = "currentPage", required = true) int currentPage) {
		Map<String, Object> map = noticeService.getNoticeListByPage(currentPage);
		logger.debug(map.toString());
		
		model.addAttribute("noticeList", map.get("noticeList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("pageNaviSize", map.get("pageNaviSize"));
		model.addAttribute("pageNaviBegin", map.get("pageNaviBegin"));
		model.addAttribute("pageNaviEnd", map.get("pageNaviEnd"));
		
		return "noticeList";
	}
	
	// 공지사항 상세보기 출력
	@GetMapping("/admin/noticeOne/{noticeId}")
	public String noticeOne(Model model, @PathVariable(value = "noticeId") int noticeId) {
		Notice notice = noticeService.getNoticeOne(noticeId);
		logger.debug(notice.toString());
		model.addAttribute("notice", notice);
		
		return "noticeOne";
	}
	
	// 공지사항 작성 폼
	@GetMapping("/admin/addNotice")
	public String addNotice() {
		return "addNotice";
	}
	
	// 공지사항 작성 액션
	@PostMapping("/admin/addNotice")
	public String addNotice(NoticeForm noticeForm) {
		logger.debug(noticeForm.toString());
		noticeService.addNotice(noticeForm);
		return "redirect:/admin/noticeList/1";
	}
	
	// 공지사항 수정 폼
	@GetMapping("/admin/modifyNotice/{noticeId}")
	public String modifyNotice(Model model, @PathVariable(value = "noticeId") int noticeId) {
		Notice notice = noticeService.getNoticeOne(noticeId);
		logger.debug(notice.toString());
		model.addAttribute("notice", notice);
		return "modifyNotice";
	}
	
	// 공지사항 수정 액션
	@PostMapping("/admin/modifyNotice/{noticeId}")
	public String modifyNotice(NoticeForm noticeForm) {
		logger.debug(noticeForm.toString());
		noticeService.modifyNotice(noticeForm);
		return "redirect:/admin/noticeOne/{noticeId}";
	}
	
	// 공지사항 수정 시 첨부된 파일 개별 삭제
	@GetMapping("/admin/removeNoticeFileOne/{noticeId}/{noticeFileId}")
	public String removeNoticeFileOne(@PathVariable(value = "noticeFileId") int noticeFileId) {
		noticeService.removeNoticeFileOne(noticeFileId);
		return "redirect:/admin/modifyNotice/{noticeFileId}";
	}
	
	// 공지사항 삭제
	@GetMapping("/admin/removeNotice/{noticeId}")
	public String removeNotice(@PathVariable(value = "noticeId") int noticeId) {
		System.out.println("NoticeController/removeNotice/debug: noticeId[" + noticeId + "] 삭제");
		noticeService.removeNotice(noticeId);
		return "redirect:/admin/noticeList/1";
	}
}
