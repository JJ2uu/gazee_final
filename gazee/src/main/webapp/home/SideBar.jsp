<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
%>
<script type="text/javascript">
$(function() {
	/* 최근 본 상품 목록 */
	$('#btn_recentItem').click(function() {
		location.href = "../recentlyViewed/recentlyViewedList.jsp"
	})
})
</script>
<link rel="stylesheet" href="../resources/css/style.css" type="text/css">

		<%
			if(id!=null){
		%>
		<div id="recentView">
			<div class="recentViewItem">
				<div class="recentViewTxt">채팅방</div>
			</div>
			<div class="recentViewItem">
				<div class="recentViewTxt">최근본상품</div>
				<div class="recentViewCount">
					<div class="viewCount">
					</div>
				</div>
				<div class="recentItem">
					<button id="btn_recentItem">목록보기</button>
				</div>
			</div>
			<div class="recentViewItem">
				<div class="recentViewTxt">가지 Chatbot</div>
			</div>
		</div>
		<%
			} 
		%>