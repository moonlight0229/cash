package kr.co.gdu.cash.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.gdu.cash.mapper.NoticeCommentMapper;
import kr.co.gdu.cash.vo.NoticeComment;

@Service
@Transactional
public class NoticeCommentService {
	@Autowired private NoticeCommentMapper noticeCommentMapper;
	
	// 댓글 작성
	public int addNoticeComment(NoticeComment noticeComment) {
		return noticeCommentMapper.insertNoticeComment(noticeComment);
	}
	
	// 댓글 개별 삭제
	public int removeNoticeComment(int noticeCommentId) {
		return noticeCommentMapper.deleteNoticeCommentOne(noticeCommentId);
	}
}
