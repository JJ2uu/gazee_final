package com.multi.gazee.member;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multi.gazee.order.OrderVO;

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
    
    @RequestMapping("member/balance")
    public void balance(String id, Model model, HttpSession session) {
        List<OrderVO> list = dao.purchsList(id);
        List<OrderVO> list2 = dao.sellList(id);
        System.out.println("트>> "+list);
        System.out.println("롤>> "+list2);
        model.addAttribute("purchsList", list);
        model.addAttribute("sellList", list2);
    }
    
 // 구매내역 리스트
    @RequestMapping("member/purchsList")
    public void purchsList(String id, Model model) {
        List<OrderVO> list = dao.purchsList(id);
        System.out.println("컨트롤러" + list.size());
        model.addAttribute("purchsList", list);
    }
    // 판매내역 리스트
    @RequestMapping("member/sellList")
    public void sellList(String id, Model model) {
        List<OrderVO> list = dao.sellList(id);
        List<String> sellStatus = new LinkedList<String>();
        List<String> dealType = new LinkedList<String>();
        for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getSetStatus() == 1) {
				sellStatus.add("정산 완료");
			} else if (list.get(i).getCompleteStatus() == 1 && list.get(i).getSetStatus() == 0) {
				sellStatus.add("거래 완료");
			} else if (list.get(i).getCompleteStatus() == 0) {
				sellStatus.add("거래 중");
			}
			if (list.get(i).getDealType().equals("직거래")) {
				dealType.add("직거래");
			} else {
				dealType.add("택배거래");
			}
		}
        System.out.println("컨트롤러sell" + list.size());
        System.out.println(sellStatus);
        System.out.println(dealType);
        model.addAttribute("sellStatus", sellStatus);
        model.addAttribute("sellList", list);
        model.addAttribute("dealType", dealType);
    }
    
    @RequestMapping("member/profile")
    @ResponseBody
    public String profile(String id, Model model) {
    	System.out.println("프로파일 이미지>>"+id);
    	MemberVO bag = dao.selectOne(id);
    	String profileImgAddr = "url('http://zurvmfyklzsa17604146.cdn.ntruss.com/" + bag.getProfileImg() + "?type=f&w=50&h=50')";
    	return profileImgAddr;
    }
}