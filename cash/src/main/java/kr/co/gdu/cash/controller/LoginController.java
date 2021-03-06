package kr.co.gdu.cash.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.gdu.cash.service.MemberService;
import kr.co.gdu.cash.service.NoticeService;
import kr.co.gdu.cash.vo.Member;
import kr.co.gdu.cash.vo.Notice;


@Controller
public class LoginController {
	@Autowired private NoticeService noticeService;
	@Autowired private MemberService memberService;

	// 로그인 폼
	@GetMapping(value = {"/", "/login"})
	public String login(Model model, HttpSession session) {
		// 로그인 되어있을 시 /admin/index로 리다이렉트
		if(session.getAttribute("loginId") != null) {
			return "redirect:/admin/index";
		}
		List<Notice> noticeList = noticeService.getNoticeList();
		model.addAttribute("noticeList", noticeList);
		return "login";
	}
	
	// 로그인 액션
	@PostMapping("/login")
	public String login(Member member, HttpSession session) {
		Member loginMember = memberService.getMemberById(member);
		// 로그인 실패
		if(loginMember == null) {
			return "redirect:/login";
		}
		//로그인 성공
		session.setAttribute("loginId", loginMember.getId());
		return "redirect:/admin/index";
	}
	
	// 로그아웃
	@GetMapping("/admin/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}