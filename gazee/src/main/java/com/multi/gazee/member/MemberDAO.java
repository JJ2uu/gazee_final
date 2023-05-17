package com.multi.gazee.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Locale;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import com.sun.org.apache.xpath.internal.operations.Mult;
import java.util.*;
//import 화면DB연결.MemberVO;
//스프링에 dao는 싱글톤으로 하나만 만들어서 사용할게!라고 설정해야함.
//2가지방법을 할 수 있음.
//어노테이션(표시)방법, XML방법
@Component
public class MemberDAO { // CRUD
//특정한 방법으로 실행하는 클래스(model, 방법) 
	
	@Autowired
	SqlSessionTemplate gazee;
	
	public MemberVO login(MemberVO bag) {
		MemberVO result = gazee.selectOne("member.login", bag);
		return result;
		}
	
	public String nickname(String id) {
		String nickname = gazee.selectOne("member.nickname", id);
		return nickname;
	}
}
