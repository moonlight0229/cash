package kr.co.gdu.cash.restservice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.gdu.cash.restmapper.CashChartMapper;

@Service
@Transactional
public class CashChartService {
	@Autowired CashChartMapper cashChartMapper;
	
	// 해당 연도의 월별 수입 막대 차트
	public Map<String, Object> getInBarChartByYear(int year) {
		return cashChartMapper.selectInBarChartByYear(year);
	}
	// 해당 연도의 월별 지출 막대 차트
	public Map<String, Object> getOutBarChartByYear(int year) {
		return cashChartMapper.selectOutBarChartByYear(year);
	}
	// 해당 연도의 월별 수입/지출 막대 차트
	public Map<String, Object> getInOutBarChartByYear(int year) {
		return cashChartMapper.selectInOutBarChartByYear(year);
	}
	// 해당 연도의 총 수입/지출 도넛 차트
	public Map<String, Object> getInOutDoughnutChartByYear(int year) {
		return cashChartMapper.selectInOutDoughnutChartByYear(year);
	}
	// 해당 연도의 수입/지출/자산 선 차트
	public Map<String, Object> getTotalLineChartByYear(int year) {
		return cashChartMapper.selectTotalLineChartByYear(year);
	}
	// 연간 카테고리 별 수입 차트
	public Map<String, Object> getInCategoryChartByYear(int year) {
		return cashChartMapper.selectInCategoryChartByYear(year);
	}
	// 연간 카테고리 별 지출 차트
	public Map<String, Object> getOutCategoryChartByYear(int year) {
		return cashChartMapper.selectOutCategoryChartByYear(year);
	}
	// 최근 5년간 자산현황 차트
	public Map<String, Object> getTotalChartByFiveYear() {
		List<Map<String, Object>> totalChart = cashChartMapper.selectTotalChartByFiveYear();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalChart", totalChart);
		System.out.println(map);
		return map;
	}
}
