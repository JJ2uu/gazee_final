<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="../resources/css/alarm.css" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript" src="../resources/js/WebSocket.js"></script>
<script type="text/javascript">
	$(function() {
		$('#b1').click(function() {
			let id2 = $('#id').val();
			let pw2 = $('#pw').val();
			
			if(id2 != '') {
				if(pw2 != ''){
					$.ajax({
						url:"login",
						type:'post',
						data:{
							id: id2,
							pw: pw2
						},
						success: function(data) {
							if (data.id == 'no') {
								alert("로그인 오류발생");
							} else {
								//alert("로그인 성공");
								$.ajax({
									url: '../chat/myChatRoomIds',
									data: {
										memberId: id2
									},
									success: function(roomIds) {
										subscribeToChatRooms(roomIds);
										location.href ="../home/gazeeMain.jsp"
									},
									error: function(e) {
										console.log(e)
									}
								})
							}
						},//success
						error: function(){
							alert("서버연결 실패")
						}
					})//ajax
				}else {
					alert("비밀번호를 입력해주세요");
				}
			}else{
				alert("아이디를 입력해주세요");
			}
		})
	})
	</script>
<style>
<!--
body {
	text-align: center;
}

div {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding: 30px;
	background-color: #6f42c1;
	border-radius: 30px;
	text-align: center;
}

.form-control {
	margin: 10px;
}
-->
</style>
</head>
<body>
	<div id="newMessagePushAlarm"></div>
	<h3 class="container" style="color: #6f42c1">로그인 화면입니다.</h3>
	<hr color="#6f42c1">
	<img src="../resources/img/gazee_logo.png" style="width: 300px" height="100">
		<div class="container">
			<label for="usr" style="color: #ffc107" style="width:18px;text-align:right;">아이디:</label> 
			    <input id="id" type="text" value="root" class="form-control" name="id" style="width: 350px"style="text-align:center;"> 
				<label for="pw" style="color: #ffc107">비밀번호:</label> 
				<input id="pw"   value="1234" type="password" class="form-control" name="pw" style="width: 350px"style="width:-600px">
				 <label> </label>
			<label></label><br>
			<button id="b1"  class="btn btn-primary btn-lg"
				style="background: #ffc107">서버로 전송</button>
			<br>
		</div>
		<label></label><br>
		<button type="button" class="btn btn-primary btn-sm"
			style="background: #6f42c1" onClick="location.href='findpw.jsp'">비밀번호 찾기</button>
		<button type="button" class="btn btn-primary btn-sm"
			style="background: #6f42c1" onClick="location.href='findid.jsp'">아이디 찾기</button>
		<button type="button" class="btn btn-primary btn-sm"
			style="background: #6f42c1" onClick="location.href='signup.jsp'">회원가입</button>
</body>
</html>