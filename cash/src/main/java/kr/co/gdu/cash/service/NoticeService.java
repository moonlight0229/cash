package kr.co.gdu.cash.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.gdu.cash.mapper.CashbookMapper;
import kr.co.gdu.cash.mapper.NoticeCommentMapper;
import kr.co.gdu.cash.mapper.NoticeFileMapper;
import kr.co.gdu.cash.mapper.NoticeMapper;
import kr.co.gdu.cash.vo.Notice;
import kr.co.gdu.cash.vo.NoticeFile;
import kr.co.gdu.cash.vo.NoticeForm;

@Service
@Transactional
public class NoticeService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private NoticeMapper noticeMapper;
	@Autowired private NoticeFileMapper noticeFileMapper;
	@Autowired private NoticeCommentMapper noticeCommentMapper;
	@Autowired private CashbookMapper cashbookMapper;
	
	private final String PATH = "/home/ubuntu/tomcat9/cash/src/main/webapp/upload";
	
	// index에 공지사항 5개 출력 출력
	public List<Notice> getNoticeList() {
		return noticeMapper.selectLatestNoticeList();
	}
	
	// 공지사항을 페이징하는 메소드
	public Map<String, Object> getNoticeListByPage(int currentPage) {
		// 한 페이지에 보여줄 항목 10개 
		int rowPerPage = 10;
		// 해당 페이지에 표시한 항목
		int beginRow = (currentPage - 1) * rowPerPage;
		// 총 항목수
		int totalCount = noticeMapper.selectCountNotice();
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
		
		List<Notice> noticeList = noticeMapper.selectNoticeListByPage(paramMap);
		returnMap.put("noticeList", noticeList);
		
		return returnMap;
	}
	
	// index 페이지에 최신 공지사항 5개와 최근 3달간 수입/지출 내역을 보여주는 메소드
	public Map<String, Object> getNoticeAndInOutList() {
		List<Notice> noticeList = noticeMapper.selectLatestNoticeList();
		List<Map<String, Object>> inOutList = cashbookMapper.selectCashInOutList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeList", noticeList);
		map.put("inOutList", inOutList);		
		return map;
	}
	
	// 공지사항 상세정보
	public Notice getNoticeOne(int noticeId) {
		Notice noticeOne = noticeMapper.selectNoticeOne(noticeId);
		return noticeOne;
	}

	// 공지사항 추가
	public void addNotice(NoticeForm noticeForm) {
		Notice notice = new Notice();
		notice.setNoticeTitle(noticeForm.getNoticeTitle());
		notice.setNoticeContent(noticeForm.getNoticeContent());
		notice.setNoticeDate(noticeForm.getNoticeDate());
		notice.setNoticeUpdateDate(noticeForm.getNoticeUpdateDate());
		noticeMapper.insertNotice(notice);
		
		List<NoticeFile> noticeFile = null;
		if(noticeForm.getNoticeFile() != null) {
			noticeFile = new ArrayList<NoticeFile>();
			for(MultipartFile mf : noticeForm.getNoticeFile()) {
				NoticeFile nf = new NoticeFile();
				nf.setNoticeId(notice.getNoticeId());
				// 확장장 명 바로 앞의 '.' 찾기
				int p = mf.getOriginalFilename().lastIndexOf(".");
				// 확장자 명을 ext에 저장
				String ext = mf.getOriginalFilename().substring(p).toLowerCase();
				// 첨부 될 파일의 이름에 '-'를 ''로 변경 후 fileName에 저장
				String fileName = UUID.randomUUID().toString().replace("-", "");
				nf.setNoticeFileName(fileName+ext);
				nf.setNoticeFileType(mf.getContentType());
				nf.setNoticeFileSize(mf.getSize());
				noticeFile.add(nf);
				logger.debug("for 문 : " + nf);
				try {
					mf.transferTo(new File(PATH+fileName+ext));
				} catch(Exception e) {
					e.printStackTrace();
					throw new RuntimeException();
				}
			}
		}
		if(noticeFile != null) {
			for(NoticeFile nf : noticeFile) {
				noticeFileMapper.insertNoticeFile(nf);
			}
		}
	}

	// 공지사항 수정
	public void modifyNotice(NoticeForm noticeForm) {
		Notice notice = new Notice();
		notice.setNoticeId(noticeForm.getNoticeId());
		notice.setNoticeTitle(noticeForm.getNoticeTitle());
		notice.setNoticeContent(noticeForm.getNoticeContent());
		notice.setNoticeUpdateDate(noticeForm.getNoticeUpdateDate());
		noticeMapper.updateNotice(notice);
		List<NoticeFile> noticeFile = null;
		if(noticeForm.getNoticeFile() != null) {
			noticeFile = new ArrayList<NoticeFile>();
			for(MultipartFile mf : noticeForm.getNoticeFile()) {
				NoticeFile nf = new NoticeFile();
				nf.setNoticeId(notice.getNoticeId());
				// 확장장 명 바로 앞의 '.' 찾기
				int p = mf.getOriginalFilename().lastIndexOf(".");
				// 확장자 명을 ext에 저장
				String ext = mf.getOriginalFilename().substring(p).toLowerCase();
				// 첨부 될 파일의 이름에 '-'를 ''로 변경 후 fileName에 저장
				String fileName = UUID.randomUUID().toString().replace("-", "");
				nf.setNoticeFileName(fileName+ext);
				nf.setNoticeFileType(mf.getContentType());
				nf.setNoticeFileSize(mf.getSize());
				noticeFile.add(nf);
				try {
					mf.transferTo(new File(PATH+fileName+ext));
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException();
				}
			}
		}
		if(noticeFile != null) {
			for(NoticeFile nf : noticeFile) {
				noticeFileMapper.insertNoticeFile(nf);
			}
		}		
	}
	
	// 공지사항 수정 시 첨부된 파일 삭제
	public void removeNoticeFileOne(int noticeFileId) {
		String removeFile = noticeFileMapper.selectDelNoticeFileName(noticeFileId);
		File file = new File(PATH+removeFile);
		file.delete();
		noticeFileMapper.deleteNoticeFileOne(noticeFileId);
	}
	
	// 공지사항 삭제
	public void removeNotice(int noticeId) {
		// 해당 공지사항에 첨부된 실제 파일을 폴더에서 일괄 삭제
		List<String> noticeFileNameList = noticeFileMapper.selectNoticeFileNameList(noticeId);
		for(String s : noticeFileNameList) {
			File file = new File(PATH+s);
			if(file.exists()) {
				file.delete();
			}
		}
		// 해당 공지사항에 작성된 댓글 일괄 삭제
		noticeCommentMapper.deleteNoticeCommentAll(noticeId);
		// 해당 공지사항에 첨부된 파일 경로 일괄 삭제
		noticeFileMapper.deleteNoticeFileAll(noticeId);
		// 해당 공지사항 삭제
		noticeMapper.deleteNotice(noticeId);
	}
}
