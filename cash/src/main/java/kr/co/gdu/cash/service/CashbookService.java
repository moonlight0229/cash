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

	// 엑셀
	public List<Cashbook> getCashbookListAll() {
		return cashbookMapper.selectCashbookAll();
	}
	
	// 내역 리스트 출력
	public List<Cashbook> getCashbookListByPage(int currentPage, int rowPerPage) {
		int beginRow = (currentPage - 1) * rowPerPage;
		Map<String, Object> map = new HashMap<>();
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		List<Cashbook> cashbookList = cashbookMapper.selectCashListByPage(map);
		return cashbookList;
	}
	
	// 공지사항 페이지 카운트
	public int getCountCashbook() {
		return cashbookMapper.countCashbook();
	}

	// 월별 수입/지출 내역 출력
	public List<Map<String, Object>> getCashListByMonth(int currentYear, int currentMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentYear", currentYear);
		map.put("currentMonth", currentMonth);
		return cashbookMapper.selectCashListByMonth(map);
	}
	
	// 월별 수입/지출 합 출력
	public int getSumCashbookPriceByInOut(String cashbookKind, int currentYear, int currentMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cashbookKind", cashbookKind);
		map.put("currentYear", currentYear);
		map.put("currentMonth", currentMonth);
		Integer sum = cashbookMapper.selectSumCashPriceByInOut(map);
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
