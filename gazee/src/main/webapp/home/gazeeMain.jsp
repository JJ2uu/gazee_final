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

	$(function() {
		var memberId = "<%= (String)session.getAttribute("id") %>";
		
		if (memberId !== "null") {
			handlePageLoad(memberId);
			unreadMessageCheck(memberId);
		}
		
		$.ajax({
			url : "../product/list",
			success : function(res) {
				$('#list').append(res)
			}
		})
		
		$('#btn_trackingNo').click(function() {
			trackingNoFinished(memberId, 1);
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
					<button id="btn_trackingNo">운송장번호 입력</button>
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