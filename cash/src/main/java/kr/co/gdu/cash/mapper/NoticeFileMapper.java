package kr.co.gdu.cash.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gdu.cash.vo.NoticeFile;

@Mapper
public interface NoticeFileMapper {
	// 해당 공지사항에 첨부된 파일이름 목록 불러오기
	List<String> selectNoticeFileNameList(int noticeId);
	
	// 파일 업로드
	int insertNoticeFile(NoticeFile noticeFile);
	
	// 공지사항 수정 시 삭제할 파일이름 불러오기
	String selectDelNoticeFileName(int noticeFileId);
	
	// 공지사항 수정 시 첨부파일 개별 삭제
	int deleteNoticeFileOne(int noticeFileId);
	
	// 공지사항 삭제 시 첨부파일 일괄 삭제
	int deleteNoticeFileAll(int noticeId);
}
