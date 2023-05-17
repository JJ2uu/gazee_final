<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<%
			String sessionId = (String)session.getAttribute("id");
			String sellerId = (String)request.getAttribute("sellerId");
			if(sessionId.equals(sellerId)) {
		%>
			<!-- 판매자일 때 -->
			<div class="chatRoomHeader">
				<span style="display: none;" id="chatRoomNumber">${bag.roomId}</span>
				<div style="display: flex; gap: 20px; align-items: center;">
					<div style="display: flex; flex-flow: column;">
						<span id="status">판매중</span>
						<div class="productThumbnail"></div>
					</div>
					<div class="chatRoomTitle_wrap">
						<div style="display: flex; align-items: center;">
							<span id="productTitle">${bag.productName}</span>
						</div>
						<span id="chatPartner">${buyerNickname}</span>
					</div>
				</div>
				<div style="display: flex; align-items: center; gap: 14px;">
					<div id="transaction">
						<span id="transactionText">${bag.transaction}</span>
					</div>
					<div id="btn_sell">
						<button>판매하기</button>
					</div>
					<div id="productPrice_wrap">
						<div style="font-size: 26px; font-weight: bold; color: #000; margin: 0 5px;">
							${bag.priceDec}원
						</div>
					</div>
					<div id="btn_report_wrap" class="menu-trigger">
						<img src="../resources/img/menu.svg" style="height: 20px;">
					</div>
				</div>
			</div>
			<%
				String transaction = (String)request.getAttribute("transaction");
				if(transaction.equals("직거래")) {
			%>
				<button id="btn_transactionDate">입력</button>
				<div id="transactionDate">
					<input type="datetime-local" name="starttime" style="border: none; outline: none;">
				</div>
			<%
				}
			%>
			<div class="chatArea">
				<div class="chatLog" id="chatLog">
				</div>
			</div>
			<div class="chatWrite_wrap">
				<div id="inp_chatArea">
					<textarea maxlength="2000" placeholder="메시지를 입력하세요" id="chatMessageText"></textarea>
				</div>
				<div id="btn_chatSubmit">
					<button class="chat_send">전송</button>
				</div>
			</div>
		<%
			} else {
		%>
			<!-- 구매자일 때 -->
			<div class="chatRoomHeader">
				<span style="display: none;" id="chatRoomNumber">${bag.roomId}</span>
				<div style="display: flex; gap: 20px; align-items: center;">
					<div style="display: flex; flex-flow: column;">
						<span id="status">판매중</span>
						<div class="productThumbnail"></div>
					</div>
					<div class="chatRoomTitle_wrap">
						<span id="productTitle">${bag.productName}</span>
						<span id="chatPartner">${sellerNickname}</span>
					</div>
				</div>
				<div style="display: flex; align-items: center; gap: 14px;">
					<div id="transaction">
						<span id="transactionText">${bag.transaction}</span>
					</div>
					<div id="productPrice_wrap">
						<div style="font-size: 26px; font-weight: bold; color: #000; margin: 0 5px;">
							${bag.priceDec}원
						</div>
					</div>
					<div id="btn_report_wrap" class="menu-trigger">
						<img src="../resources/img/menu.svg" style="height: 20px;">
					</div>
				</div>
			</div>
			<div class="chatArea" id="chatArea">
				<div class="chatLog" id="chatLog">

				</div>
			</div>
			<div class="chatWrite_wrap">
				<div id="inp_chatArea">
					<textarea maxlength="2000" placeholder="메시지를 입력하세요" id="chatMessageText"></textarea>
				</div>
				<div id="btn_chatSubmit">
					<button class="chat_send">전송</button>
				</div>
			</div>
		<%
			};
		%>