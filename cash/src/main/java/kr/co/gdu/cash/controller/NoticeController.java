package kr.co.gdu.cash.controller;

import java.util.List;

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
	public String noticeList(Model model, @PathVariable(value = "currentPage") int currentPage) {
		int rowPerPage = 10;
		
		List<Notice> noticeList = noticeService.getNoticeListByPage(currentPage, rowPerPage);
		logger.debug(noticeList.toString());

		int totalCount = noticeService.getCountNotice();	// 전체 데이터
		int lastPage = totalCount / rowPerPage;	// 마지막 페이지

		if (totalCount % rowPerPage != 0) {	// 10 미만의 개수의 데이터가 있는 페이지를 표시
			lastPage += 1;
		}

		if (lastPage == 0) { // 전체 페이지가 0개이면 현재 페이지도 0으로 표시
			currentPage = 0;
		}

		int navPerPage = 10;	// 네비게이션에 표시할 페이지 수
		int navFirstPage = currentPage - (currentPage % navPerPage) + 1;	// 네비게이션 첫번째 페이지
		int navLastPage = navFirstPage + navPerPage - 1;	// 네비게이션 마지막 페이지

		if (currentPage % navPerPage == 0 && currentPage != 0) {	// 10으로 나누어 떨어지는 경우 처리하는 코드
			navFirstPage = navFirstPage - navPerPage;
			navLastPage = navLastPage - navPerPage;
		}

		model.addAttribute("noticeList", noticeList);

		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);

		model.addAttribute("navPerPage", navPerPage);
		model.addAttribute("navFirstPage", navFirstPage);
		model.addAttribute("navLastPage", navLastPage);
		
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
