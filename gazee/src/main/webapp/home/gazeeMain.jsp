<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가지가지</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<link href="../resources/css/alarm.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/WebSocket.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript">

	$(function() { //body 읽어왔을때
		var sessionId = "<%=session.getAttribute("id")%>";
		
		if (sessionId !== null) {
			subscribeToUser(sessionId);
		}
		
		$.ajax({
			url : "../product/list",
			success : function(res) {
				$('#list').append(res)
			}
		})
		$('#register').click(function() {
			//임시저장이 된(temporary가 0인) product가 있으면 임시저장된것을 불러올지 임시저장한 product를 삭제할지 묻고 임시저장을 불러온다하면 productUpdateSel로 아니면 productDelete로처리하고 register.jsp로 이동
			$.ajax({
				url : "../product/checkTemporaryProduct",
				data : {
					memberId : sessionId,
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

</head>
<body>
	<div id="wrap">
		<div id="newMessagePushAlarm"></div>
		<div id="header">
			<jsp:include page="Header.jsp" flush="true" />
		</div>
		<div id="content_wrap">
			<div id="content">
				<div>
					<button id="register">판매하기</button>
					<div id="result"></div>
				</div>
				<div id="list"></div>
			</div>
		</div>
		<jsp:include page="../home/SideBar.jsp" flush="true"/>
		<jsp:include page="Footer.jsp" flush="true" />
	</div>
</body>
</html>