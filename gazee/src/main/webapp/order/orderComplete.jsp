<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<link href="../resources/css/alarm.css" rel="stylesheet" type="text/css">
<link href="../resources/css/orderComplete.css" rel="stylesheet" type="text/css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="../resources/js/sockjs-0.3.4.js"></script>
<script type="text/javascript" src="../resources/js/stomp.js"></script>
<script type="text/javascript" src="../resources/js/WebSocket.js"></script>
<script type="text/javascript"></script>
<title>가지가지</title>
</head>
<body>
<div id="wrap">
	<div id="newMessagePushAlarm"></div>
	<div id="header">
		<jsp:include page="../home/Header.jsp" flush="true"/>
	</div>
	<div id="content_wrap">
		<div id="content">
			<div style="font-size: 26px; font-weight: bold; text-align: left; color:#363636; margin-bottom: 20px; display: flex; flex-flow: column; align-content: center; gap: 5px;">
				<div id="creditIcon"><img src="../resources/img/icon_credit.svg" style="width: 30px;"></div>
				<div>결제가 완료되었습니다</div>
				<div style="font-size: 14px; font-weight: normal; margin-top: 10px;">
					주문번호 <span style="color: #693FAA; font-weight: bold; text-decoration: underline;">o0000000004ro230524155111</span> 결제가 완료되었습니다.
				</div>
			</div>
			<hr style="margin: 40px 0">
			<div id="order_productInfo">
				<div class="order_productThumbnail"></div>
				<div class="order_productText">
					<div id="order_category">디지털/전자기기</div>
					<div id="order_productName">아이폰13팝니다.</div>
					<div id="order_productPrice">1,000,000 원</div>
				</div>
			</div>
			<div id="order_paymentHistory">
				<span style="font-size: 18px; font-weight: bold; margin-bottom: 15px;">최종 결제금액</span>
				<table id="paymentHistory_table">
					<tbody>
						<tr>
							<th>판매자</th>
							<td>홍길동</td>
							<th>구매자</th>
							<td>김길동</td>
						</tr>
						<tr>
							<th>주문번호</th>
							<td colspan="3">o0000000004ro230524155111</td>
						</tr>
						<tr>
							<th>결제수단</th>
							<td>가지페이</td>
							<th>결제일시</th>
							<td>2023-05-24 11:30</td>
						</tr>
						<tr>
							<th>상품 금액</th>
							<td>1,000,000 원</td>
							<th>결제 금액</th>
							<td>1,000,000 원</td>
						</tr>
						<tr>
							<th>배송지 주소</th>
							<td colspan="3">서울시 서울구 서울동 서울아파트 111동 111호</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="margin: 60px 0 40px 0;">
				<button id="redirect_chat">채팅으로 돌아가기</button>
				<button id="redirect_myPage">구매내역 확인하기</button>
			</div>
		</div>
	</div>
	<jsp:include page="../home/Footer.jsp" flush="true"/>
</div>
</body>
</html>