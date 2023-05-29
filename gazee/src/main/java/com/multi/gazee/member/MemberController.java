package com.multi.gazee.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller 
public class MemberController {
	
	@Autowired
	MemberDAO dao; 
	
	@RequestMapping("member/login")
	@ResponseBody
	public MemberVO login(MemberVO bag, HttpSession session) {
		MemberVO result = dao.login(bag);
		if(result == null){
			bag.setId("no");
			return bag;
		} else {
			session.setAttribute("id", result.getId());
			session.setAttribute("nickname", result.getNickname());
			return result;
		}
	}
	
	@RequestMapping("member/searchOne")
	@ResponseBody
	public MemberVO searchOne(String memberId) {
		MemberVO bag = dao.selectOne(memberId);
		return bag;
	}
	
    @RequestMapping("member/logout")
    public String logout(HttpSession session) {
    	dao.logoutTimeUpdate((String)session.getAttribute("id"));
        session.invalidate();
        return "redirect:member.jsp";
    }
}