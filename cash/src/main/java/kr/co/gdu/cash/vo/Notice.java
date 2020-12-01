package kr.co.gdu.cash.vo;

import java.util.List;

public class Notice {
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private String noticeDate;
	private String noticeUpdateDate;
	private List<NoticeFile> noticeFileList;
	private List<NoticeComment> noticeCommentList;
	
	public int getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}
	public String getNoticeUpdateDate() {
		return noticeUpdateDate;
	}
	public void setNoticeUpdateDate(String noticeUpdateDate) {
		this.noticeUpdateDate = noticeUpdateDate;
	}
	public List<NoticeFile> getNoticeFileList() {
		return noticeFileList;
	}
	public void setNoticeFileList(List<NoticeFile> noticeFileList) {
		this.noticeFileList = noticeFileList;
	}
	public List<NoticeComment> getNoticeCommentList() {
		return noticeCommentList;
	}
	public void setNoticeCommentList(List<NoticeComment> noticeCommentList) {
		this.noticeCommentList = noticeCommentList;
	}
	
	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeDate=" + noticeDate + ", noticeUpdateDate=" + noticeUpdateDate + ", noticeFileList="
				+ noticeFileList + ", noticeCommentList=" + noticeCommentList + "]";
	}
}
