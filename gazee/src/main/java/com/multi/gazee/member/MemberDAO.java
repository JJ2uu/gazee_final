package com.multi.gazee.member;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.multi.gazee.order.OrderVO;
import com.multi.gazee.productLikes.ProductLikesVO;

@Component
public class MemberDAO { // CRUD
	
	@Autowired
	SqlSessionTemplate gazee;
	
	public MemberVO login(MemberVO bag) {
		MemberVO result = gazee.selectOne("member.login", bag);
		return result;
	}
	
	public MemberVO selectOne(String id) {
		MemberVO bag = gazee.selectOne("member.searchOne", id);
		return bag;
	}
	
	public void logoutTimeUpdate(String id) {
		gazee.update("member.logoutTimeUpdate", id);
	}
	
	// 05-15 23:40 추가
		public List<OrderVO> purchsList(String id) {
			List<OrderVO> list = gazee.selectList("member.purchsList", id);
			System.out.println("DAO" + list.size());
			return list;
		}

		public List<OrderVO> sellList(String id) {
			List<OrderVO> list = gazee.selectList("member.sellList", id);
			System.out.println("DAO" + list.size());
			return list;
		}

		public List<ProductLikesVO> basketList(String id) {
			List<ProductLikesVO> list = gazee.selectList("member.basketList", id);
			System.out.println("DAO" + list.size());
			return list;
		}

}
