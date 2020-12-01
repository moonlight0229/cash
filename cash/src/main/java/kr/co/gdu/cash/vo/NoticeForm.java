package kr.co.gdu.cash.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class NoticeForm {
	private int noticeId;
	private String noticeTitle;
	private String noticeContent;
	private String noticeDate;
	private String noticeUpdateDate;
	private List<MultipartFile> noticeFile;
	

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
	public List<MultipartFile> getNoticeFile() {
		return noticeFile;
	}
	public void setNoticeFile(List<MultipartFile> noticeFile) {
		this.noticeFile = noticeFile;
	}

	@Override
	public String toString() {
		return "NoticeForm [noticeId=" + noticeId + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeDate=" + noticeDate + ", noticeUpdateDate=" + noticeUpdateDate + ", noticeFile=" + noticeFile
				+ "]";
	}
}
