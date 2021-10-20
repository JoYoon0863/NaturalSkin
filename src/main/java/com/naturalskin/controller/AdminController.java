package com.naturalskin.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.naturalskin.dto.MemberDto;
import com.naturalskin.dto.NoticeBoardDto;
import com.naturalskin.dto.OrderDto;
import com.naturalskin.dto.ProductDto;
import com.naturalskin.dto.QnaDto;
import com.naturalskin.service.FileUploadService;
import com.naturalskin.service.MemberService;
import com.naturalskin.service.NoticeBoardService;
import com.naturalskin.service.OrderService;
import com.naturalskin.service.ProductService;
import com.naturalskin.service.QnaService;

@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private NoticeBoardService noticeBoardService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private ProductService productService;
	@Autowired
	private QnaService qnaService;
	@Autowired
	private ServletContext context;
	@Autowired
	private FileUploadService fileUploadService;
	
	// 메인페이지
	@RequestMapping("/")
	public String index( Model model, HttpSession session ) {
		String id = (String)session.getAttribute("member_id");
		List<ProductDto> list = productService.product_list();
		model.addAttribute("list", list);
		List<NoticeBoardDto> list2 = noticeBoardService.noticeBoard_list();
		model.addAttribute("list2", list2);
		model.addAttribute("memberInfo", memberService.memberInfo( id ));
		return "index";
	}
	
	// 관리자 페이지(메인)
	@RequestMapping("aMain")
	public String aMain( Model model ) {
		model.addAttribute("admin_count", memberService.admin_count());
		model.addAttribute("users_count", memberService.users_count());
		model.addAttribute("order_count", orderService.order_count());
		model.addAttribute("orderCancel_count", orderService.orderCancel_count());
		model.addAttribute("qna_count", qnaService.qna_count());
		model.addAttribute("product_count", productService.product_count());
		
		return "admin/aMain";
	}
	
	// 회원목록
	@RequestMapping("aMemberMain")
	public String aMemberMain( @RequestParam(value="page", required=false, defaultValue="1" ) String page, Model model ) {		
		
		System.out.println("page : " + page);
		model.addAttribute("page", page);
		model.addAttribute("count", memberService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 5; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		System.out.println("startRowNum:"+startRowNum);
		System.out.println("endRowNum:"+endRowNum);
		
		model.addAttribute("member_list", memberService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum)));  //최상위 10개
