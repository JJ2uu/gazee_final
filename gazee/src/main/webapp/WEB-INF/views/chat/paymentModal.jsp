<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<div style="display: flex;">
		<div class="modal_productImg"></div>
		<div class="modal_productInfo">
			<div>
				<p>${bag.productName}</p>
			</div>
			<div style="font-size: 30px; font-weight: bold; margin-bottom: 5px;">
				<p>${priceDec}원</p>
			</div>
			<div
				style="display: flex; justify-content: space-between; font-size: 14px; text-align: center; color: #808080;">
				<div style="width: 20%; padding: 10px; border: 1px solid #A1A1A1; border-radius: 10px;">
					<p>${bag.dealType}</p>
				</div>
				<%
					String dealType = (String)request.getAttribute("dealType");
					System.out.println(dealType);
					if (dealType.equals("직거래")) {
				%>
				<div style="padding: 10px 20px; border: 1px solid #A1A1A1; border-radius: 10px;">
					<p>2023-05-02 19 : 30 거래예정</p>
				</div>
				<%
					}
				%>
			</div>
			<div style="display: flex; justify-content: space-between; margin: 5px 0;">
				<div>
					<p style="color: #808080;">보유 가지 씨앗</p>
				</div>
				<div>
					<p style="font-weight: bold; font-size: 18px;">3,000,000 원</p>
				</div>
			</div>
			<div>
				<p style="font-weight: bold; font-size: 18px; text-align: right; color: #808080;">-
					${priceDec} 원</p>
			</div>
			<hr style="border: 1px solid #e1e1e1; width: 100%;">
			<div style="display: flex; justify-content: space-between;">
				<div>
					<p style="color: #808080;">남는 가지 씨앗</p>
				</div>
				<div>
					<p style="font-weight: bold; font-size: 18px;">2,000,000 원</p>
				</div>
			</div>
			<button style="border: none; background: #693FAA; height: 40px; margin: 10px 0; color: #fff; border-radius: 10px; font-size: 16px;"
				id="btn_finalPayment">결제하기</button>
			<div>
				<p style="color: #693FAA; font-size: 14px;">결제시 가지 씨앗에서 ${priceDec} 원 차감됩니다.</p>
			</div>
		</div>
	</div>
</div>
<%
	String dealType2 = (String)request.getAttribute("dealType");
	if (dealType2.equals("택배거래")) {
%>
<div style="margin-top: 20px;">
	<hr style="border: 1px solid #e1e1e1; width: 100%;">
	<div style="display: flex; flex-flow: column; text-align: left;">
		<span style="font-size: 18px; font-weight: bold; margin: 10px 0;">구매자 정보</span>
		<div>
			<input type="text" id="sample6_postcode" class="address_input" placeholder="우편번호">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn_address"><br>
		</div>
		<div style="display: flex; gap: 5px;">
			<input type="text" id="sample6_address" class="address_input" placeholder="주소" style="width: 50%;">
			<input type="text" id="sample6_detailAddress" class="address_input" placeholder="상세주소" style="width: 50%;">
		</div>
	</div>
</div>
<%
	}
%>