<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	 $(function() {
			$('#buyerCon').click(function() {
				let no = $('#no').text()
						$.ajax({
							url:"buyerCon",
							type:'post',
							data:{
								no : no
							},
							success: function(result) {
								console.log(result)
								location.href="mypage.jsp"
							},//success
						})//ajax
			})
		})
		
	</script>
<div id="purchsList">
      <h5>구매 목록(내역)</h5>
      <table class="table table-striped" style="border: 0px !important" >
       <thead>
         <tr>
	        <th>상품이름</th>
	        <th>금액</th>
	        <th>판매자</th>
	        <th>거래상태</th>
	        <th>운송장번호</th>
	        <th>직거래 날짜</th>
	        <th>구매확정</th>
	     </tr>
        </thead>
        <tbody>
      	<c:forEach var="i" begin="1" end="${fn:length(list)}">
      	<p id="no" style="display: none">${list[i-1].no}</p>
		<tr>
			<td>${list2[i-1].productName}</td>
			<td>${list2[i-1].price}</td>
			<td>${list3[i-1].nickname}</td>
			<td>${sellStatus[i-1]}</td>
			<td>${list[i-1].trackingNo}</td>
			<td>${directDate[i-1].dealDirectDate}</td>
			<td> <button id="buyerCon" >구매확정</button></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>   
      <br>
</div>