//		model.addAttribute("member_list", memberService.member_list());	
		
		return "admin/member/aMemberMain";
	}
	
	// 검색
	@RequestMapping("memberSearch")
	public String memberSearch( @RequestParam("select-box") String select_box, 
								@RequestParam("input") String input, 
								@RequestParam("role") String role, Model model ) {		
		
		if( select_box.equals("1") ) {
			model.addAttribute("member_list", memberService.SearchID( input ));	
		} 
		else if ( select_box.equals("2") ) {
			model.addAttribute("member_list", memberService.SearchName( input ));	
		}
		else if ( select_box.equals("3") ) {
			model.addAttribute("member_list", memberService.SearchRole( role ));	
		}
	
		return "admin/member/aMemberMain";
	}
	
	// 회원정보확인
	@RequestMapping("aMemberV")
	public String aMemberV( @RequestParam("member_id") String member_id, Model model ) {
		
		MemberDto memberDto = memberService.memberInformation( member_id );
		
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
		
		return "admin/member/aMemberV";
	}
	
	// 회원정보 수정
	@RequestMapping("memberInformationUpdate")
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
			out.println("window.close()");
			out.println("opener.window.location.reload()");
			out.println("</script>");

			out.flush();
		}

	}
	
	// 회원탈퇴 View
	@RequestMapping("aMemberAlert")
	public String dropAlert( @RequestParam("member_id") String member_id, Model model ) {
		return "admin/member/aMemberAlert";
	}
	
	// 회원탈퇴 Action
	@RequestMapping("aMemberDrop")
	public void memberDrop( @RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response, Model model ) throws IOException {
		
		System.out.println("아이디 : " + member_id);
		int result = memberService.memberDrop( member_id );
		model.addAttribute("result", result);
		
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

	// 주문목록 메인페이지
	@RequestMapping("aOrderMain")
	public String aOrderMain( @RequestParam(value="page", required=false, defaultValue="1") String page, Model model ) {
		
		model.addAttribute("page", page);
		model.addAttribute("count", orderService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		List<OrderDto> order_list = orderService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum));  //최상위 10개
		
		if( order_list != null ) {
			ArrayList<Integer> num = new ArrayList<Integer>();
			for( int i=order_list.size(); i>=0; i-- ) {
				num.add(i);
			}
			model.addAttribute("num", num);
			
			List<MemberDto> member_list = memberService.order_list();
			model.addAttribute("member_list", member_list);
		}
		
		model.addAttribute("order_list", order_list);
		

		return "admin/order/aOrderMain";
	}
	
	// 주문 목록
	@RequestMapping("aOrderNew")
	public String aOrderNew( @RequestParam(value="page", required=false, defaultValue="1") String page, Model model ) {
		
		model.addAttribute("page", page);
		model.addAttribute("count", orderService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		List<OrderDto> order_list = orderService.newOrder(String.valueOf(startRowNum), String.valueOf(endRowNum));  //최상위 10개
		
		if( order_list != null ) {
			ArrayList<Integer> num = new ArrayList<Integer>();
			for( int i=order_list.size(); i>=0; i-- ) {
				num.add(i);
			}
			model.addAttribute("num", num);
			
			List<MemberDto> member_list = memberService.order_list();
			model.addAttribute("member_list", member_list);
		}
		
		model.addAttribute("order_list", order_list);
		

		return "admin/order/aOrderMain";
	}
	
	// 주문 취소
	@RequestMapping("orderCancel")
	public String orderCancel( @RequestParam(value="page", required=false, defaultValue="1") String page, Model model ) {
		
		model.addAttribute("page", page);
		model.addAttribute("count", orderService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		List<OrderDto> order_list = orderService.orderCancel(String.valueOf(startRowNum), String.valueOf(endRowNum));  //최상위 10개
		
		if( order_list != null ) {
			ArrayList<Integer> num = new ArrayList<Integer>();
			for( int i=order_list.size(); i>=0; i-- ) {
				num.add(i);
			}
			model.addAttribute("num", num);
			
			List<MemberDto> member_list = memberService.order_list();
			model.addAttribute("member_list", member_list);
		}
		
		model.addAttribute("order_list", order_list);
		

		return "admin/order/aOrderMain";
	}
		
	// 검색
	@RequestMapping("orderSearch")
	public String orderSearch( @RequestParam("select-box") String select_box, 
								@RequestParam("input") String input, Model model ) {		
		
		if( select_box.equals("아이디") ) {
			List<OrderDto> order_list = orderService.SearchID( input );
			System.out.println(order_list.size());
			
			if( order_list != null ) {
				ArrayList<Integer> num = new ArrayList<Integer>();
				for( int i=order_list.size(); i>=0; i-- ) {
					num.add(i);
				}
				model.addAttribute("num", num);
				
				List<MemberDto> member_list = memberService.order_list();
				model.addAttribute("member_list", member_list);
				model.addAttribute("order_list", order_list);	
			}
		} 
		else if( select_box.equals("이름") ) {
			List<OrderDto> order_list = orderService.SearchName( input );
			System.out.println(order_list.size());
			
			if( order_list != null ) {
				ArrayList<Integer> num = new ArrayList<Integer>();
				for( int i=order_list.size(); i>=0; i-- ) {
					num.add(i);
				}
				model.addAttribute("num", num);
				
				List<MemberDto> member_list = memberService.order_list();
				model.addAttribute("member_list", member_list);
				model.addAttribute("order_list", order_list);	
			}
		}
		else if( select_box.equals("주문번호") ) {
			List<OrderDto> order_list = orderService.SearchOrderNum( input );

			if( order_list != null ) {
				ArrayList<Integer> num = new ArrayList<Integer>();
				for( int i=order_list.size(); i>=0; i-- ) {
					num.add(i);
				}
				model.addAttribute("num", num);
				
				List<MemberDto> member_list = memberService.order_list();
				model.addAttribute("member_list", member_list);
				model.addAttribute("order_list", order_list);	
			}
		}
	
		return "admin/order/aOrderMain";
	}

	// 주문상세페이지
	@RequestMapping("aOrderV")
	public String aOrderV( @RequestParam("member_order_id") String member_order_id, Model model ) {
		
		OrderDto orderDto = orderService.orderView( member_order_id );
		
		String receive_address = orderDto.getMember_order_receive_address();
		String[] address = receive_address.split("/");
		
		model.addAttribute("address", address);
		model.addAttribute("orderDto", orderDto);
		
		return "admin/order/aOrderV";
	}
	
	// 주문상세페이지 수정
	@RequestMapping("aOrderViewUpdate")
	public void aOrderViewUpdate( @RequestParam("member_order_id") String member_order_id, 
									@RequestParam("receive_name") String receive_name,
									@RequestParam("receive_address") String receive_address, 
									@RequestParam("receive_detailAddress") String receive_detailAddress, 
									@RequestParam("receive_phone") String receive_phone, 
									@RequestParam("order_state") String order_state,
									HttpServletResponse response, Model model ) throws IOException {
		
		String address = receive_address + "/" + receive_detailAddress;
		int result = orderService.aOrderViewUpdate( member_order_id, receive_name, address, receive_phone, order_state );
		System.out.println(result);
		if ( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('주문이 수정되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();
		}

	}
	
	// 주문 삭제 View
	@RequestMapping("aOrderAlert")
	public String aOrderAlert() {
		return "admin/order/aOrderAlert";
	}
	
	// 주문 삭제 Action
	@RequestMapping("aOrderDelete")
	public void orderDelete( @RequestParam("member_order_id") String id, HttpServletResponse response, Model model) throws IOException {
		
		int result = orderService.orderDelete( id );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('해당 주문건이 삭제되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();
		}
	}

	// Q&A 목록
	@RequestMapping("aQnaMain")
	public String aQnaMain( @RequestParam(value="page", required=false, defaultValue="1") String page, Model model ) {
		model.addAttribute("page", page);
		model.addAttribute("count", qnaService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		List<MemberDto> member_list = memberService.qna_list();
		model.addAttribute("member_list", member_list);
		
		model.addAttribute("qna_list", qnaService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum)));  //최상위 10개
		
//		model.addAttribute("qna_list", qnaService.qna_list());
		return "admin/qna/aQnaMain";
	}
	
	// 검색
	@RequestMapping("qnaBoardSearch")
	public String qnaBoardSearch( @RequestParam("select-box") String select_box, 
								@RequestParam("input") String input,
								@RequestParam("type") String type,
								@RequestParam("state") String state, Model model ) {		
		
		List<MemberDto> member_list = memberService.qna_list();
		model.addAttribute("member_list", member_list);
		
		if( select_box.equals("아이디") ) {
			model.addAttribute("qna_list", qnaService.SearchID( input ));	
		} 
		else if ( select_box.equals("구분") ) {
			model.addAttribute("qna_list", qnaService.SearchType( type ));	
		}
		else if ( select_box.equals("상태") ) {
			model.addAttribute("qna_list", qnaService.SearchState( state ));	
		}
	
		return "admin/qna/aQnaMain";
	}
	
	// Q&A 상세보기 (유저글)
	@RequestMapping("aQnaV1")
	public String aQnaV1( @RequestParam("qna_board_id") String qna_board_id, Model model ) {
		
		QnaDto qnaDto = qnaService.qnaContentView( qna_board_id );
		model.addAttribute("qnaDto", qnaDto);
		return "admin/qna/aQnaV1";
	}
	
	// 삭제 View
	@RequestMapping("aQnaAlert1V")
	public String aQnaAlert1V() {
		return "admin/qna/aQnaAlert1";
	}
	
	// 삭제 Action
	@RequestMapping("aQnaAlert1A")
	public void aQnaAlert1A( @RequestParam("qna_board_id") String qna_board_id, HttpServletResponse response, Model model) throws IOException {
		
		int result = qnaService.qnaDelete( qna_board_id );
		System.out.println(result);
		
		if( result >= 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('해당 게시물이 삭제되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();
		}
	}
	
	// Q&A 상세보기 (유저글 + 답글)
	@RequestMapping("aQnaV2")
	public String aQnaV2( @RequestParam("qna_board_id") String qna_board_id, Model model ) {
		System.out.println(qna_board_id);
		QnaDto qnaDto = qnaService.qnaContentView( qna_board_id );
		System.out.println(qnaDto.getQna_board_group_no());
		QnaDto dto = qnaService.qnaContentView( Integer.toString(qnaDto.getQna_board_group_no()));
		model.addAttribute("dto", dto);
		model.addAttribute("qnaDto", qnaDto);
		return "admin/qna/aQnaV2";
	}
	
	// Q&A 상세보기 (답글 수정)
	@RequestMapping("aQnaV1ViewUpdate")
	public void aQnaV1ViewUpdate( @RequestParam("qna_board_id") String qna_board_id,
								@RequestParam("qna_board_content") String qna_board_content,
								HttpServletResponse response, Model model ) throws IOException {
		
		int result = qnaService.aQnaViewUpdate( qna_board_id, qna_board_content );
		
		if( result == 1 ) {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.println("<script language='javascript'>");
		out.println("alert('내용이 수정되었습니다.')");
		out.println("window.close()");
		out.println("opener.window.location.reload()");
		out.println("</script>");
		
		out.flush();
		
		}
	}
	
	// 답글 삭제 View
	@RequestMapping("aQnaAlert2V")
	public String aQnaAlert2V() {
		return "admin/qna/aQnaAlert2";
	}
	
	// 답글 삭제 Action
	@RequestMapping("aQnaAlert2A")
	public void aQnaAlert2A( @RequestParam("qna_board_id") String qna_board_id, 
								@RequestParam("parents_id") String parents_id, 
								HttpServletResponse response, Model model) throws IOException {
		
		qnaService.update( parents_id );
		int result = qnaService.qnaDelete2( qna_board_id );
		System.out.println(result);
		
		if( result >= 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('해당 게시물이 삭제되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}
	}
	
	// 답글 등록 View
	@RequestMapping("aQnaReply")
	public String aQnaReply( @RequestParam("qna_board_id") String qna_board_id, Model model ) {
		QnaDto qnaDto = qnaService.qnaContentView( qna_board_id );
		model.addAttribute("qnaDto", qnaDto);
		return "admin/qna/aQnaReply";
	}
	
	// 답글 등록 Action
	@RequestMapping("aQnaReplyWrite")
	public void aQnaReplyWrite( @RequestParam("qna_board_id") String qna_board_id, 
									@RequestParam("qna_board_type") String qna_board_type,
									@RequestParam("qna_board_title") String qna_board_title,
									@RequestParam("qna_board_content") String qna_board_content, 
									@RequestParam("qna_board_lock") String qna_board_lock,
									@RequestParam("product_id") String product_id,
									HttpServletResponse response, HttpSession session, Model model ) throws IOException {
		
		String id = (String)session.getAttribute("member_id");
		
		int result = qnaService.qnaReplyWrite( qna_board_id, qna_board_type, qna_board_title, id, qna_board_content, qna_board_lock, product_id );
		
		if( result == 1 ) {
			qnaService.contentViewUpdate( qna_board_id );
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('답변이 완료되었습니다.')");
			out.println("window.close()");
			out.println("opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}

	}
	
	// 공지사항 목록
	@RequestMapping("aNoticeMain")
	public String aNoticeMain( @RequestParam(value="page", required=false, defaultValue="1") String page, Model model ) {
		model.addAttribute("page", page);
		model.addAttribute("count", noticeBoardService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 10; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		model.addAttribute("noticeBoard_list", noticeBoardService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum)));  //최상위 10개
		
//		model.addAttribute("noticeBoard_list", noticeBoardService.noticeBoard_list());	
		return "admin/notice/aNoticeMain";
	}
	
	// 검색
	@RequestMapping("noticeBoardSearch")
	public String noticeBoardSearch( @RequestParam("select-box") String select_box, 
								@RequestParam("input") String input, Model model ) {		
		
		if( select_box.equals("1") ) {
			model.addAttribute("noticeBoard_list", noticeBoardService.SearchID( input ));	
		} 
		else if ( select_box.equals("2") ) {
			model.addAttribute("noticeBoard_list", noticeBoardService.SearchName( input ));	
		}
	
		return "admin/notice/aNoticeMain";
	}
	
	// 공지사항 등록 View
	@RequestMapping("aNoticeW")
	public String aNoticeW() {
		return "admin/notice/aNoticeW";
	}	
	
	// 공지사항 등록 Action
	@RequestMapping("aNoticeA")
	public String aNoticeA( @RequestParam("member_id") String id, 
							@RequestParam("notice_board_title") String notice_board_title, 
							@RequestParam("notice_board_content") String notice_board_content, 
							HttpServletResponse response, Model model ) throws IOException {
		
		int result = noticeBoardService.noticeBoardWrite( id, notice_board_title, notice_board_content );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('공지사항이 등록되었습니다.')");
			out.println("window.close()");
			out.println("opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}
		return "admin/notice/aNoticeW";
	}	
	
	// 공지사항 상세보기
	@RequestMapping("aNoticeV")
	public String aNoticeV( @RequestParam("notice_board_id") String notice_board_id, Model model ) {
		
		NoticeBoardDto noticeBoardDto = noticeBoardService.noticeBoardContentView( notice_board_id );
		model.addAttribute("noticeBoardDto", noticeBoardDto);
		
		return "admin/notice/aNoticeV";
	}
	
	// 공지사항 글 수정
	@RequestMapping("aNoticeViewUpdate")
	public void aNoticeViewUpdate( @RequestParam("notice_board_id") String notice_board_id,
								@RequestParam("notice_board_title") String notice_board_title,
								@RequestParam("notice_board_content") String notice_board_content,
								HttpServletResponse response, Model model ) throws IOException {
		
		int result = noticeBoardService.aNoticeViewUpdate( notice_board_id, notice_board_title, notice_board_content );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('공지사항이 수정되었습니다.')");
			out.println("window.close()");
			out.println("opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}

	}
	
	// 공지사항 글 삭제 View
	@RequestMapping("noticeAlert")
	public String noticeAlert() {
		return "admin/notice/noticeAlert";
	}
	
	// 공지사항 글 삭제 Action
	@RequestMapping("noticeDelete")
	public void noticeDelete( @RequestParam("notice_board_id") String notice_board_id, HttpServletResponse response, Model model ) throws IOException {
		
		System.out.println("글번호 : " + notice_board_id);
		int result = noticeBoardService.noticeDelete( notice_board_id );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('해당 게시물이 삭제되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}
		
	}
		
	// 상품 목록
	@RequestMapping("aProductMain")
	public String productMain( @RequestParam(value="page", required=false, defaultValue="1") String page,  Model model ) {
		System.out.println("page : " + page);
		model.addAttribute("page", page);
		model.addAttribute("count", productService.pageCount());
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 5; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		System.out.println("startRowNum:"+startRowNum);
		System.out.println("endRowNum:"+endRowNum);
		
		model.addAttribute("product_list", productService.listPageDao(String.valueOf(startRowNum), String.valueOf(endRowNum)));
		return "admin/product/aProductMain";
	}
	
	// 검색
	@RequestMapping("productSearch")
	public String productSearch( @RequestParam(value="page", required=false, defaultValue="1") String page, 
								@RequestParam("input") String input, Model model ) {		
		model.addAttribute("page", page);
		model.addAttribute("count", productService.searchCount( input ));
		
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 5; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		System.out.println("입력된 값 : " + input );
		
		model.addAttribute("product_list", productService.SearchName( input, String.valueOf(startRowNum), String.valueOf(endRowNum)));	
		
		return "admin/product/aProductMain";
	}
	
	// 상품 등록 View
	@RequestMapping("aProductWV")
	public String productWV() {
		return "admin/product/aProductW";
	}
	
	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(200000000);
		multipartResolver.setMaxInMemorySize(200000000);
		multipartResolver.setDefaultEncoding("utf-8");
		return multipartResolver;
	}
	
	// 상품 등록 Action
	@RequestMapping(value = "aProductWA", method = RequestMethod.POST)
	public void productWA( @RequestParam("product_category") String product_category,
							@RequestParam("product_name") String product_name,
							@RequestParam("product_stock") String product_stock,
							@RequestParam("product_price") String product_price,
							@RequestParam("file") MultipartFile file,
							@RequestParam("file2") List<MultipartFile> file2,
							@RequestParam("product_content") String product_content,
							HttpServletResponse response, Model model) throws IOException {
		
		System.out.println("이미지 1 : "+file2);
		String path = ResourceUtils.getFile("classpath:static/upload/").toPath().toString();
		String mainImageUrl = fileUploadService.restore(file);
		String contentImageUrl = fileUploadService.restore2(file2);
		System.out.println("이미지 2 : " + contentImageUrl);
		
		int result = productService.productWA( product_category, product_name, product_stock, product_price, 
												mainImageUrl, contentImageUrl, product_content );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('상품등록이 완료되었습니다.')");
			out.println("window.close()");
			out.println("opener.window.location.reload()");
			out.println("</script>");

			out.flush();
		}
	}
	
	// 상품 상세보기 View
	@RequestMapping("aProductV")
	public String productV( @RequestParam("product_id") String product_id, Model model ) {
		
		ProductDto productDto = productService.productContentView( product_id );
		model.addAttribute("productDto", productDto);
		
		return "admin/product/aProductV";
	}
	
	// 상품 상세보기 Action
	@RequestMapping(value = "aProductA", method = RequestMethod.POST)
	public void productA( @RequestParam("product_id") String product_id,
							@RequestParam("product_name") String product_name,
							@RequestParam("product_price") String product_price,
							@RequestParam("file") MultipartFile file,
							@RequestParam("file2") List<MultipartFile> file2,
							@RequestParam("product_stock") String product_stock,
							@RequestParam("product_category") String product_category, 
							@RequestParam("product_content") String product_content,
							@RequestParam("file3") String file3,
							@RequestParam("file4") String file4,
							HttpServletResponse response, Model model ) throws IOException {
		
		String mainImageUrl = fileUploadService.restore(file);
		String contentImageUrl = fileUploadService.restore2(file2);
		System.out.println("mainImageUrl:" + mainImageUrl);
		System.out.println("contentImageUrl:" + contentImageUrl);
		
		if (contentImageUrl.contains(".png")) {
		}else {
			contentImageUrl = file4;
		}
		
		int result = productService.productContentAction( product_id, product_name, product_price, mainImageUrl, contentImageUrl, product_stock, product_category, product_content );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('상품정보가 수정되었습니다.')");
			out.println("window.close()");
			out.println("opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}
		
	}
	
	// 상품 삭제 View
	@RequestMapping("aProductAlert")
	public String productAlert() {
		return "admin/product/aProductAlert";
	}
	
	// 상품 삭제 View
	@RequestMapping("aProductAlertAction")
	public void aProductAlertAction( @RequestParam("product_id") String product_id, HttpServletResponse response, Model model ) throws IOException {
		
		int result = productService.delete( product_id );
		
		if( result == 1 ) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script language='javascript'>");
			out.println("alert('해당 상품이 삭제되었습니다.')");
			out.println("window.close()");
			out.println("window.opener.close()");
			out.println("opener.opener.window.location.reload()");
			out.println("</script>");

			out.flush();

		}
	}
}
