package com.naturalskin.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.naturalskin.dao.IMemberDao;
import com.naturalskin.dao.IOrderDao;
import com.naturalskin.dao.IQnaDao;
import com.naturalskin.dto.MemberDto;

@Component
public class MemberService {

	@Autowired
	private IMemberDao memberDao;
	@Autowired
	private IOrderDao orderDao;
	@Autowired
	private IQnaDao qnaDao;

	// 관리자계정 count
	public int admin_count() {
		int result = 0;
		int count = memberDao.admin_count();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}
	
	// 일반회원 count
	public int users_count() {
		int result = 0;
		int count = memberDao.users_count();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}
	
	// 회원목록
	public List<MemberDto> member_list() {
		List<MemberDto> member_list = memberDao.member_list();
		return member_list;
	}
	
	// 아이디 검색
	public List<MemberDto> SearchID( String input ) {
		List<MemberDto> SearchID = memberDao.SearchID( input );
		return SearchID;
	}
	
	// 이름 검색
	public List<MemberDto> SearchName( String input ) {
		List<MemberDto> SearchName = memberDao.SearchName( input );
		return SearchName;
	}
	
	// 회원분류 검색
	public List<MemberDto> SearchRole( String role ) {
		List<MemberDto> SearchRole = memberDao.SearchRole( role );
		return SearchRole;
	}
	
	// 회원정보
	public MemberDto memberInformation( String member_id ) {
		MemberDto memberDto = memberDao.memberInformation( member_id );
		return memberDto;
	}
	
	// 회원정보 수정
	public int memberInformationUpdate(String member_id, String member_pw, String member_name, String member_birthday,
			String member_gender, String member_address, String member_phone, String member_email) {
				
		int reuslt = memberDao.memberInformationUpdate( member_id, member_pw, member_name, member_birthday, member_gender, member_address, member_phone, member_email );
		
		return reuslt;
		
	}
	
	// 회원탈퇴
	public int memberDrop( String member_id ) {
		
		int reuslt = memberDao.memberDrop( member_id );
		System.out.println("reuslt : " + reuslt);
		
		return reuslt;
		
	}

	public List<MemberDto> order_list() {
		List<MemberDto> order_list = orderDao.order_name();
		return order_list;
	}

	public List<MemberDto> listPageDao(String start, String end) {
		List<MemberDto> listPageDao = memberDao.listPageDao( start, end );
		return listPageDao;
	}

	public int pageCount() {
		int result = 0;
		int count = memberDao.pageCount();
		
		if( count >= 0 ) {
			result = count;
		}
		
		return result;
	}

	public List<MemberDto> qna_list() {
		List<MemberDto> qna_list = qnaDao.role();
		return qna_list;
	}
	
	// admin end //
	// -------------------------------------------------------------------------- //
	// user start //
	
	// 회원가입
	public int newMember(String member_id, String member_pw, String member_name, String member_birthday,
			String member_gender, String member_address, String member_phone, String member_email) {		
		int result = memberDao.newMember( member_id, member_pw, member_name, member_birthday, member_gender, member_address, member_phone, member_email );			
		return result;

	}

	// 로그인
	public int login(String id, String pw) {
		int result = 0;
		int count = memberDao.login( id, pw );
		
		if( count > 0 ) {
			result = count;
		}
		return result;
	}

	public List<MemberDto> memberInfo(String id) {
		List<MemberDto> memberInfo = memberDao.memberInfo(id);
		return memberInfo;
	}

	public MemberDto emailIdFind(String name, String email) {
		MemberDto emailIdFind = memberDao.emailIdFind(name, email);
		return emailIdFind;
	}
	
	public MemberDto phoneIdFind(String name, String email) {
		MemberDto phoneIdFind = memberDao.phoneIdFind(name, email);
		return phoneIdFind;
	}

	public MemberDto emailPwFind(String id, String name, String email) {
		MemberDto emailPwFind = memberDao.emailPwFind(id,name, email);
		return emailPwFind;
	}
	
	public MemberDto phonePwFind(String id, String name, String email) {
		MemberDto phonePwFind = memberDao.phonePwFind(id,name, email);
		return phonePwFind;
	}

	public int pwUpdate(String id, String name, String email, String pw) {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
		    int rIndex = rnd.nextInt(2);
		    switch (rIndex) {
		    case 0:
		        // a-z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // 0-9
		        temp.append((rnd.nextInt(10)));
		        break;
		    }
		}
		pw = temp.toString();
		System.out.println(pw);
		int result = memberDao.pwUpdate(id, name, email, pw);
		System.out.println(result);
		return result;

	}
	
	public int pwUpdate2(String id, String name, String phone, String pw) {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
		    int rIndex = rnd.nextInt(2);
		    switch (rIndex) {
		    case 0:
		        // a-z
		        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // 0-9
		        temp.append((rnd.nextInt(10)));
		        break;
		    }
		}
		pw = temp.toString();
		System.out.println(pw);
		int result = memberDao.pwUpdate2(id, name, phone, pw);
		System.out.println(result);
		return result;

	}

	public int idCheckAjax(String member_id) {
		int result = 0;
		try 
		{
			result = memberDao.idCheck(member_id);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return result;
	}

}
