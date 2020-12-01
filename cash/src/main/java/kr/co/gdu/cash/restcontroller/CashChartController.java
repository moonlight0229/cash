package kr.co.gdu.cash.restcontroller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import kr.co.gdu.cash.restservice.CashChartService;

@RestController
public class CashChartController {
	@Autowired CashChartService cashChartService;
	
	// 해당연도 월별 수입 막대 차트
	@GetMapping("/admin/inBarChartByYear/{year}")
	public Map<String, Object> inBarChartByYear(@PathVariable(name = "year") int year) {
		Map<String, Object> map = cashChartService.getInBarChartByYear(year);
		return map;
	}
	
	// 해당연도 월별 지출 막대 차트
	@GetMapping("/admin/outBarChartByYear/{year}")
	public Map<String, Object> outBarChartByYear(@PathVariable(name = "year") int year) {
		Map<String, Object> map = cashChartService.getOutBarChartByYear(year);
		return map;
	}
	
	// 해당연도 월별 수입/지출 막대 차트
	@GetMapping("/admin/inOutBarChartByYear/{year}")
	public Map<String, Object> inOutBarChartByYear(@PathVariable(name = "year") int year) {
		Map<String, Object> map= cashChartService.getInOutBarChartByYear(year);
		return map;
	}
	
	// 해당연도 월별 수입/지출 도넛 차트
	@GetMapping("/admin/inOutDoughnutChartByYear/{year}")
	public Map<String, Object> getInOutDoughnutChartByYear(@PathVariable(name = "year") int year) {
		Map<String, Object> map= cashChartService.getInOutDoughnutChartByYear(year);
		return map;
	}
	
	// 해당연도 월별 수입/지출/자산 선 차트
	@GetMapping("/admin/totalLineChartByYear/{year}")
	public Map<String, Object> getTotalLineChartByYear(@PathVariable(name = "year") int year) {
		Map<String, Object> map= cashChartService.getTotalLineChartByYear(year);
		return map;
	}
	
	// 연간 카테고리 별 수입 차트
	@GetMapping("/admin/inCategoryChartByYear/{year}")
	public Map<String, Object> getInCategoryChartByYear(@PathVariable(name = "year") int year) {
		Map<String, Object> map= cashChartService.getInCategoryChartByYear(year);
		return map;
	}
	
	// 연간 카테고리 별 지출 차트
	@GetMapping("/admin/outCategoryChartByYear/{year}")
	public Map<String, Object> getOutCategoryChartByYear(@PathVariable(name = "year") int year) {
		Map<String, Object> map= cashChartService.getOutCategoryChartByYear(year);
		return map;
	}
	
	// 연간 카테고리 별 지출 차트
	@GetMapping("/admin/totalChartByFiveYear")
	public Map<String, Object> getTotalChartByFiveYear(Model model) {
		Map<String, Object> map= cashChartService.getTotalChartByFiveYear();
		model.addAttribute("totalChart", map.get("totalChart"));
		System.out.println(map);
		return map;
	}
}