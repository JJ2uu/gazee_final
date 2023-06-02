<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.List" %>
    <script type="text/javascript" src="../resources/js/jquery-3.6.4.js"></script>
<script type="text/javascript">	
$(function() {
	let modal_id = ""
	
	var btnClose = document.getElementById('btnClose');
	var btnInvoice = document.getElementById('btnInvoice');
	
	
	// modal 창을 감춤
	var closeRtn = function() {
		var modal = document.getElementById('modal');
		modal.style.display = 'none';
	}
	// modal 창을 보여줌
	 $('.btn_trackingNo').on("click", function() {
		modal_id = $(this).attr("id");
		console.log(modal_id)
		modal.style.display = 'block';
  	}) 
  		
	 $('.trackingNo').on("click", function(e) {
		 var str = ""
	        var tdArr = new Array();	
	        var btn = $(this);
	        
	        var tr = btn.parent().parent();
	        var td = tr.children();
	        
	        var trackingNo = td.eq(6).text().trim();
	        var deliveryCom = td.eq(5).text();
	 		console.log(trackingNo)       
	 		console.log(deliveryCom)       
		    e.preventDefault();
	 		
		    var url = "";
		    
		    if (deliveryCom == "CJ") {
		    	url ="http://nplus.doortodoor.co.kr/web/detail.jsp?slipno="+trackingNo;
			}else if (deliveryCom == "HanJin") {
				url ="https://www.hanjin.co.kr/kor/CMS/DeliveryMgr/WaybillResult.do?mCode=MN038&schLang=KR&wblnumText2="+trackingNo;
			}else {
				url ="https://www.ilogen.com/m/personal/trace/"+trackingNo;
			}
		    window.location.href = url;
		  });
	
	btnClose.onclick = closeRtn;
	btnInvoice.onclick = closeRtn;
	
	$("#btnInvoice").click(function() {
	 var deliveryCom = $('#deliveryCom option:selected').val();
	 console.log(deliveryCom)
	 const trackingNo = document.getElementById("trackingNo").value;
	 console.log(trackingNo)
	 	 
	 $.ajax({
		    url: "trackingNo",
		    data: {
		        no: modal_id,
		        deliveryCom: deliveryCom,
		        trackingNo: trackingNo
		    },
		    success: function(response) {
		        console.log(response);
		        var trackingInfo = response; // 응답으로 받은 트래킹 정보
		        var b7 = document.getElementById("b7");
		        b7.innerText = trackingInfo;
		    },
		    error: function() {
		        console.log("오류 발생");
		    }
		})
	})
})
</script>
<style>
<!--
#btn_trackingNo{
	border-radius: 5px;
	background: #6f42c1;
	color: #FFFFFF;
}
-->
</style>

<div id="sellList">
	<h5>판매 목록(내역)</h5>
     <table class="table">
       <thead>
      <tr>
        <th>판매자</th>
        <th>구매자</th>
        <th>거래방식</th>
        <th>판매상황</th>
        <th>택배/운송번호 등록하기</th>
        <th>택배사</th>
        <th>운송장번호</th>
      </tr>
      	<%
	      	@SuppressWarnings("unchecked")
			List<String> sellStatus = (List<String>)request.getAttribute("sellStatus");
      	
	      	@SuppressWarnings("unchecked")
			List<String> dealType = (List<String>)request.getAttribute("dealType");
      	%>
      	<c:forEach var="vo" items="${sellList}" varStatus="status">
			<p style="display: none">${vo.no}</p>		
      	<tbody>
		    <tr>
		        <td>${vo.sellerId}</td>
		        <td>${vo.buyerId}</td>
		        <td>${vo.dealType}</td>
		        <td id="order_status">
		        	${sellStatus[status.index]}
		        </td>
		        <td>
                    <c:if test="${dealType[status.index] eq '택배거래'}">
                        <button id="${vo.no}" class="btn_trackingNo" style="border-radius: 5px; background: #6f42c1; color: #FFFFFF;">운송장</button>
                    </c:if>
		        </td>
		        <td id="companyName">${vo.deliveryCom}</td>
		        <td>
				  <a href="#" class="trackingNo" data-trackingno="${vo.trackingNo}">
				    ${vo.trackingNo}
				  </a>
				</td>
		        <td id="b7"></td>
		    </tr>
		</tbody>
		</c:forEach>
		 </thead>
	</table>
      </div>
      <div id='modal'>
	<div id='invoice'>
		<input type='button' value='X' class="close" id='btnClose'/> 
		<select name=deliveryCom id="deliveryCom">
			<option value="">택배사 선택</option>
			<option value="HanJin">한진택배</option>
			<option value="CJ">CJ대한통운</option>
			<option value="RoGen">로젠택배</option>
		</select><br>
		<label>운송장 번호</label><br/>
		<input type='text' id='trackingNo' placeholder="운송장 번호 - 없이 입력"/><br/>
		
		<input type='button' value='확인' id='btnInvoice' class="close2"/>
	</div>
</div>