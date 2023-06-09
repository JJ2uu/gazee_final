<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="../resources/favicon.ico">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap" rel="stylesheet">
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<link href="../resources/css/FindPw.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">
	function PwReset() {	
		var id = $('#id').val();
		const email = $('#userEmail1').val() + $("select[name='userEmail2'] option:selected").text(); // 이메일 주소값 얻어오기!
		
		 var isValid = true; // 유효성 검사 플래그
			
		 if (id === '') {
		        isValid = false;
		        alert("아이디를 입력해주세요");
		    }
 		 if (email === '') {
		        isValid = false;
		        alert("이메일을 입력해주세요");
		    } 
		 if ($('#mail-check-input').val() !== code) {
		        isValid = false;
		        alert("인증번호가 일치하지 않습니다.");
		    }
		 
		 if (isValid) {
			 $('#idDoubleChk').val(true); // 유효성 검사가 통과되었을 경우 hidden input 값을 변경		 
				$.ajax({
					url:"findPw",
					type:'post',
					data:{
						id: id,
						email: email
					},
					success: function(result) {
						// console.log(result)
						if (result == 0) {
							alert("떙!")
						}else {
						$('#content').html(result)	
						alert(id)
						}
						//location.href="newPw.jsp"
					},//success
				})//ajax
	}else {
        $('#idDoubleChk').val(false); // 유효성 검사를 통과하지 못한 경우 hidden input 값을 변경
    }
}
		function PwidCheck() {	
			 var id = $('#id').val()
			 	console.log(id)
				 if ($('#id').val() != '') {				
				        // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
				        $.ajax({		   					
				            type: 'GET',
				            url: 'PWidcheck',
				            data: {
				            	 id: id
				            	},   	
				            success: function(result) {	
				            	  $('#result').text(result);
				            	  $('#result').attr('color', '#693FAA');			            	  
				            },
				            error: function(a, b, c) {
				            	
				                console.log(a, b, c);
				            }		   					
				        });		   				
				    } else {
				        alert('아이디를 입력하세요.');
				        $('#id').focus();
				    }	
			}; 
	$(function() {
			$('#mail-check-input').blur(
					function() {
						const inputCode = $(this).val();
						const $resultMsg = $('#mail-check-warn');
						
						console.log("input : " +inputCode)
						console.log("code : " +code)
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
			})
			function emailCheck() {	
				/* console.log('이메일1 : ' + $('#userEmail1').val()); // 이메일 오는지 확인
				console.log('이메일2 : ' + $("select[name='userEmail2']").text()); // 이메일 오는지 확인 */
				const email = $('#userEmail1').val() + $("select[name='userEmail2'] option:selected").text(); // 이메일 주소값 얻어오기!					
				const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
				
				 $.ajax({
					type : 'post',
					url : "checkMail", // GET방식이라 Url 뒤에 email을 뭍힐수있다.
					data:{
						email : email				
					},
					success : function(data) {
						console.log("data : " +  data);
						checkInput.attr('disabled',false);
						code = data;
						alert('인증번호가 전송되었습니다.')
					}
				}); // end ajax 
			}; // end send eamil	
</script>
<title>가지가지</title>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<jsp:include page="../home/Header.jsp" flush="true"/>
		</div>
		<div id="content_wrap">
			<div id="content">
				<div id="FindPwBox">
					<h1>비밀번호 찾기</h1>
						<div class="head">
							<span class="star">*</span>필수입력사항
						</div>
					<div class="input_signUp">
						<label class="nametag">아이디<span class="star">*</span></label>
						<div class="idBox">
							<input type="text" id="id" class="form-control" placeholder="아이디" >
							<button type="button" id="Id-Check-Btn" onclick="PwidCheck()">아이디확인</button>
							<input type="hidden" id ="idCheck"/>
						</div>			
					</div>
							<div id="result" size="1" style="color:#693FAA"></div>	
			 	<div class="email-form input_signUp">
							<div style="display: flex; align-items: center;">
								<label class="nametag">이메일<span class="star">*</span></label>
								<div style="width: 100%; display: flex; gap: 5px;">
									<input type="text" class="form-control" id="userEmail1" placeholder="이메일">
									<input type="hidden" id ="emailCheck"/>
									<select name="userEmail2" class="form-control">
										<option value="naver">@naver.com</option>
										<option value="daum">@daum.net</option>
										<option value="gmail">@gmail.com</option>												
									</select>
									<button type="button" id="mail_Check_Btn" onclick="emailCheck()">이메일 인증</button>
								</div> 
							</div>
							<div class= "mail-check-box" style="width: 100%; margin-top: 16px;">
								<label class="nametag">인증번호 확인<span class="star">*</span></label>
								<input class="form-control mail-check-input" id="mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">								
								<input type="hidden" id ="emailCheck"/>
							</div>
							<span id="mail-check-warn"></span>
						</div>
					<button type="submit" id="PwReset" onclick="PwReset()">확인</button>
				</div>
			</div>
		</div>
	<jsp:include page="../home/Footer.jsp" flush="true"/>
	</div>
</body>
</html>