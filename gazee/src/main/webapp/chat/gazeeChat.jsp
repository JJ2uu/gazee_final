<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/nav.css" rel="stylesheet" type="text/css">
<link href="../resources/css/chatRoom.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript">
	
	var urlParams = new URLSearchParams(location.search);
	
	var roomId = urlParams.get('roomId');
	var transaction = urlParams.get('transaction');
	var memberId = '<%= session.getAttribute("id") %>';
	
	console.log(memberId);
	console.log(roomId);
	console.log(transaction);
	
	$(function() {
		
		var stompClient = null;
		
		/* 소켓 연결 함수 */
		function connect(roomId) {
			// 소켓 생성
			let socket = new SockJS('${pageContext.request.contextPath}/chat/' + roomId);
			stompClient = Stomp.over(socket);
									
			stompClient.connect({}, function(frame) {
				console.log('Connected: ' + frame);
				console.log('연결됨')
				stompClient.subscribe('/topic/'+roomId , function(messageOutput) {
					showMessageOutput(JSON.parse(messageOutput.body));
					lastChatMessage(roomId, JSON.parse(messageOutput.body));
				})
				getChatHistory(roomId);
				scrollToBottom();
			})
		}
		
		/* 채팅 내역 불러오는 함수 */
		function getChatHistory(roomId) {
			$.ajax({
				url: 'chatMessageList',
				data: {
					roomId: roomId
				},
				success: function(result) {
					for (var i = 0; i < result.length; i++) {
						showMessageOutput(result[i])
					}
				}, 
				error: function(e) {
					console.log("---" + e)
				}
			})
		}
		
		/* 결제요청 메세지 */
		function paymentMessage(roomId) {
			let sender = memberId;
			let content = "결제요청";
			
			stompClient.send('/app/chat/'+roomId, {}, JSON.stringify({
				'sender' : sender,
				'content' : content
			}));
		}
		
		/* 메세지 보내는 함수 */
		function sendMessage(roomId) {
			let sender = memberId;
			let content = document.getElementById('chatMessageText').value;
			
			stompClient.send('/app/chat/'+roomId, {}, JSON.stringify({
				'sender' : sender,
				'content' : content
			}));
		}
		
		/* 메세지 출력 함수 */
		function showMessageOutput(messageOutput) {
			let response = document.getElementById('chatLog')
			
			if (messageOutput.sender == memberId) {
				if (messageOutput.content == '결제요청') {
					let temp = document.createElement('div');
					temp.classList.add('message');
					temp.classList.add('chat_me');
					
					let innerDiv = document.createElement('div');
					innerDiv.id = 'paymentMessage_wrap';
					
					let span = document.createElement('span');
					span.textContent = '판매자가 결제를 요청합니다.';
					
					let btn_payment = document.createElement('button');
					btn_payment.id = 'btn_payment';
					btn_payment.textContent = '결제하기';
					
					innerDiv.appendChild(span);
					innerDiv.appendChild(btn_payment);
					temp.appendChild(innerDiv);
					
					let timeDiv = document.createElement('div');
					timeDiv.classList.add('messageTime');
					timeDiv.textContent = messageOutput.time;
					
					temp.appendChild(timeDiv)
					response.appendChild(temp);
					scrollToBottom();
				} else {
					let temp = document.createElement('div');
					temp.classList.add('message');
					temp.classList.add('chat_me');
					
					let innerDiv = document.createElement('div');
					let span = document.createElement('span');
					span.textContent = messageOutput.content;
					
					innerDiv.appendChild(span);
					temp.appendChild(innerDiv);
					
					let timeDiv = document.createElement('div');
					timeDiv.classList.add('messageTime');
					timeDiv.textContent = messageOutput.time;
					
					temp.appendChild(timeDiv)
					response.appendChild(temp);
					scrollToBottom();
				}
			} else {
				if (messageOutput.content == '결제요청') {
					let temp = document.createElement('div');
					temp.classList.add('message');
					temp.classList.add('chat_partner');
					
					let profileDiv = document.createElement('div');
				    profileDiv.classList.add('chatPartnerProfile');
				    temp.appendChild(profileDiv);
					
					let innerDiv = document.createElement('div');
					innerDiv.id = 'paymentMessage_wrap';
					
					let span = document.createElement('span');
					span.textContent = '판매자가 결제를 요청합니다.';
					
					let btn_payment = document.createElement('button');
					btn_payment.id = 'btn_payment';
					btn_payment.textContent = '결제하기';
					
					innerDiv.appendChild(span);
					innerDiv.appendChild(btn_payment);
					temp.appendChild(innerDiv);
					
					let timeDiv = document.createElement('div');
					timeDiv.classList.add('messageTime');
					timeDiv.textContent = messageOutput.time;
					
					temp.appendChild(timeDiv)
					response.appendChild(temp);
					scrollToBottom();
				} else {
					let temp = document.createElement('div');
					temp.classList.add('message');
					temp.classList.add('chat_partner');
					
					let profileDiv = document.createElement('div');
				    profileDiv.classList.add('chatPartnerProfile');
				    temp.appendChild(profileDiv);
					
					let innerDiv = document.createElement('div');
					let span = document.createElement('span');
					span.textContent = messageOutput.content;
					
					innerDiv.appendChild(span);
					temp.appendChild(innerDiv);
					
					let timeDiv = document.createElement('div');
					timeDiv.classList.add('messageTime');
					timeDiv.textContent = messageOutput.time;
					
					temp.appendChild(timeDiv)
					response.appendChild(temp);
					scrollToBottom();
				}
			}
		}
		
		/* 마지막 채팅을 채팅 목록에서 계속 로드하는 함수 */
		function lastChatMessage(roomId, messageOutput) {
			let li = document.querySelectorAll('.chat_list');
			for (var i = 0; i < li.length; i++) {
				const liValue = li[i].getAttribute('value');
				if (roomId == liValue) {
				const liId = li[i].getAttribute('id');
				console.log(liId);
					$("#" + liId + " .recentMessage").empty();
					$("#" + liId + " .recentMessageDate").empty();
					$("#" + liId + " .recentMessage").append(messageOutput.content);
					$("#" + liId + " .recentMessageDate").append(messageOutput.time);
					$(".myChatList").prepend($("#" + liId));
				}
			}
		}
		
		/* 소켓 연결 끊고 마지막 메세지 시간 등록 */
		function disconnect(roomId) {
			if (stompClient != null) {
				stompClient.disconnect();
			}
			console.log("Disconnected");
		}
		
		/* 자동 스크롤 */
		function scrollToBottom() {
			let chatArea = $('.chatArea');
			if (chatArea.length > 0) {
			    chatArea.scrollTop(chatArea.prop("scrollHeight"));
			}
		}
		
		function connectSse(roomId) {
			const source = new EventSource('/chat/sse/' + roomId);
			source.onmessage = function(event) {
				const data = JSON.parse(event.data);
				console.log('Received SSE message: ', data);
			}
		}
		
		/* 내 채팅목록 불러오는 함수 */
		$(document).ready(function() {
			$.ajax({
				url: 'myChatList',
				data: {
					memberId : memberId
				},
				success: function(result) {
					$('.myChatList').append(result)
					
					let btn_roomDelete = $('.roomDelete');
					btn_roomDelete.click(function() {
						alert('채팅방 삭제!!')
					})
					
					let li = document.querySelectorAll('.chat_list');
					let select = null;
					for (let i = 0; i < li.length; i++) {
						li[i].addEventListener('click', function() {
						const roomId = li[i].getAttribute('value');
							$.ajax ({
								url: 'chatRoomEntry',
								data: {
									roomId: roomId
								},
								success: function(result) {
									connect(roomId);
									$('.chatRoomEntry').empty();
									$('.chatRoomEntry').append(result)

									/* 채팅전송 엔터키 이벤트 */
									$("#chatMessageText").keyup(function(event) {
										if (event.which == 13) {
									        event.preventDefault();
									        sendMessage(roomId);
									        $(this).val('');
									    }
									})
									
									/* 채팅전송 클릭이벤트 */
									let btn_chatSend = $('.chat_send');
									btn_chatSend.click(function() {
										sendMessage(roomId);
									});
									
									/* 햄버거 토글 메뉴 */
									let burger = $('.menu-trigger');
									burger.each(function(index){
									  let $this = $(this);
									  
									  $this.on('click', function(e){
									    e.preventDefault();
									    $(this).toggleClass('active-' + (index+1));
									    $('#toggle_menu_list').slideToggle();
									  })
									});
									
									/* 토글 메뉴 - 채팅방 나가기 */
									let btn_roomLeave = $("#btn_roomLeave");
									btn_roomLeave.on('click', function() {
										console.log('채팅방 나가기')
										disconnect();
										location.reload();
									})
									
									/* 토글 메뉴 - 신고하기 */
									let btn_report = $("#btn_report");
									btn_report.on('click', function() {
										console.log('신고하기')
										disconnect();
									})
									
									/* [판매자]일 때 [판매하기] 버튼을 눌러 결제요청 */
									let btn_sell = $("#btn_sell");
									btn_sell.on('click', function() {
										console.log('결제요청')
										paymentMessage(roomId);
									})
								}
							})
							
							/* 이미 선택된 li(목록)가 있는 상태에서 다른 li를 클릭 시 */
							if (select != null) {
								select.children[0].style.backgroundColor = '#fff';
								select.children[0].style.transition = '0.5s'; 
								$('#toggle_menu_list').hide();
								disconnect();
							}
							/* li(목록) 클릭할 때 */
							this.children[0].style.backgroundColor = '#e7e7e7';
							select = this;
						})
						
						/* 이미 roomId가 있을 때 */
						if (roomId === li[i].getAttribute('value')) {
							console.log(roomId)
							li[i].click();
							let myChatList = document.querySelector('.myChatList');
							/* 해당 채팅방을 맨 위로 */
							myChatList.insertBefore(li[i], myChatList.firstChild);
						}
					}
				}
			})
		})
	})
