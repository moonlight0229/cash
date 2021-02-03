package kr.co.gdu.cash.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gdu.cash.vo.Notice;

@Mapper
public interface NoticeMapper {
	// index에 최근 공지사항 5개를 보여주는 메소드
	List<Notice> selectLatestNoticeList();
	
	// 공지사항을 페이징하여 출력하는 메소드
	List<Notice> selectNoticeListByPage(Map<String, Object> map);
	
	// 공지사항 페이지 카운트
	int selectCountNotice();
	
	// 공지사항 상세보기
	Notice selectNoticeOne(int noticeId);
	
	// 공지사항 추가
	int insertNotice(Notice notice);
	
	// 공지사항 수정
	int updateNotice(Notice notice);
	
	// 공지사항 삭제
	int deleteNotice(int noticeId);
}