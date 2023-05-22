		var stompClient = null;
		
		window.addEventListener("beforeunload", function() {
			console.log("소켓삭제");
			disconnectWebSocket();
		});

		function subscribeToChatRooms(roomIds) {
				roomIds.forEach(function(roomId) {
				allSocketConnect(roomId);
			});
			saveSubscribedRoomIdsToSession(roomIds);
		}
		
		function allSocketConnect(roomId) {
			// 소켓 생성
			let socket = new SockJS('/gazee/chat/' + roomId);
			console.log(socket);
			stompClient = Stomp.over(socket);
			
			console.log("소켓 생성 완료");
		
			stompClient.connect({}, function(frame) {
				console.log(frame)
				stompClient.subscribe('/topic/' + roomId, function(messageOutput) {
					showMessageOutput(JSON.parse(messageOutput.body));
					lastChatMessage(JSON.parse(messageOutput.body));
				});
			});
		}
		
		function saveSubscribedRoomIdsToSession(roomIds) {
			// Ajax를 사용하여 서버에 세션에 저장하는 요청을 보냄
			$.ajax({
				url: '../chat/saveSubscribedRoomIds',
				type: 'POST',
				data: JSON.stringify(roomIds), // JSON.stringify를 사용하여 데이터를 JSON 형식으로 변환
				contentType: 'application/json', // 데이터 형식을 JSON으로 지정
				success: function(response) {
					console.log('Subscribed roomIds saved to session');
				},
				error: function(error) {
					console.error('Failed to save subscribed roomIds to session');
					console.log(error)
				}
			});
		}
		
		function disconnectWebSocket() {
		    if (stompClient !== null) {
		        stompClient.disconnect();
		    }
		}
		
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
		
		/* 메세지 출력 함수 */
		function showMessageOutput(messageOutput) {
			let response = document.getElementById('chatLog'+messageOutput.roomId)
			
			if (response == null) {
				newChatMessageBadge(messageOutput);
				newChatMessagePush(messageOutput);
			} else {
				let responseId = response.id;
				let roomId = responseId.substring(7);
			
				if (String(messageOutput.roomId) == roomId) { 
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
			}
		}
		
		/* 자동 스크롤 */
		function scrollToBottom() {
			let chatArea = $('.chatArea');
			if (chatArea.length > 0) {
			    chatArea.scrollTop(chatArea.prop("scrollHeight"));
			}
		}
		
		/* 마지막 채팅을 채팅 목록에서 계속 로드하는 함수 */
		function lastChatMessage(messageOutput) {
			let li = document.querySelectorAll('.chat_list');
			for (var i = 0; i < li.length; i++) {
				const liValue = li[i].getAttribute('value');
				if (messageOutput.roomId == liValue) {
				const liId = li[i].getAttribute('id');
					$("#" + liId + " .recentMessage").empty();
					$("#" + liId + " .recentMessageDate").empty();
					$("#" + liId + " .recentMessage").append(messageOutput.content);
					$("#" + liId + " .recentMessageDate").append(messageOutput.time);
					$(".myChatList").prepend($("#" + liId));
				}
			}
		}
		
		/* 새로운 메세지 뱃지 알람 */
		function newChatMessageBadge(messageOutput) {
			let li = document.querySelectorAll('.chat_list');
			for (var i = 0; i < li.length; i++) {
				const liValue = li[i].getAttribute('value');
				if (messageOutput.roomId == liValue) {
					const liId = li[i].getAttribute('id');
					let liElement = document.getElementById(liId);
					let chatListElement = liElement.querySelector('.chatList');
					let newMessageElement = chatListElement.querySelector('.newMessage');
					newMessageElement.style.visibility = 'visible';
				}
			}
		}
		
		function newChatMessagePush(messageOutput) {
			alert('새로운 메세지 왔어용')
		}