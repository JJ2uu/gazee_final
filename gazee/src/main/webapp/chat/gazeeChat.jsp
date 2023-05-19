<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<link href="../resources/css/chatRoom.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript">
	
	var urlParams = new URLSearchParams(location.search);
	
	var roomId = urlParams.get('roomId');
	var dealType = urlParams.get('dealType');
	var memberId = '<%= session.getAttribute("id") %>';
	var selectedRoomId = null;
	
	$(function() {
		var stompClient = null;
		
		/* 소켓 연결 함수 */
		function connect(roomId) {
			// 소켓 생성
			let socket = new SockJS('${pageContext.request.contextPath}/chat/' + roomId);
			stompClient = Stomp.over(socket);
									
			stompClient.connect({}, function(frame) {
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
			
			/* 결제창 modal open */
			function payment() {
				$('#payment_modal').fadeIn();
				let modal = document.getElementById('payment_modal');
				modal.style.display = 'flex';
				$.ajax({
					url: 'paymentModal',
					data: {
						roomId: selectedRoomId
					},
					success: function(result) {
						$('.modal_content').empty();
						$('.modal_content').append(result)
						document.body.style.overflow = "hidden";
					}
				})
			}
			
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
					btn_payment.style.cursor = 'pointer';
					btn_payment.addEventListener('click', payment);
					
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
				lastMessageTime(roomId);
				stompClient.disconnect();
			}
		}
		
		/* 마지막 채팅이 이루어진 시간 업데이트 함수 */
		function lastMessageTime(roomId) {
			$.ajax({
				url: 'lastMessageTimeUpdate',
				data: {
					roomId: roomId
				},
				success: function() {
					
				},
				error: function(e) {
					console.log(e)
				}
			})
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
		
		/* 채팅방 나가기 함수 */
		function roomLeave(roomId) {
			$.ajax({
				url: 'roomLeave',
				data: {
					roomId
				},
				success: function() {
					alert('채팅방을 나갔습니다.')
				}
			})
		}
		
		/* 모달창 닫기 버튼 이벤트 */
		$('.btn_modal_close').click(function() {
			$('#payment_modal').fadeOut();
			document.body.style.overflow = "unset";
		})
		
		/* 내 채팅목록 불러오는 함수 */
		$(document).ready(function() {
			$.ajax({
				url: 'myChatList',
				data: {
					memberId : memberId
				},
				success: function(result) {
					$('.myChatList').append(result)
					
					let li = document.querySelectorAll('.chat_list');
					let select = null;

					window.addEventListener("beforeunload", function() {
						disconnect(selectedRoomId);
					});
					
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
										if (!confirm('채팅방을 나가시겠습니까? 모든 채팅방 내용이 삭제됩니다.')) {
											alert("취소")
										} else{
											roomLeave(selectedRoomId);
											location.reload();
										}
									})
									
									/* 토글 메뉴 - 신고하기 */
									let btn_report = $("#btn_report");
									btn_report.on('click', function() {
										console.log('신고하기')
										disconnect(roomId);
									})
									
									/* [판매자]일 때 [판매하기] 버튼을 눌러 결제요청 */
									let btn_sell = $("#btn_sell");
									btn_sell.on('click', function() {
										paymentMessage(roomId);
									})
								}
							})
							
							/* 이미 선택된 li(목록)가 있는 상태에서 다른 li를 클릭 시 */
							if (select != null) {
								select.children[0].style.backgroundColor = '#fff';
								select.children[0].style.transition = '0.5s'; 
								$('#toggle_menu_list').hide();
								disconnect(selectedRoomId);
							}
							/* li(목록) 클릭할 때 */
							this.children[0].style.backgroundColor = '#e7e7e7';
							select = this;
							selectedRoomId = this.getAttribute('value');
						})
						
						/* 이미 roomId가 있을 때 */
						if (roomId === li[i].getAttribute('value')) {
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
	
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
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
		<jsp:include page="../home/Header.jsp" flush="true"/>
	</div>
	<div id="payment_modal">
		<div class="modal_body">
			<div class="btn_modal_close">
				<img src="../resources/img/cancle_icon.svg" width="25px" height="25px">
			</div>
			<div class="modal_content"></div>
		</div>
	</div>
	<div id="content_wrap">
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
	</div>
	<jsp:include page="../home/Footer.jsp" flush="true"/>
</div>
</body>
</html>