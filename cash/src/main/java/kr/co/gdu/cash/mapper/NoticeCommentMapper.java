package kr.co.gdu.cash.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.gdu.cash.vo.NoticeComment;

@Mapper
public interface NoticeCommentMapper {
	// 공지사항에 댓글 작성
	int insertNoticeComment(NoticeComment noticeComment);
	
	// 공지사항의 댓글 개별 삭제
	int deleteNoticeCommentOne(int noticeCommentId);
	
	// 공지사항 삭제 시 해당 공지사항의 댓글 일괄 삭제
	int deleteNoticeCommentAll(int boardId);
}
