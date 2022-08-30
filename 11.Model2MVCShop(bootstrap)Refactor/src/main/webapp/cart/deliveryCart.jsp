<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<title>Insert title here</title>
<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>

<script type="text/javascript">
$(function(){
	$("input[value='�����Ϸ�']").bind("click",function(){
		confirm('�����Ϸ� �Ͻðڽ��ϱ�?');
		document.detailForm.submit();
	})
	
	$("#show_calendar").bind("click",function(){
		show_calendar('document.detailForm.divyDate', document.detailForm.divyDate.value)
	})
})
</script>
</head>

<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/css/admin.css" type="text/css">
</head>

<body bgcolor="#ffffff" text="#000000">
	<div style="width: 98%; margin-left: 10px;">
		<form name="detailForm" action="/purchase/addCartPurchase" method="post">
			<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">${ sessionScope.user.role } ��۳���</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37" /></td>
				</tr>
			</table>


			<table id="dataTable" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td colspan="11">
						�� ${ count } ���� ��ǰ����&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="�����Ϸ�">
					</td>

				</tr>
				<tr>
					<td class="ct_list_b" width="100">��ǰ�̹���</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">����</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
					<!-- list���� -->
					<c:set var="size" value="${ fn:length(purList) }"/>
					<c:if test="${ fn:length(purList) > 0 }">
						<c:forEach var="i" begin="0" end="${ size-1 }" step="1">
						
							<input type="text" name="productNo" value="${ purList[i].purchaseProd.prodNo }">
							<input type="text" name="amountArr" value="${ purList[i].amount }">
							
							<tr class="ct_list_pop" id="divDataId">
								<td align="center"><img height="250" width="250" src="/images/uploadFiles/${ uploadList[i] }"/></td>
								<td></td>
								<td align="left">${ purList[i].purchaseProd.prodName }</td>
								<td></td>
								<td align="left">${ purList[i].purchaseProd.prodDetail }</td>
								<td></td>
								<td align="left">${ purList[i].amount }��</td>
								<td></td>
								<td align="left">${ purList[i].purchaseProd.price }�� * ${ purList[i].amount }�� = ${ purList[i].purchaseProd.price * purList[i].amount }��</td>
							</tr>
							<tr>
								<td colspan="11" bgcolor="D6D7D6" height="1"></td>
							</tr>
						</c:forEach>
					</c:if>
				<tr>
					<td width="104" class="ct_write">���Ź��</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
							<option value="1" selected="selected">���ݱ���</option>
							<option value="2">�ſ뱸��</option>
						</select>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�������̸�</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="receiverName" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�����ڿ���ó</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input 	type="text" name="receiverPhone" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�������ּ�</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input 	type="text" name="divyAddr" class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">���ſ�û����</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="divyRequest" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">����������</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td width="200" class="ct_write01">
						<input type="text" name="divyDate" class="ct_input_g"
							style="width: 100px; height: 19px" maxLength="20"/>
							<img src="../images/ct_icon_date.gif" width="15" height="15" id="show_calendar"/>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td align="left"><input type="button" value="�����Ϸ�"></td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>