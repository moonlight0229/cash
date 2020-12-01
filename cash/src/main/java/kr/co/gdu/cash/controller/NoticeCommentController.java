package kr.co.gdu.cash.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.gdu.cash.service.NoticeCommentService;
import kr.co.gdu.cash.vo.NoticeComment;

@Controller
public class NoticeCommentController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired NoticeCommentService noticeCommentService;
	
	// 댓글 작성
	@PostMapping("/admin/addNoticeComment/{noticeId}")
	public String addNoticeComment(NoticeComment noticeComment) {
		logger.debug(noticeComment.toString());
		noticeCommentService.addNoticeComment(noticeComment);
		return "redirect:/admin/noticeOne/{noticeId}";
	}
	
	// 댓글 삭제
	@GetMapping("/admin/removeNoticeComment/{noticeId}/{noticeCommentId}")
	public String removeNoticeComment(@PathVariable(value = "noticeCommentId") int noticeCommentId) {
		noticeCommentService.removeNoticeComment(noticeCommentId);
		return "redirect:/admin/noticeOne/{noticeId}";
	}
}
