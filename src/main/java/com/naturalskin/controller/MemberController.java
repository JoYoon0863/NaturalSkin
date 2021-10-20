package com.naturalskin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.naturalskin.dto.BasketDto;
import com.naturalskin.dto.MemberDto;
import com.naturalskin.dto.NoticeBoardDto;
import com.naturalskin.dto.OrderDetailDto;
import com.naturalskin.dto.OrderDto;
import com.naturalskin.dto.ProductDto;
import com.naturalskin.dto.QnaDto;
import com.naturalskin.dto.ReviewBoardDto;
import com.naturalskin.dto.ReviewReplyDto;
import com.naturalskin.service.BasketService;
import com.naturalskin.service.FileUploadService;
import com.naturalskin.service.MemberService;
import com.naturalskin.service.NoticeBoardService;
import com.naturalskin.service.OrderDetailService;
import com.naturalskin.service.OrderService;
import com.naturalskin.service.ProductService;
import com.naturalskin.service.QnaService;
import com.naturalskin.service.ReviewBoardService;
import com.naturalskin.service.ReviewReplyService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private NoticeBoardService noticeBoardService;
	@Autowired
	private QnaService qnaService;
	@Autowired
	private ReviewBoardService reviewBoardService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private ProductService productService;
	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private BasketService basketService;
	@Autowired
	private FileUploadService fileUploadService;
	@Autowired
	private ReviewReplyService reviewReplyService;
	
	@RequestMapping("brand")
	public String brand() {
		return "member/brand/brand";
	}
	
	// 리뷰 메인페이지
	@RequestMapping("reviewMain")
	public String reviewMain( @RequestParam(value="page", required=false, defaultValue="1" ) String page, Model model ) {
		model.addAttribute("page", page);
		model.addAttribute("count", reviewBoardService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		model.addAttribute("reviewBoard_list", reviewBoardService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum)));  //최상위 10개
		return "member/review/reviewMain";
	}
	
	// 리뷰 작성 폼
	@RequestMapping("reviewW")
	public String reviewW() {
		return "member/review/reviewW";
	}
	
	// 리뷰등록
	@RequestMapping(value = "reviewWA", method = RequestMethod.POST)
	public void reviewWA(@RequestParam("product_id") String product_id, @RequestParam("title") String title,
							@RequestParam("rating") String rating, @RequestParam("file") List<MultipartFile> file,
							@RequestParam("content") String content, HttpSession session, Model model, HttpServletResponse response) throws IOException {
		
		String id = (String)session.getAttribute("member_id");
		String contentImageUrl = fileUploadService.restore2(file);

		int result = reviewBoardService.reviewWA( id, product_id, title, rating, contentImageUrl, content );

		if( result == 1 ) {
			
			// 리뷰등록 후 리뷰작성 완료로 변경
//			orderDetailService.review();
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script language='javascript'>");
			out.println("alert('리뷰등록이 완료되었습니다.')");
			out.println("window.location.href='reviewMain'");
			out.println("</script>");
			out.flush();
		}
	}
	
	// 리뷰대상(상품) 선택
	@RequestMapping("reviewProductChoice")
	public String reviewProductChoice(HttpSession session, Model model ) {
		String id = (String)session.getAttribute("member_id");
		List<ProductDto> list = productService.myPageOrderList(id);
		model.addAttribute("list", list);
		
		return "member/review/reviewProductChoice";
	}
	
	// 리뷰 상세보기
	@RequestMapping("reviewV")
	public String reviewV( @RequestParam("review_board_id") String id, HttpSession session, Model model ) {
		ReviewBoardDto list = reviewBoardService.list(id);
		System.out.println(list.getProduct_id());
		ProductDto product_list = productService.reviewV(id, list.getProduct_id());
		model.addAttribute("list", list);
		model.addAttribute("product_list", product_list);
		
		// 댓글
		List<ReviewReplyDto> reviewList = reviewReplyService.list(id);
		model.addAttribute("reviewList", reviewList);
		
		return "member/review/reviewV";
	}
	
	// 댓글 작성
	@RequestMapping("replyW")
	public String replyW(@RequestParam("review_board_id") String review_id, @RequestParam("product_id") String product_id,
						@RequestParam("review_reply_content") String review_reply_content, HttpSession session, 
						HttpServletResponse response, Model model) {
		String id = (String)session.getAttribute("member_id");
		reviewReplyService.replyW(review_id, product_id, id, review_reply_content);
		return "redirect:reviewV?review_board_id=" + review_id; 
	}
	
	// 대댓글 작성
	@RequestMapping("rereplyW")
	public String rereplyW(@RequestParam("review_board_id") String review_id, @RequestParam("product_id") String product_id,
						@RequestParam("reply_content") String review_reply_content, @RequestParam("review_reply_id") String review_reply_id, 
						HttpSession session, HttpServletResponse response, Model model) {
		String id = (String)session.getAttribute("member_id");
		System.out.println("번호 : " + review_reply_id);
		reviewReplyService.rereplyW(review_id, product_id, id, review_reply_content, review_reply_id);
		return "redirect:reviewV?review_board_id=" + review_id; 
	}
	
	// 댓글 &대댓글 삭제
	@RequestMapping("replyD")
	public String replyD(@RequestParam("review_board_id") String review_id, @RequestParam("review_reply_id") String review_reply_id) {
		reviewReplyService.replyD(review_reply_id);
		return "redirect:reviewV?review_board_id=" + review_id; 
	}
	
	// 댓글 수정
	@RequestMapping("replyM")
	public String replyM(@RequestParam("review_board_id") String review_id, @RequestParam("review_reply_id") String review_reply_id,
						@RequestParam("content2") String content2) {
		reviewReplyService.replyM(review_reply_id, content2);
		return "redirect:reviewV?review_board_id=" + review_id; 
	}
	
	// 리뷰 수정 폼
	@RequestMapping("reviewM")
	public String reviewM(@RequestParam("review_board_id") String id, Model model) {
		ReviewBoardDto list = reviewBoardService.list(id);
		System.out.println(list.getProduct_id());
		ProductDto product_list = productService.reviewV(id, list.getProduct_id());
		model.addAttribute("list", list);
		model.addAttribute("product_list", product_list);
		return "member/review/reviewM";
	}
	
	// 리뷰 수정 액션
	@RequestMapping(value = "reviewMA", method = RequestMethod.POST)
	public void reviewMA(@RequestParam("review_board_id") String review_id, @RequestParam("title") String title,
							@RequestParam("rating") String rating, @RequestParam("file") List<MultipartFile> file,
							@RequestParam("content") String content, HttpSession session, Model model, HttpServletResponse response) throws IOException {
		
		String contentImageUrl = fileUploadService.restore2(file);

		int result = reviewBoardService.reviewMA( review_id, title, rating, contentImageUrl, content );

		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('수정이 완료되었습니다.')");
			out.println("window.location.href='reviewV?review_board_id="+ review_id +"'");
			out.println("</script>");

			out.flush();
		}
	}
	
	// 리뷰 삭제 폼
	@RequestMapping("reviewAlert")
	public String reviewAlert() {
		return "member/review/reviewAlert";
	}
	
	// 리뷰 삭제 액션
	@RequestMapping("reviewAlertA")
	public void reviewAlertA(@RequestParam("review_board_id") String id, HttpServletResponse response) throws IOException {
		int result = reviewBoardService.delete(id);
		System.out.println(id);
		System.out.println(result);
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('리뷰가 삭제되었습니다.')");
			out.println("window.close();");
			out.println("opener.window.location.href='reviewMain'");
			out.println("</script>");
			out.flush();
		}
		
	}
	
	// 공지사항 메인페이지
	@RequestMapping("noticeMain")
	public String noticeMain( @RequestParam(value="page", required=false, defaultValue="1" ) String page, Model model ) {
		model.addAttribute("page", page);
		model.addAttribute("count", noticeBoardService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		model.addAttribute("noticeBoard_list", noticeBoardService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum)));  //최상위 10개
		return "member/notice/noticeMain";
	}
	
	// 검색
	@RequestMapping("noticeSearch")
	public String noticeBoardSearch( @RequestParam("select-box") String select_box, 
								@RequestParam("input") String input, Model model ) {		
		if( select_box.equals("1") ) {
			model.addAttribute("noticeBoard_list", noticeBoardService.SearchTitle( input ));	
		} 
		return "member/notice/noticeMain";
	}
	
	// 공지사항 상세보기
	@RequestMapping("noticeV")
	public String noticeV( @RequestParam("notice_id") String notice_board_id, Model model ) {
		NoticeBoardDto noticeBoardDto = noticeBoardService.noticeBoardContentView( notice_board_id );
		model.addAttribute("noticeBoardDto", noticeBoardDto);
		return "member/notice/noticeV";
	}
	
	// Q&A 상세보기 (유저글)
	@RequestMapping("qnaV1")
	public String qnaV1( @RequestParam("qna_board_id") String qna_board_id, Model model ) {
		QnaDto qnaDto = qnaService.qnaContentView( qna_board_id );
		model.addAttribute("qnaDto", qnaDto);
		return "member/qna/qnaV1";
	}
	
	// Q&A 상세보기 (유저글 + 답글)
	@RequestMapping("qnaV2")
	public String aQnaV2( @RequestParam("qna_board_id") String qna_board_id, Model model ) {
		System.out.println(qna_board_id);
		QnaDto qnaDto = qnaService.qnaContentView( qna_board_id );
		System.out.println(qnaDto.getQna_board_group_no());
		QnaDto dto = qnaService.qnaContentView( Integer.toString(qnaDto.getQna_board_group_no()));
		model.addAttribute("dto", dto);
		model.addAttribute("qnaDto", qnaDto);
		return "member/qna/qnaV2";
	}
	
	// Q&A 글 삭제 폼
	@RequestMapping("qnaAlert")
	public String qnaAlert() {
		return "member/qna/qnaAlert";
	}
	
	// Q&A 글 삭제 액션
	@RequestMapping("qnaAlertA")
	public void qnaAlertA( @RequestParam("qna_board_id") String qna_board_id, HttpServletResponse response ) throws IOException {
		System.out.println(qna_board_id);
		int result = qnaService.qnaDelete( qna_board_id );
		System.out.println(result);
		if( result >= 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script language='javascript'>");
			out.println("alert('해당 게시물이 삭제되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("window.window.opener.location.href='qnaMain'");
			out.println("</script>");
			out.flush();
		}	
	}
	
	// Q&A 수정 폼
	@RequestMapping("/qnaM")
	public String qnaM( @RequestParam("qna_board_id") String qna_board_id, Model model ) {
		QnaDto qnaDto = qnaService.qnaContentView( qna_board_id );
		model.addAttribute("qnaDto", qnaDto);
		return "member/qna/qnaM";
	}
	
	// Q&A 수정 액션
	@RequestMapping("qnaMA")
	public void qnaMA( @RequestParam("qna_board_id") String qna_board_id,
						@RequestParam("qna_board_type") String qna_board_type, 
						@RequestParam("product_id") int product_id, 
						@RequestParam("qna_board_lock") int qna_board_lock,
						@RequestParam("qna_board_title") String qna_board_title,
						@RequestParam("qna_board_content") String qna_board_content,
						HttpServletResponse response, HttpSession session, Model model ) throws IOException {
	
		if( qna_board_type.equals("배송") ) {
			product_id = 0;
		}
		
		int result = qnaService.qnaM( qna_board_id, qna_board_type, product_id, qna_board_lock, qna_board_title, qna_board_content );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script language='javascript'>");
			out.println("alert('수정되었습니다.')");
			out.println("window.window.location.href='qnaMain'");
			out.println("</script>");
			out.flush();
		}
	}	

	// Q&A 메인페이지
	@RequestMapping("qnaMain")
	public String qnaMain( @RequestParam(value="page", required=false, defaultValue="1" ) String page, Model model, HttpSession session ) {
		model.addAttribute("page", page);
		model.addAttribute("count", qnaService.pageCount());
		String id = (String)session.getAttribute("member_id");
		model.addAttribute("id", id);
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		List<MemberDto> member_list = memberService.qna_list();
		model.addAttribute("member_list", member_list);
		
		model.addAttribute("qna_list", qnaService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum)));  //최상위 10개
		return "member/qna/qnaMain";
	}
	
	// 글쓰기 폼
	@RequestMapping("qnaW")
	public String qnaW() {
		return "member/qna/qnaW";
	}
	
	// 글 등록 Action
	@RequestMapping("qnaWA")
	public void qnaWA( @RequestParam("qna_board_type") String qna_board_type, 
						@RequestParam("product_id") int product_id, 
						@RequestParam("qna_board_lock") int qna_board_lock,
						@RequestParam("qna_board_title") String qna_board_title,
						@RequestParam("qna_board_content") String qna_board_content,
						HttpServletResponse response, HttpSession session, Model model ) throws IOException {

		String id = (String)session.getAttribute("member_id");
		
		if( qna_board_type.equals("배송") ) {
			product_id = 0;
		}
		
		int result = qnaService.qnaWrite( id, qna_board_type, product_id, qna_board_lock, qna_board_title, qna_board_content );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('등록되었습니다.')");
			out.println("window.window.location.href='qnaMain'");
			out.println("</script>");
			out.flush();
		}

	}	
	
	// 회원가입 폼(약관동의)
	@RequestMapping("join")
	public String join() {
		return "member/join/join";
	}
	
	// 회원가입 폼(개인정보)
	@RequestMapping("join2")
	public String join2() {
		return "member/join/join2";
	}
	
	// 아이디 중복체크
	@RequestMapping(value = "idcheck", method = { RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public int idCheckAjax( @RequestParam Map<String, Object> param,HttpServletRequest request,Model model) {
		String id = (String) param.get("id");
		System.out.println(id);
		int result = memberService.idCheckAjax(id);
		System.out.println("result:" + result);
		
 		if(result >= 1) { //아이디 중복됨
	 		return(1);
	 	} else {
	 		return(0);
	 	}
 		
	}	

	// 회원가입 액션
	@RequestMapping("join2Action")
	public void join2Action( @RequestParam("member_id") String member_id, 
								@RequestParam("member_pw") String member_pw, 
								@RequestParam("member_name") String member_name, 
								@RequestParam("birthdayY") String birthdayY, 
								@RequestParam("birthdayM") String birthdayM,
								@RequestParam("birthdayD") String birthdayD, 
								@RequestParam("member_gender") String member_gender,
								@RequestParam("address") String address, 
								@RequestParam("detailAddress") String detailAddress,
								@RequestParam("member_phone") String member_phone,
								@RequestParam("member_email") String member_email, 
								HttpServletResponse response, Model model ) throws IOException {
		
		String member_birthday = birthdayY + birthdayM + birthdayD;
		String member_address = address + "/" + detailAddress;
		
		System.out.println(member_id);
		System.out.println(member_pw);
		System.out.println(member_name);
		System.out.println(member_birthday);
		System.out.println(member_gender);
		System.out.println(member_address);
		System.out.println(member_phone);
		System.out.println(member_email);
		
		int result = memberService.newMember( member_id, member_pw, member_name, member_birthday, member_gender, member_address, member_phone, member_email );
		
		if ( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('회원가입이 완료되었습니다.')");
			out.println("window.window.location.href='login'");
			out.println("</script>");
		}

	}
	
	// 로그인 폼
	@RequestMapping("login")
	public String login() {
		return "member/login/login";
	}
	
	// 로그인 액션
	@RequestMapping("loginAction")
	public String loginAction( @RequestParam("id") String id, @RequestParam("pw") String pw, 
								Model model, HttpServletRequest request ) {
		System.out.println("id : " + id);
		System.out.println("pw : " + pw);
		int result = memberService.login( id, pw );
		
		if (result == 1 ) {
			System.out.println("로그인 성공");
			request.getSession().setAttribute("member_id", id);
			return "redirect:/";
		} else {
			System.out.println("로그인 실패");
			model.addAttribute("alert", "아이디, 비밀번호를 확인해주세요.");
			return "member/login/login";
		}
		
	}
	
	// 로그아웃
	@RequestMapping("logoutAction")
	public String logoutAction( Model model, HttpSession session ) {
		session.invalidate(); // 세션 종료
		return "redirect:/";
	}
	
	// 아이디찾기 폼
	@RequestMapping("idSearch")
	public String passwordfind1() {
		return "member/login/loginSearch";
	}
	
	// 아이디찾기 결과
	@RequestMapping("searchIdAlert")
	public String searchIdAlert( @RequestParam("member_name") String name, @RequestParam("member_email") String email, 
			@RequestParam("member_phone") String phone, @RequestParam("findBy") String findBy, Model model) {

		if( findBy.equals("1") ) {
			model.addAttribute("dto", memberService.emailIdFind(name, email));
		} else if( findBy.equals("2") ) {
			model.addAttribute("dto", memberService.phoneIdFind(name, phone));
		}
		return "member/login/searchIdAlert";
	}
	
	// 비밀번호찾기 폼
	@RequestMapping("pwSearch")
	public String passwordfind2() {
		return "member/login/loginSearch2";
	}
	
	// 비밀번호찾기 결과
	@RequestMapping("searchPwAlert")
	public String searchPwAlert(@RequestParam("member_id") String id, @RequestParam("member_name") String name, @RequestParam("member_email") String email, 
			@RequestParam("member_phone") String phone, @RequestParam("findBy") String findBy, Model model) {
		
		String pw = null;
		
		if( findBy.equals("1") ) {
			int result = memberService.pwUpdate( id, name, email, pw );
			if( result == 1 ) {
				model.addAttribute("dto", memberService.emailPwFind(id, name, email));
			}	
		} else if( findBy.equals("2") ) {
			int result = memberService.pwUpdate2( id, name, phone, pw );
			if( result == 1 ) {
				model.addAttribute("dto", memberService.phonePwFind(id, name, phone));
			}
		}
		
		return "member/login/searchPwAlert";
	}
	
	// 마이페이지 메인
	@RequestMapping("myPageMain")
	public String myPageMamin( @RequestParam(value="page", required=false, defaultValue="1") String page, HttpSession session, Model model ) {
		model.addAttribute("page", page);
		model.addAttribute("count", orderService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		String id = (String)session.getAttribute("member_id");
		List<OrderDto> order_list = orderService.myOrder(String.valueOf(startRowNum), String.valueOf(endRowNum), id);  //최상위 10개
		List<ProductDto> list = productService.myPageOrderList(id);
		
		model.addAttribute("order_list", order_list);
		model.addAttribute("list", list);
		return "member/mypage/myPageMain";
	}
	
	// 마이페이지 회원정보 폼
	@RequestMapping("myPageM")
	public String myPageM( HttpSession session, Model model ) {
		String id = (String)session.getAttribute("member_id");
		MemberDto memberDto = memberService.memberInformation(id);
		String member_birthday = Integer.toString(memberDto.getMember_birthday());
		String[] birthday = new String[3];
		birthday[0] = member_birthday.substring(0, 4);
		birthday[1] = member_birthday.substring(4, 6);
		birthday[2] = member_birthday.substring(6, 8);
		
		model.addAttribute("birthday", birthday);
		
		String member_address = memberDto.getMember_address();
		String[] address = member_address.split("/");
		
		model.addAttribute("address", address);
		model.addAttribute("memberDto", memberDto);
		return "member/mypage/myPageM";
	}
	
	// 마이페이지 회원정보 수정
	@RequestMapping("myPageMAction")
	public void memberInformationUpdate( @RequestParam("member_id") String member_id, 
											@RequestParam("member_pw") String member_pw, 
											@RequestParam("member_name") String member_name, 
											@RequestParam("birthdayY") String birthdayY, 
											@RequestParam("birthdayM") String birthdayM,
											@RequestParam("birthdayD") String birthdayD, 
											@RequestParam("member_gender") String member_gender,
											@RequestParam("address") String address, 
											@RequestParam("detailAddress") String detailAddress,
											@RequestParam("member_phone") String member_phone,
											@RequestParam("member_email") String member_email, 
											HttpServletResponse response, Model model ) throws IOException {
		
		String member_birthday = birthdayY + birthdayM + birthdayD;
		String member_address = address + "/" + detailAddress;
		
		int result = memberService.memberInformationUpdate( member_id, member_pw, member_name, member_birthday, member_gender, member_address, member_phone, member_email );
		
		if ( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('회원정보 수정이 완료되었습니다.')");
			out.println("window.location.href='myPageM'");
			out.println("</script>");

			out.flush();
		}

	}
	
	// 회원탈퇴 폼
	@RequestMapping("quitAlert")
	public String quitAlert() {
		return "member/mypage/quitAlert";
	}
	
	// 회원탈퇴 Action
	@RequestMapping("memberDrop")
	public void memberDrop( HttpSession session, HttpServletResponse response, Model model ) throws IOException {
		
		String id = (String)session.getAttribute("member_id");
		int result = memberService.memberDrop( id );

		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('회원 탈퇴되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}
		
	}
	
	// 마이페이지 리뷰게시판
	@RequestMapping("myPageReview")
	public String myPageReview( @RequestParam(value="page", required=false, defaultValue="1") String page, HttpSession session, Model model ) {
		model.addAttribute("page", page);
		model.addAttribute("count", reviewBoardService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		String id = (String)session.getAttribute("member_id");
		List<ReviewBoardDto> review_list = reviewBoardService.myReviewList(String.valueOf(startRowNum), String.valueOf(endRowNum), id);
		model.addAttribute("review_list", review_list);
		return "member/mypage/myPageReview";
	}
	
	// 마이페이지 Q&A게시판
	@RequestMapping("myPageQna")
	public String myPageQna(@RequestParam(value="page", required=false, defaultValue="1") String page, HttpSession session, Model model ) {
		model.addAttribute("page", page);
		model.addAttribute("count", qnaService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		String id = (String)session.getAttribute("member_id");
		List<QnaDto> qna_list = qnaService.myQnaList(String.valueOf(startRowNum), String.valueOf(endRowNum), id);
		model.addAttribute("qna_list", qna_list);
		return "member/mypage/myPageQna";
	}
	
	// 주문상세 페이지
	@RequestMapping("myPageOrder")
	public String myPageOrder( @RequestParam("member_order_id") String id, Model model ) {
		System.out.println(id);
		OrderDto dto = orderService.myPageOrder(id);
		List<OrderDetailDto> orderDetail = orderDetailService.myPageOrder(id);
		List<ProductDto> productDto = productService.myPageOrder(id);
		model.addAttribute("dto", dto);
		model.addAttribute("orderDetail", orderDetail);
		model.addAttribute("pDto", productDto);
		return "member/mypage/myPageOrder";
	}
	
	// 배송조회
	@RequestMapping("trackAlert")
	public String trackAlert() {
		return "member/mypage/trackAlert";
	}
	
	// 배송정보 변경 폼
	@RequestMapping("myPageOrderM")
	public String myPageOrderM() {
		return "member/mypage/myPageOrderM";
	}
	
	// 배송정보 변경 폼
	@RequestMapping("myPageOrderMA")
	public void myPageOrderMA( @RequestParam("id") String id, @RequestParam("name") String name, 
								@RequestParam("address1") String address1, @RequestParam("address2") String address2, 
								@RequestParam("phone") String phone, HttpServletResponse response, Model model ) throws IOException {
		
		String address = address1 + "/" + address2;
		int result = orderService.update(id, name, address, phone);
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('수정이 완료되었습니다.')");
			out.println("window.close()");
			out.println("opener.window.location.reload()");
			out.println("</script>");

			out.flush();
		}
	}

	// 주문취소 폼
	@RequestMapping("cancelAlert")
	public String cancelAlert() {
		return "member/mypage/cancelAlert";
	}
	
	// 주문취소 
	@RequestMapping("cancelAlertA")
	public void cancelAlertA( @RequestParam("id") String id, HttpServletResponse response ) throws IOException {
		int result = orderService.cancle(id);
		System.out.println("결과 : " + result);
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script language='javascript'>");
			out.println("alert('주문취소요청이 완료되었습니다.')");
			out.println("window.close()");
			out.println("opener.window.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();
		}
		
	}
	
	// 상품목록
	@RequestMapping("productMain")
	public String productMain( Model model ) {
		List<ProductDto> product_list = productService.product_list();
		model.addAttribute("product_list", product_list);
		return "member/product/productMain";
	}
	
	// 상품 상세정보
	@RequestMapping("productV")
	public String productV( @RequestParam("product_id") String id, Model model ) {
		ProductDto productDto = productService.productContentView( id );
		model.addAttribute("dto", productDto);
		List<ReviewBoardDto> reviewList = reviewBoardService.reviewList(id);
		model.addAttribute("reviewList", reviewList);
		List<QnaDto> qnaList = qnaService.productQna(id);
		model.addAttribute("qnaList", qnaList);
		return "member/product/productV";
	}
	
	// 상품 장바구니에 저장
	@RequestMapping("productVA")
	public void productVA( @RequestParam("product_id") String product_id, @RequestParam("amount") int amount, 
							HttpSession session, HttpServletResponse response, Model model ) throws IOException {
		
		String id = (String)session.getAttribute("member_id");
		System.out.println(id);
		System.out.println(product_id);
		System.out.println(amount);
		
		int result = basketService.add(id, product_id, amount);
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("window.open('productAlert','','width=600, height=200');");
			out.println("</script>");

			out.flush();
		}
	}
	
	@RequestMapping("productAlert")
	public String productAlert() {
		return "member/product/productAlert";
	}
	
	// 장바구니 수량 변경
	@RequestMapping("basket1")
	@ResponseBody
	public String basket1( HttpSession session, Model model, @RequestParam Map<String, Object> param ) {
		String bid = (String) param.get("basket_num");
		String amount = (String) param.get("amount");
		
		System.out.println("번호 : " + bid);
		System.out.println("수량 : " + amount);
		
		int result = basketService.update(bid, amount);
		System.out.println("결과 : " + result);
		if(result >= 1) { //아이디 중복됨
	 		return("1");
	 	} else {
	 		return("0");
	 	}	
	}
	
	// 장바구니 폼
	@RequestMapping("basket")
	public String basket( HttpSession session, Model model, @RequestParam Map<String, Object> param ) {
		String id = (String)session.getAttribute("member_id");
		
		int count = basketService.count(id);
		System.out.println("갯수 : "+count);
		model.addAttribute("count", count);
		
		List<BasketDto> list = basketService.list(id);
		model.addAttribute("list", list);
		List<ProductDto> product_list = productService.basketList(id);
		model.addAttribute("product_list", product_list);
		
		String basket_id = (String) param.get("basket_id");
		String member_id = (String) param.get("id");
		System.out.println("a : " + basket_id);
		System.out.println(member_id);
		if ( basket_id != null ) {
			basketService.selectDelete(basket_id);
		}
		
		if ( member_id != null ) {
			basketService.allDelete(member_id);
		}
		return "member/basket/basket";
	}
		
	// 상품 구매 폼
	@RequestMapping("order2")
	public String order2( HttpSession session, Model model, @RequestParam Map<String, Object> param ) {
		
		String id = (String)session.getAttribute("member_id");
		
		int count = basketService.count(id);
		model.addAttribute("count", count);
		List<BasketDto> basket = basketService.list(id);
		model.addAttribute("basket", basket);
		List<ProductDto> product_list = productService.basketList(id);
		model.addAttribute("product_list", product_list);
		
		MemberDto dto = memberService.memberInformation(id);
		String member_address = dto.getMember_address();
		String[] address = member_address.split("/");
		
		model.addAttribute("address", address);
		model.addAttribute("dto", dto);
		return "member/order/order2";
	}
	
	// 상품 구매 폼
	@RequestMapping("order")
	public String order( HttpSession session, Model model ) {
		String id = (String)session.getAttribute("member_id");
		MemberDto dto = memberService.memberInformation(id);
		String member_address = dto.getMember_address();
		String[] address = member_address.split("/");
		
		model.addAttribute("address", address);
		model.addAttribute("dto", dto);
		return "member/order/order";
	}
	
	// 상품 구매
	@RequestMapping("orderAction")
	public void orderAction( @RequestParam("name") String name, 
								@RequestParam("address") String address, 
								@RequestParam("detailAddress") String detailAddress, 
								@RequestParam("phone") String phone, 
								@RequestParam("product_id") String product_id, 
								@RequestParam("amount") String amount, 
								@RequestParam("price") String price, 
								@RequestParam("sum") int sum, 
								@RequestParam("radio") String radio,
								@RequestParam("count") int count,
								HttpSession session, HttpServletResponse response, HttpServletRequest request, Model model ) throws IOException {
 		
		String id = (String)session.getAttribute("member_id");
		String order_address = address + "/" + detailAddress;
			
		int result = orderService.order(id, sum, radio, order_address, name, phone);

		if ( result == 1 ) {
			int order_id = orderService.myOrderCheck(id);
			request.getSession().setAttribute("order_id", order_id);

			
			String[] pId = product_id.split(",");
			String[] amounts = amount.split(",");
			String[] prices = price.split(",");

			int orderDetail = 0;
			for(int i=0; i<count; i++) {
				orderDetail = orderDetailService.orderDetail(order_id, id, pId[i], amounts[i], prices[i]);
			}
			
			if( order_id > 0 && orderDetail > 0) {
				basketService.allDelete(id);
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();

				out.println("<script language='javascript'>");
				out.println("window.open('orderAlert','','width=600, height=200');");
				out.println("</script>");
				out.flush();
			}
		}
	}
	
	@RequestMapping("orderAlert")
	public String orderAlert() {
		return "member/order/orderAlert";
	}
	
	@RequestMapping("orderAlertA")
	public void orderAlertA(HttpSession session, HttpServletResponse response, Model model) throws IOException {
		int order_id = (Integer)session.getAttribute("order_id");
		model.addAttribute("order_id", order_id);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<script language='javascript'>");
		out.println("window.close()");
		out.println("window.opener.close()");
		out.println("opener.opener.window.location.href='myPageOrder?member_order_id="+ order_id +"'");
		out.println("</script>");

		out.flush();
	}
}
