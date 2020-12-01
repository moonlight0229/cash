package kr.co.gdu.cash.controller;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.gdu.cash.service.CashbookService;
import kr.co.gdu.cash.service.CategoryService;
import kr.co.gdu.cash.vo.Cashbook;
import kr.co.gdu.cash.vo.Category;

@Controller
public class CashbookController {
	@Autowired private CashbookService cashbookService;
	@Autowired private CategoryService categoryService;
	
	// 내역 리스트로 출력
	@GetMapping("/admin/cashbookList/{currentPage}")
	public String cashbookList(Model model, @PathVariable(name = "currentPage", required = true) int currentPage) {
		int rowPerPage = 20;
		
		List<Cashbook> cashbookList = cashbookService.getCashbookListByPage(currentPage, rowPerPage);
		int totalCount = cashbookService.getCountCashbook();// 전체 데이터
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

		model.addAttribute("cashbookList", cashbookList);

		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", lastPage);

		model.addAttribute("navPerPage", navPerPage);
		model.addAttribute("navFirstPage", navFirstPage);
		model.addAttribute("navLastPage", navLastPage);
		
		return "cashbookList";
	}
	
	// 월별 수입/지출 내역 출력
	@GetMapping("/admin/cashbookByMonth/{currentYear}/{currentMonth}")
	public String cashbookByMonth(Model model,
			@PathVariable(name = "currentYear") int currentYear,
			@PathVariable(name = "currentMonth") int currentMonth) {
		
		// 요청분석
		Calendar currentDay = Calendar.getInstance(); // 오늘
		// currentYear 값과 currentMonth 값이 넘어왔고
		if(currentYear != -1 && currentMonth != -1) {
			// (이전 달 버튼을 눌러)월 값이 0월이 넘어오면 연도를 1년 빼고 월을 12월로 설정한다
			if(currentMonth == 0) {
				currentYear -= 1;
				currentMonth = 12;
			}
			// (다음 달 버튼을 눌러)월 값이 13월이 넘어오면 연도를 1년 더하고 월을 1월로 설정한다
			if(currentMonth == 13) {
				currentYear += 1;
				currentMonth = 1;
			}
			currentDay.set(Calendar.YEAR, currentYear);
			currentDay.set(Calendar.MONTH, currentMonth-1);
		}
		
		currentDay.set(Calendar.DATE, 1); // 월의 1일
		currentYear = currentDay.get(Calendar.YEAR); // 년
		currentMonth = currentDay.get(Calendar.MONTH) + 1; // 월
		int lastDay = currentDay.getActualMaximum(Calendar.DATE); // 월의 마지막 일 
		int firstDayOfWeek = currentDay.get(Calendar.DAY_OF_WEEK); // 1일의 요일
		//-------------------------------------------------------------------------------------------------------------
		int sumIn = cashbookService.getSumCashbookPriceByInOut("수입", currentYear, currentMonth);
		int sumOut = cashbookService.getSumCashbookPriceByInOut("지출", currentYear, currentMonth);
		//-------------------------------------------------------------------------------------------------------------
		List<Map<String, Object>> cashList = cashbookService.getCashListByMonth(currentYear, currentMonth);
		//-------------------------------------------------------------------------------------------------------------
		
		// 뷰 모델 추가
		model.addAttribute("currentYear", currentYear); // 년
		model.addAttribute("currentMonth", currentMonth); // 월
		model.addAttribute("lastDay", lastDay); // 월의 마지막 일
		model.addAttribute("firstDayOfWeek", firstDayOfWeek); // 1일의 요일
		
		model.addAttribute("sumIn", sumIn); // 수입
		model.addAttribute("sumOut", sumOut); // 지출
		
		model.addAttribute("cashList", cashList); // 달력에 출력할 일일 수입/지출 합계
		
		return "cashbookByMonth"; // 자동으로 /WEB-INF/view/cashbookByMonth.jsp로 포워딩
	}
	
	// 일별 수입/지출 내역 출력
	@GetMapping("/admin/cashbookByDay/{target}/{currentYear}/{currentMonth}/{currentDay}")
	public String cashbookByDay(Model model,
			@PathVariable(name = "target") String target,
			@PathVariable(name = "currentYear", required = true) int currentYear,
			@PathVariable(name = "currentMonth", required = true) int currentMonth,
			@PathVariable(name = "currentDay", required = true) int currentDay) {
		Calendar targetDay = Calendar.getInstance();
		targetDay.set(Calendar.YEAR, currentYear);
		targetDay.set(Calendar.MONTH, currentMonth-1);
		targetDay.set(Calendar.DATE, currentDay);
		
		if(target.equals("pre")) {
			targetDay.add(Calendar.DATE, -1);
		} else if(target.equals("next")) {
			targetDay.add(Calendar.DATE, +1);
		}
		
		List<Cashbook> cashbookList = cashbookService.getCashbookListByDay(targetDay.get(Calendar.YEAR), targetDay.get(Calendar.MONTH)+1, targetDay.get(Calendar.DATE));
		model.addAttribute("cashbookList", cashbookList);
		model.addAttribute("currentYear", targetDay.get(Calendar.YEAR));
		model.addAttribute("currentMonth", targetDay.get(Calendar.MONTH)+1);
		model.addAttribute("currentDay", targetDay.get(Calendar.DATE));
		
		return "cashbookByDay";
	}
	
	// 수입/지출 내역 추가 폼
	@GetMapping("/admin/addCashbook/{currentYear}/{currentMonth}/{currentDay}")
	public String addCashbook(Model model,
			@PathVariable(name = "currentYear", required = true) int currentYear,
			@PathVariable(name = "currentMonth", required = true) int currentMonth,
			@PathVariable(name = "currentDay", required = true) int currentDay) {
		List<Category> categoryList = categoryService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		return "addCashbook";
	}
	
	// 수입/지출 내역 추가 액션
	@PostMapping("/admin/addCashbook/{currentYear}/{currentMonth}/{currentDay}")
	public String addCashbook(Cashbook cashbook) { // 커맨드 객체
		//System.out.println("debug: cashbook" + cashbook);
		cashbookService.addCashbook(cashbook);
		return "redirect:/admin/cashbookByMonth/{currentYear}/{currentMonth}"; // response.sendRedirct() -> /cashbookByDay 와 같은 표현
	}
	
	// 수입/지출 내역 수정 폼
	@GetMapping("/admin/modifyCashbook/{cashbookId}")
	public String modifyCashbook(Model model,
			@PathVariable(value = "cashbookId") int cashbookId) {
		Cashbook cashbook = cashbookService.getCashbookOne(cashbookId);
		List<Category> categoryList = categoryService.getCategoryList();
		model.addAttribute("cashbook", cashbook);
		model.addAttribute("categoryList", categoryList);
		return "modifyCashbook";
	}
	// 수입/지출 내역 수정 액션
	@PostMapping("/admin/modifyCashbook/{cashbookId}")
	public  String modifeCashbook(Cashbook cashbook) {
		cashbookService.modifyCashbook(cashbook);
		return "redirect:/admin/cashbookByMonth/-1/-1";
	}
	
	// 수입/지출 내역 삭제
	@GetMapping("/admin/removeCashbook/{cashbookId}")
	public String removeCashbook(@PathVariable(value = "cashbookId") int cashbookId) {
		cashbookService.removeCashbook(cashbookId);
		return "redirect:/admin/cashbookByMonth/-1/-1";
	}
}
