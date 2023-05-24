<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
<table>
	<tr>
		<td>productId</td>
		<td>memberId</td>
		<td>productName</td>
		<td>price</td>
	</tr>
	<c:forEach items="${list}" var="bag">
		<tr>
			<td>${bag.productId}</td>
			<td>${bag.memberId}</td>
			<td><a href="../product/productDetail.jsp?productId=${bag.productId}&memberId=${bag.memberId}">${bag.productName}</a></td>
			<td>${bag.price}</td>
		</tr>
	</c:forEach>
</table>

