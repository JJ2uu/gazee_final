<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach items="${list}" var="bag">
	<li class="chat_list" id="chat${bag.roomId}" value="${bag.roomId}">
		<div class="chatList">
			<div class="chatPartnerProfile"></div>
			<div style="width: 160px;">
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<div class="chatRoomName">${bag.chatPartner}</div>
					<div class="recentMessageDate">${bag.lastMessageTime}</div>
				</div>
				<p class="recentMessage">${bag.lastMessage}</p>
			</div>
		</div>
	</li>
</c:forEach>