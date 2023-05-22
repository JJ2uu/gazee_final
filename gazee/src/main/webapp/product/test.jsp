<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript" src="../resources/js/WebSocket.js"></script>
<script type="text/javascript">
	$(function() {
		
		var session = '<%=session.getAttribute("id")%>'
		var socketSession = '<%= session.getAttribute("subscribedRoomIds")%>'
		
		$("#sender").attr('value', session);
		
		if (socketSession != null) {
			$(document).ready(function() {
				$.ajax({
					url: '../chat/getSubscribedRoomIds',
					type: 'GET',
			        dataType: 'json',
			        success: function(response) {
			            var roomIds = response;
			            roomIds.forEach(function(roomId) {
			            	allSocketConnect(roomId);
			            });
			        },
			        error: function(error) {
			            console.error('Failed to get subscribed roomIds from session');
			            console.log(error);
			        }
				})
			})
		}
		
		/* gnb에 있는 [내 채팅목록] 버튼을 눌렀을 때 */
		/* 상품 상세페이지에서 판매자가 내 판매페이지에서 [채팅목록]을 눌렀을 때 */
		$("#b2").click(function() {
			if (session != null) {
				location.href = "../chat/gazeeChat.jsp";
			}
		})
		
		/* 상품 상세페이지에서 구매자가 [채팅하기] 버튼을 눌렀을 때 */
		$('#b1').click(function() {
			productId = $('#productId').val();
			buyerId = $('#sender').val();
			dealType = $('#dealType').val();
			console.log(productId)
			console.log(buyerId)
			console.log(dealType)
			
			
			$.ajax({
				url: '../chat/chatRoomCheck',
				data: {
					productId : productId,
					buyerId : buyerId,
					dealType : dealType
				},
				success : function(roomId) {
					/* 해당 상품에 대한 채팅방이 이미 있는 경우 */
					if (roomId != 0) {
						location.href = "../chat/gazeeChat.jsp?roomId="+roomId+"&dealType="+dealType;
					} else {
						/* 방이 없는 경우 */
						$.ajax({
							url: '../chat/chatRoomCreate',
							data : {
								ProductId : productId,
								buyerId : buyerId,
								dealType : dealType
							}, success : function(roomId) {
								console.log(roomId)
								if (roomId != 0) {
									location.href = "../chat/gazeeChat.jsp?roomId="+roomId+"&dealType="+dealType;
								} else {
									alert('실패')
								}
							}
						})
					}
				}
			})
		})
	})
	
	
</script>
<title>Insert title here</title>
</head>
<body>
상품아이디:<input id="productId"><br>
구매자아이디:<input id="sender"><br>
거래방식선택:<input id="dealType"><br>
<button id="b1">채팅하기</button>
<button id="b2">내 채팅목록</button>
</body>
</html>