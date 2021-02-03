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
	public String cashbookList(Model model,
			@PathVariable(name = "currentPage", required = true) int currentPage) {	
		Map<String, Object> map = cashbookService.getCashbookListByPage(currentPage);

		model.addAttribute("cashbookList", map.get("cashbookList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("pageNaviSize", map.get("pageNaviSize"));
		model.addAttribute("pageNaviBegin", map.get("pageNaviBegin"));
		model.addAttribute("pageNaviEnd", map.get("pageNaviEnd"));
		
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
		int sumIn = cashbookService.getSumCashbookInOutPriceByMonth("수입", currentYear, currentMonth);
		int sumOut = cashbookService.getSumCashbookInOutPriceByMonth("지출", currentYear, currentMonth);
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
		
		int sumIn = cashbookService.getSumCashbookInOutPriceByDay("수입", targetDay.get(Calendar.YEAR), targetDay.get(Calendar.MONTH)+1, targetDay.get(Calendar.DATE));
		int sumOut = cashbookService.getSumCashbookInOutPriceByDay("지출", targetDay.get(Calendar.YEAR), targetDay.get(Calendar.MONTH)+1, targetDay.get(Calendar.DATE));

		List<Cashbook> cashbookList = cashbookService.getCashbookListByDay(targetDay.get(Calendar.YEAR), targetDay.get(Calendar.MONTH)+1, targetDay.get(Calendar.DATE));
		
		model.addAttribute("cashbookList", cashbookList);
		model.addAttribute("currentYear", targetDay.get(Calendar.YEAR));
		model.addAttribute("currentMonth", targetDay.get(Calendar.MONTH)+1);
		model.addAttribute("currentDay", targetDay.get(Calendar.DATE));
		model.addAttribute("sumIn", sumIn); // 수입
		model.addAttribute("sumOut", sumOut); // 지출
		System.out.println(sumOut);
		
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
