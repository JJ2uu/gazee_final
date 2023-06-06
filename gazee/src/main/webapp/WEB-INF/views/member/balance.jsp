<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <div class="">
    <div class="">
    
      <div class="fakeimg">
      <h5>구매 목록(내역)</h5>
      <table class="table table-striped">
      <tr>
        <th>상품이름</th>
        <th>금액</th>
        <th>판매자</th>
      </tr>
      <c:forEach var="i" begin="1" end="${fn:length(list)}">
      	<p id="no" style="display: none">${list[i-1].no}</p>
		<tr>
			<td>${list3[i-1].productName}</td>
			<td>${list3[i-1].price}</td>
			<td>${list4[i-1].nickname}</td>
		</tr>
		</c:forEach>
	</table>
      </div>
      
      <div class="fakeimg">
		<h5>판매 목록(내역)</h5>
     <table class="table">
      <tr>
        <th>상품이름</th>
        <th>금액</th>
        <th>구매자</th>
      </tr>   
      <c:forEach var="i" begin="1" end="${fn:length(list2)}">
      			<p id="no" style="display: none">${list2[i-1].no}</p>
      	<tbody>
		    <tr>
		        <td>${list6[i-1].productName}</td>
				<td>${list6[i-1].price}</td>
				<td>${list5[i-1].nickname}</td>		      
		    </tr>
		</tbody>
		</c:forEach>
	</table>
      </div>
    </div>
  </div>
