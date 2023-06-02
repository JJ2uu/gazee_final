package com.multi.gazee.service;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.multi.gazee.member.MemberDAO;
import com.multi.gazee.member.MemberVO;
import com.multi.gazee.order.OrderDAO;
import com.multi.gazee.order.OrderVO;
import com.multi.gazee.product.ProductDAO;
import com.multi.gazee.product.ProductVO;
import com.multi.gazee.productImage.ProductImageDAO;
import com.multi.gazee.productImage.ProductImageVO;
import com.multi.gazee.productLikes.ProductLikesDAO;
import com.multi.gazee.productLikes.ProductLikesVO;
import com.multi.gazee.reportCount.ReportCountDAO;
import com.multi.gazee.reportCount.ReportCountVO;
import com.multi.gazee.scheduler.ProductScheduler;

@Service
public class ProductServiceImpl implements ProductService{
	@Autowired
	ProductDAO dao;
	
	@Autowired
	ProductImageDAO dao2;
	
	@Autowired
	ReportCountDAO dao3;
	
	@Autowired
	OrderDAO orderDao;
	
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	ProductLikesDAO like;
	
	@Autowired
	ProductScheduler productScheduler;
	
	@Autowired
	private TaskScheduler taskScheduler;
	

	public void productDetail(Model model, int productId) {
		ProductVO bag = dao.productDetail(productId);
		model.addAttribute("bag", bag); // 상품상세 불러오기
		List<ProductImageVO> bag2 = dao2.productImage(productId);
		model.addAttribute("bag2", bag2); // 상품이미지 불러오기
		String memberId = bag.getMemberId();
		ReportCountVO bag3 = dao3.reportCount(memberId);
		model.addAttribute("bag3", bag3); // 판매자 정보 불러오기
		OrderVO orderVO = orderDao.orderCheck(productId);//주문상태 확인
		if (orderVO != null && orderVO.getCanceled() == 0) { //결제 후
			if (orderVO.getCompleteStatus() == 1) {
				model.addAttribute("order", "done"); //거래 완료
			} else {
				model.addAttribute("order", "yet"); //거래 전
			}
		} else { //결제 전
			model.addAttribute("order", "null");
		}
		MemberVO memberVO = memberDao.selectOne(memberId);
		model.addAttribute("nickname", memberVO.getNickname());
		model.addAttribute("userProfileImg", memberVO.getProfileImg());
	}
	
	public ProductVO productOne(int productId) {
		ProductVO bag = dao.productone(productId);
		return bag;
	}
	
	public void productList(Model model) {
		List<ProductVO> list = dao.list();
		model.addAttribute("list", list);
	}
	
	public void productImgSlide(Model model, int productId) {
		List<ProductImageVO> bag2 = dao2.productImage(productId);
		model.addAttribute("bag2", bag2); // 상품이미지 불러오기
	}
	
	public void productUpdateSelect(Model model, int productId) {
		ProductVO bag;
		bag = dao.productDetail(productId);
		model.addAttribute("bag", bag); // 상품상세 불러오기
		productImgSlide(model, productId);
	}
	
	public void productRegister(HttpSession session, ProductVO product, HttpServletResponse response) {
		int result = dao.register(product);
		int productId = product.getProductId();
		session.setAttribute("productId", productId);
		
		if (result == 1) {
			response.setStatus(HttpServletResponse.SC_OK);
			
		} else {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
	
	public void productUpdate(ProductVO bag) {
		dao.productUpdate(bag);
	}

	public void checkTemporaryProduct(Model model, ProductVO bag) {
		ProductVO bag2 = dao.checkTemporaryProduct(bag);

	    if (bag2 != null) { // 임시저장 존재
	        model.addAttribute("result", 1);
	        model.addAttribute("bag", bag2);
	        model.addAttribute("productId", bag2.getProductId());
	    } else { // 임시저장 없음 바로 글쓰기
	        model.addAttribute("result", 0);
	        bag2 = new ProductVO(); // new ProductVO
	        bag2.setProductId(0);
	        model.addAttribute("bag", bag2);
	    }
	}
	
	public void productLikes(ProductLikesVO bag) {
		like.productLikes(bag);
	}
	
	public void unLikes(ProductLikesVO bag, Model model) {
		int result = like.unLikes(bag);
		if (result == 1) {
			model.addAttribute("result", 1);
		} else {
			model.addAttribute("result", 0);

		}
	}
	
	public void checkLikes(Model model, ProductLikesVO bag) {
		ProductLikesVO bag2 = like.checkLikes(bag);
	    if (bag2 != null) {
	    	model.addAttribute("isLiked", 1);
		} else {
			model.addAttribute("isLiked", 0);
			
		}
	}
	
	public int sellTimeUpdate(int productId) {
		int result = dao.sellTimeUpdate(productId);
		if (result != 0 ) {
			productScheduler.setProductId(productId);
			// 스케줄러를 다시 시작
		    taskScheduler.schedule(() -> productScheduler.scheduleSellTimeUpdate(productId), new Date(System.currentTimeMillis() + 10 * 60 * 1000));
		}
		return result;
	}
	
	public int sellTimeDelete(int productId) {
		int result = dao.sellTimeDelete(productId);
		return result;
	}
	
	public ProductVO sellTimeCheck(int productId) {
		ProductVO productVO = dao.productDetail(productId);
		return productVO;
	}
	
}
