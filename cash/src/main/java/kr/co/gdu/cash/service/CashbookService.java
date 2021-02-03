package kr.co.gdu.cash.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.gdu.cash.mapper.CashbookMapper;
import kr.co.gdu.cash.vo.Cashbook;

@Service
@Transactional
public class CashbookService {
	@Autowired private CashbookMapper cashbookMapper;

	// 내역 리스트 출력
	public Map<String, Object> getCashbookListByPage(int currentPage) {
		// 한 페이지에 보여줄 항목 10개 
		int rowPerPage = 10;
		// 해당 페이지에 표시한 항목
		int beginRow = (currentPage - 1) * rowPerPage;
		// 총 항목수
		int totalCount = cashbookMapper.selectCountCashbook();
		// 마지막 페이지
		int lastPage = totalCount / rowPerPage;
		// 페이지 네비게이션 바에 표시할 페이지 수
		int pageNaviSize = 10;
		// 페이지 네비게이션 바의 첫번째 값
		int pageNaviBegin = (currentPage - 1) / pageNaviSize * pageNaviSize + 1;
		// 페이지 네비게이션 바의 마지막 값
		int pageNaviEnd = (pageNaviBegin + pageNaviSize) - 1;
		
		// 한 페이지에 보여줄 항목수 미만의 항목이 남을 경우 마지막 페이지를 한 페이지 추가
		if (totalCount % rowPerPage != 0) {
			lastPage += 1;
		}

		// 만약 마지막 페이지가 0이라면 현재 페이지도 0이 됨
		if (lastPage == 0) {
			currentPage = 0;
		}
		
		// 만약 네비게이션 바의 마지막 값이 마지막 페이지보다 크다면 네비게이션 바의 마지막 값은 마지막 페이지가 됨
		if (pageNaviEnd > lastPage) {
			pageNaviEnd = lastPage;
		}
		
		// 리턴값 저장
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("lastPage", lastPage);
		returnMap.put("pageNaviSize", pageNaviSize);
		returnMap.put("pageNaviBegin", pageNaviBegin);
		returnMap.put("pageNaviEnd", pageNaviEnd);
		
		// 파라미터값 저장
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		
		List<Cashbook> cashbookList = cashbookMapper.selectCashListByPage(paramMap);
		returnMap.put("cashbookList", cashbookList);
		
		return returnMap;
	}

	// 월별 수입/지출 내역 출력
	public List<Map<String, Object>> getCashListByMonth(int currentYear, int currentMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentYear", currentYear);
		map.put("currentMonth", currentMonth);
		return cashbookMapper.selectCashListByMonth(map);
	}
	
	// 월별 수입/지출 합 출력
	public int getSumCashbookInOutPriceByMonth(String cashbookKind, int currentYear, int currentMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cashbookKind", cashbookKind);
		map.put("currentYear", currentYear);
		map.put("currentMonth", currentMonth);
		Integer sum = cashbookMapper.selectSumCashInOutPriceByMonth(map);
		return sum;
	}
	
	// 일별 수입/지출 내역 출력
	public List<Cashbook> getCashbookListByDay(int currentYear, int currentMonth, int currentDay) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentYear", currentYear);
		map.put("currentMonth", currentMonth);
		map.put("currentDay", currentDay);
		return cashbookMapper.selectCashbookListByDay(map);
	}
	
	// 별 수입/지출 합 출력
	public int getSumCashbookInOutPriceByDay(String cashbookKind, int currentYear, int currentMonth, int currentDay) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cashbookKind", cashbookKind);
		map.put("currentYear", currentYear);
		map.put("currentMonth", currentMonth);
		map.put("currentDay", currentDay);
		Integer sum = cashbookMapper.selectSumCashInOutPriceByDay(map);
		return sum;
	}
	
	// 일별 수입/지출 내역 상세보기
	public Cashbook getCashbookOne(int cashbookId) {
		Cashbook cashbookOne = cashbookMapper.selectCashbookOne(cashbookId);
		return cashbookOne;
	}
	
	// 수입/지출 내역 추가
	public int addCashbook(Cashbook cashbook) {
		return cashbookMapper.insertCashbook(cashbook);
	}
	
	// 수입/지출 내역 수정
	public int modifyCashbook(Cashbook cashbook) {
		return cashbookMapper.updateCashbook(cashbook);
	}
	
	
	// 수입/지출 내역 삭제
	public int removeCashbook(int cashbookId) {
		return cashbookMapper.deleteCashbook(cashbookId);
	}
}
