<%@ page contentType="text/html; charset=euc-kr" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Insert title here</title>
</head>

<body>

<form name="updatePurchase" action="/purchase/updatePurchaseView/0" method="post">
<c:forEach var="i" begin="0" end="${ fn:length(prodList) -1 }" step="1">
<table border=1>
	<tr class="ct_list_pop" id="divDataId">
		<td align="center">
			<img height="250" width="250" src="/images/uploadFiles/${ uploadList[i] }"/></td>
		<td></td>
		<td align="left">${ prodList[i].prodName }</td>
		<td></td>
		<td align="left">${ prodList[i].prodDetail }</td>
		<td></td>
		<td align="left">${ prodList[i].price }��</td>
		<td></td>
		<td align="left">${ list[i].amount }��</td>
		<td></td>
		<td align="left">${ prodList[i].price * list[i].amount }��</td>
	</tr>
</table>
</c:forEach>
<table border=1>
	<tr>
		<td>�ֹ���ȣ</td>
		<td>${ list[0].tranId }</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<c:if test="${ list[0].buyer.userId == 'non-member' }">
		<td>��ȸ��</td>
		</c:if>
		<c:if test="${ list[0].buyer.userId != 'non-member' }">
		<td>${ list[0].buyer.userId }</td>
		</c:if>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>${ (fn:trim(list[0].paymentOption) == '1')?"���ݱ���":"�ſ뱸��" }</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>${ list[0].receiverName }</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>${ list[0].receiverPhone }</td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>${ list[0].divyAddr }</td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>${ list[0].divyRequest }</td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td>${ list[0].divyDate }</td>
		<td></td>
	</tr>
	<tr>
		<td>�� ����</td>
		<td>${ list[0].totalPrice }��</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>