package com.naturalskin.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.naturalskin.dto.MemberDto;

@Mapper
public interface IMemberDao {

	// 관리자 count
	public int admin_count();
	
	// 일반회원 count
	public int users_count();
	
	// 회원목록
	public ArrayList<MemberDto> member_list();
	
	// 아이디검색
	public ArrayList<MemberDto> SearchID( String input );
	
	// 이름검색
	public ArrayList<MemberDto> SearchName( String input );
	
	// 회원분류 검색
	public ArrayList<MemberDto> SearchRole( String role );

	// 회원정보
	public MemberDto memberInformation(String member_id);

	// 회원정보 수정
	public int memberInformationUpdate(String member_id, String member_pw, String member_name, String member_birthday,
			String member_gender, String member_address, String member_phone, String member_email);
	
	// 회원탈퇴
	public int memberDrop( String member_id );

	public List<MemberDto> listPageDao(String start, String end);

	public int pageCount();

	// 회원가입
	public int newMember(String member_id, String member_pw, String member_name, String member_birthday,
			String member_gender, String member_address, String member_phone, String member_email);

	// 로그인
	public int login(String id, String pw);

	public int roleCheck(String id);

	public List<MemberDto> memberInfo(String id);

	public MemberDto emailIdFind(String name, String email);

	public MemberDto phoneIdFind(String name, String email);

	public MemberDto emailPwFind(String id, String name, String email);

	public MemberDto phonePwFind(String id, String name, String email);

	public int pwUpdate(String id, String name, String email, String pw);
	
	public int pwUpdate2(String id, String name, String phone, String pw);

	public int idCheck(String id);
}
