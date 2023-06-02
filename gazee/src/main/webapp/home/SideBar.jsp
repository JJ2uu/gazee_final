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
	
	/* 채팅 페이지 */
	$(".btn_myChatlist").click(function() {
		location.href = "../chat/gazeeChat.jsp";
	})
	
	/* 판매하기 버튼 */
	$(".btn_sell").click(function() {
		const sessionId = "<%= session.getAttribute("id") %>";
		//임시저장이 된(temporary가 0인) product가 있으면 임시저장된것을 불러올지 임시저장한 product를 삭제할지 묻고 임시저장을 불러온다하면 productUpdateSel로 아니면 productDelete로처리하고 register.jsp로 이동
		$.ajax({
			url : "../product/checkTemporaryProduct",
			data : {
				memberId : sessionId
			},
			success: function(response) {
				$('#result').html(response);
			},
			error: function(xhr, status, error) {
				// 임시저장된 product가 없을 경우 register.jsp로 이동
				location.href = "../product/register.jsp?memberId=" + sessionId;
			} 
		})
	})
})
</script>
<link rel="stylesheet" href="../resources/css/style.css" type="text/css">
		<%
			if(id!=null){
		%>
		<div id="recentView">
			<div class="recentViewItem" style="background: #693FAA;">
				<div class="btn_sell recentViewTxt" style="color: white;">
					<img src="../resources/img/icon_money.svg" width="18px;">
					판매하기
				</div>
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
			<div id="newMessageBadge"></div>
			<div class="recentViewItem">
				<div class="btn_myChatlist recentViewTxt" id="btn_myChatlist">
					<img src="../resources/img/icon_chat2.svg" width="18px;">
					채팅방
				</div>
			</div>
			<div class="recentViewItem">
				<div class="btn_chatBot recentViewTxt">
					<img src="../resources/img/icon_bot.svg" width="20px;">
					챗봇상담
				</div>
			</div>
		</div>
		<%
			} 
		%>