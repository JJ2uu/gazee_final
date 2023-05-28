package com.multi.gazee.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MemberDAO { // CRUD
	
	@Autowired
	SqlSessionTemplate gazee;
	
	public MemberVO login(MemberVO bag) {
		MemberVO result = gazee.selectOne("member.login", bag);
		return result;
	}
	
	public MemberVO searchOne(String id) {
		MemberVO bag = gazee.selectOne("member.searchOne", id);
		return bag;
	}
	
	public void logoutTimeUpdate(String id) {
		gazee.update("member.logoutTimeUpdate", id);
	}
}
