package kr.co.gdu.cash.vo;

public class NoticeFile {
	private int noticeFileId;
	private int noticeId;
	private String noticeFileName;
	private String noticeFileType;
	private long noticeFileSize;
	
	public int getNoticeFileId() {
		return noticeFileId;
	}
	public void setNoticeFileId(int noticeFileId) {
		this.noticeFileId = noticeFileId;
	}
	public int getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
	public String getNoticeFileName() {
		return noticeFileName;
	}
	public void setNoticeFileName(String noticeFileName) {
		this.noticeFileName = noticeFileName;
	}
	public String getNoticeFileType() {
		return noticeFileType;
	}
	public void setNoticeFileType(String noticeFileType) {
		this.noticeFileType = noticeFileType;
	}
	public long getNoticeFileSize() {
		return noticeFileSize;
	}
	public void setNoticeFileSize(long noticeFileSize) {
		this.noticeFileSize = noticeFileSize;
	}
	
	@Override
	public String toString() {
		return "NoticeFile [noticeFileId=" + noticeFileId + ", noticeId=" + noticeId + ", noticeFileName="
				+ noticeFileName + ", noticeFileType=" + noticeFileType + ", noticeFileSize=" + noticeFileSize + "]";
	}
}
