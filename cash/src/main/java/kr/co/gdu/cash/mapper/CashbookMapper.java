package kr.co.gdu.cash.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gdu.cash.vo.Cashbook;

@Mapper
public interface CashbookMapper {
	// 엑셀
	List<Cashbook> selectCashbookAll();
	
	// 전체 수입/지출 내역 리스트로 보기
	List<Cashbook> selectCashListByPage(Map<String, Object> map);
	
	// 수입/지출 내역 페이지 카운트
	int countCashbook();
	
	// 월별 수입/지출 내역 달력 보기
	List<Map<String, Object>> selectCashListByMonth(Map<String, Object> map);
	
	// 최근 3달의 월 수입/지출/합계를 출력하기
	List<Map<String, Object>> selectCashInOutList();
	
	// 월별 수입/지출 합계를 각각 출력하는 쿼리문
	Integer selectSumCashPriceByInOut(Map<String, Object> map);
	
	// 일별 수입/지출 내역 출력
	List<Cashbook> selectCashbookListByDay(Map<String, Object> map);
	
	// 수입/지출 내역 상세보기
	Cashbook selectCashbookOne(int cashbookId);
	
	// 수입/지출 내역 추가
	int insertCashbook(Cashbook cashbook);
	
	// 수입/지출 내역 수정
	int updateCashbook(Cashbook cashbook);
	
	// 수입/지출 내역 삭제
	int deleteCashbook(int cashbookId);
}