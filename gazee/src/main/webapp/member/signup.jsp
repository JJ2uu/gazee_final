<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	$('#mail-Check-Btn').click(function() {
		const eamil = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
		console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
		const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 

		$.ajax({
			type : 'get',
			url : '<c:url value ="/user/mailCheck?email="/>' + eamil, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
			success : function(data) {
				console.log("data : " + data);
				checkInput.attr('disabled', false);
				code = data;
				alert('인증번호가 전송되었습니다.')
			}
		}); // end ajax
	}); // end send eamil

	// 인증번호 비교 
	// blur -> focus가 벗어나는 경우 발생
	$('.mail-check-input').blur(
			function() {
				const inputCode = $(this).val();
				const $resultMsg = $('#mail-check-warn');

				if (inputCode === code) {
					$resultMsg.html('인증번호가 일치합니다.');
					$resultMsg.css('color', 'green');
					$('#mail-Check-Btn').attr('disabled', true);
					$('#userEamil1').attr('readonly', true);
					$('#userEamil2').attr('readonly', true);
					$('#userEmail2').attr('onFocus',
							'this.initialSelect = this.selectedIndex');
					$('#userEmail2').attr('onChange',
							'this.selectedIndex = this.initialSelect');
				} else {
					$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!');
					$resultMsg.css('color', 'red');
				}
			});
</script>
<style type="text/css">
#signUpBox {
	width: 600px;
	margin: 0 auto 50px auto;
	display: flex;
	flex-flow: column;
	gap: 16px;
}

.form-control {
	width: 100%;
    height: 46px;
    padding: 0px 11px 1px 15px;
    border-radius: 4px;
    border: 1px solid rgb(221, 221, 221);
    font-weight: 400;
    font-size: 16px;
    line-height: 1.5;
    color: rgb(51, 51, 51);
    outline: none;
    box-sizing: border-box;
}

.head{
	padding-bottom: 10px;
    border-bottom: 2px solid rgb(51, 51, 51);
    font-size: 12px;
    color: rgb(102, 102, 102);
    line-height: 17px;
    text-align: right;
}

.input_signUp, .mail-check-box {
	display: flex;
	align-items: center;
}

.nametag {
	width: 150px;
	text-align: left;
}

.email-form {
	display: flex;
	flex-flow: column;
}

#mail-Check-Btn {
	width: 200px;
	height: 46px;
	background: #693FAA;
	color: #fff;
	border-style: none;
	border-radius: 4px;
	cursor: pointer;
}

.gender_radio {
	width: 100px;
	display: flex;
	align-items: center;
}

.genderTag {
	width: 50px;
}

#btn_login {
	width: 350px;
	height: 46px;
	background: #693FAA;
	color: #fff;
	border-style: none;
	border-radius: 4px;
	margin: 20px auto;
	cursor: pointer;
}

.star {
	color: red;
}

#mail-check-warn {
	margin-top: 5px;
}
#Id-Check-Btn {
	width: 120px;
	height: 46px;
	background: #693FAA;
	color: #fff;
	border-style: none;
	border-radius: 4px;
	cursor: pointer;
	
}
.idBox {
	width: 100%;
	display: flex;
	gap: 5px;
}
</style>
<title>가지가지</title>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<jsp:include page="../home/Header.jsp" flush="true"/>
		</div>
		<div id="content_wrap">
			<div id="content">
				<div id="signUpBox">
					<h1>회원가입</h1>
					<div class="head">
						<span class="star">*</span>필수입력사항
					</div>
						<div class="input_signUp">
							<label class="nametag">아이디<span class="star">*</span></label>
							<div class="idBox">
								<input type="text" id="id" class="form-control" placeholder="아이디" >
								<button type="button" id="Id-Check-Btn">중복확인</button>
							</div>
						</div>
						<div class="input_signUp">
							<label class="nametag">비밀번호<span class="star">*</span></label>
							<input type="text" id="pw" class="form-control" placeholder="비밀번호">
						</div>
						<div class="input_signUp">
							<label class="nametag">이름<span class="star">*</span></label>
							<input type="text" id="name" class="form-control" placeholder="이름">
						</div>
						<div class="input_signUp">
							<label class="nametag">전화번호<span class="star">*</span></label>
							<input type="text" id="tel" class="form-control" placeholder="전화번호">
						</div>
						<div class="input_signUp">
							<label class="nametag">닉네임<span class="star">*</span></label>
							<input type="text" id="nickname" class="form-control" placeholder="닉네임">
						</div>
						<div class="email-form input_signUp">
							<div style="display: flex; align-items: center;">
								<label class="nametag">이메일<span class="star">*</span></label>
								<div style="width: 100%; display: flex; gap: 5px;">
									<input type="text" class="form-control" id="userEmail1" placeholder="이메일">
									<select id="userEmail2" class="form-control">
										<option>@naver.com</option>
										<option>@daum.net</option>
										<option>@gmail.com</option>
										<option>@hanmail.com</option>
										<option>@yahoo.co.kr</option>
									</select>
									<button type="button" id="mail-Check-Btn">본인인증</button>
								</div> 
							</div>
							<div class="mail-check-box" style="width: 100%; margin-top: 16px;">
								<label class="nametag">인증번호 확인<span class="star">*</span></label>
								<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
							</div>
							<span id="mail-check-warn"></span>
						</div>
						<div class="input_signUp">
							<label class="nametag">생년월일</label>
							<input type="date" id="birth" class="form-control" placeholder="생년월일">
						</div>
						<div class="input_signUp">
							<label class="nametag">성별</label>
							<div style="width: 100%; height: 46px; display: flex;">
								<div class="gender_radio">
									<span class="genderTag">여성</span>
									<input type="radio" name="gender" id="female" value="female">
								</div>
								<div class="gender_radio">
									<span class="genderTag">남성</span>
									<input type="radio" name="gender" id="male" value="male">
								</div>
							</div>
						</div>
						<div class="head"></div>
						<button type="submit" id="btn_login">회원가입</button>
				 </div>
			</div>
		</div>
	<jsp:include page="../home/Footer.jsp" flush="true"/>
	</div>
</body>
</html>