</script>
<style>
	body {
		background-color: #fafafa;
	}
</style>
<title>가지가지</title>
</head>
<body>
<div id="wrap">
		<div id="header">
			<div class="headerContent">
				<a href="gazeeMain.jsp">
					<img src="../resources/img/gazee_logo.png" id="logo">
				</a>
				<div id="search">
					<input type="text" id="searchBar" placeholder="검색어를 입력하세요.">
					<input type="submit" id="searchButton" value="검색">
				</div>
				<ul class="menu">
					<li id="login">로그인</li>
					<li class="line">|</li>
					<li>회원가입</li>
					<li class="line">|</li>
					<li>고객센터</li>
					<li class="line">|</li>
					<li>
						<div class="mobile_btn">
							<input type="checkbox" id="hamburger" /> <label for="hamburger">
								<span></span> <span></span> <span></span>
							</label>
							<div class="sidebar">
								<h2
									style="text-align: center; position: relative; top: 60px; color: #693FAA;">카테고리</h2>
								<hr
									style="position: relative; top: 60px; border: solid 1px black;">
								<ul class="nav_mobile">
									<li><a href="#">의류</a><a href="#">잡화</a><a href="#">도서</a></li>
									<li><a href="#">디지털기기</a><a href="#">생활가전</a><a href="#">가구/인테리어</a></li>
									<li><a href="#">뷰티/미용</a><a href="#">스포츠/레저</a><a href="#">생활/주방</a></li>
									<li><a href="#">취미/게임/음반</a><a href="#">반려동물용품</a><a
										href="#">기타</a></li>
								</ul>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div id="content">
			<div style="font-size: 26px; font-weight: bold; text-align: left; color:#363636; margin-bottom: 20px; display: flex; align-content: center; gap: 15px;">
				<div id="chatIcon"><img src="../resources/img/icon_chat.svg" style="width: 30px;"></div>
				<div>내 채팅목록</div>
			</div>
			<div class="chat">
				<ul id="toggle_menu_list" class="list-group">
					<li class="list-group-item" id="btn_report" style="border-radius: 10px 10px 0 0;">신고하기</li>
					<li class="list-group-item" id="btn_roomLeave" style="border-radius: 0 0 10px 10px;">채팅방 나가기</li>
				</ul>
				<div class="chatList_wrap">
					<ul class="myChatList"></ul>
				</div>
				<div class="chatRoomEntry">
					대화내역이 없습니다. 대화를 시작하세요!
				</div>
			</div>
		</div>
	<div id="footer">
		<div>
			<p style="margin: 0; font-size: 12px;">Copyrightⓒ 2023. gazee. All rights reserved.</p>
		</div>
	</div>
	</div>
</body>
</html>