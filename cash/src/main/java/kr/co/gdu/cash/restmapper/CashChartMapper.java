package kr.co.gdu.cash.restmapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CashChartMapper {
	// 해당 연도의 월별 수입 막대 차트
	Map<String, Object> selectInBarChartByYear(int year);
	// 해당 연도의 월별 지출 막대 차트
	Map<String, Object> selectOutBarChartByYear(int year);
	// 해당 연도의 월별 수입/지출 막대 차트
	Map<String, Object> selectInOutBarChartByYear(int year);
	// 해당 연도의 총 수입/지출 도넛 차트
	Map<String, Object> selectInOutDoughnutChartByYear(int year);
	// 해당 연도의 수입/지출/자산 선 차트
	Map<String, Object> selectTotalLineChartByYear(int year);
	// 연간 카테고리 별 수입 차트
	Map<String, Object> selectInCategoryChartByYear(int year);
	// 연간 카테고리 별 지출 차트
	Map<String, Object> selectOutCategoryChartByYear(int year);
	// 최근 5년간 자산현황 차트
	List<Map<String, Object>> selectTotalChartByFiveYear();
}