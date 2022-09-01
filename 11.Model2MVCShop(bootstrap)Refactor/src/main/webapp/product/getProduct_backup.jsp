<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>
<script type="text/javascript">

$(function(){
	var productAmount = $("#productAmount").val();
	var number = $("#result").text();
	
	$("input[value='-']").bind("click",function(){
		number--;
		if( number == 0 ){
			number = 1;
		}else{
			$("#limit").text(" ");
		}
		$("#amount").val(number);
		$("#result").text(number);
	})
	
	$("input[value='+']").bind("click",function(){
		if(number < productAmount){
			number++;
		}else if(number == productAmount){
			$("#limit").text("���̻� �����Ͻ� �� �����ϴ�");
			return;
		}
		$("#amount").val(number);
		$("#result").text(number);
	})
		
	$("td.ct_btn01:contains('��ٱ��� ���')").bind("click",function(){
		if(confirm('��ٱ��Ͽ� �����ðڽ��ϱ�?')){
			$("form").submit();
		}
	})
	
	$("td.ct_btn01:contains('����')").bind("click",function(){
		$("form").attr("action","/purchase/addPurchaseView").submit();
	})
	
	$("td.ct_btn01:contains('����')").bind("click",function(){
		history.go(-1)
	})
});

</script>

<%--
Product vo = (Product)request.getAttribute("productVO");
System.out.println(vo);
//��ǰ��ȣ�� ��Ű�� ��´�
String history = "";

Cookie[] cookies = request.getCookies();

if(cookies != null && cookies.length > 0) {
	for (int i = 0; i < cookies.length; i++) {
		if(cookies[i].getName().equals("prodInfoCookie")) {
			history = URLDecoder.decode(cookies[i].getValue()) + "," + vo.getProdNo();
		}
	}			
}

if(history.isEmpty()) {
	history = vo.getProdNo()+"";
}

Cookie cookie = new Cookie("prodInfoCookie", URLEncoder.encode(history));
cookie.setMaxAge(24*60*60);
response.addCookie(cookie);
--%>

<html>
<head>
<meta charset="EUC-KR">

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>Insert title here</title>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post" action="/cart/addCart">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"	width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ����ȸ</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"  width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${ productVO.prodNo }</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ productVO.prodName }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ productVO.prodDetail }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ productVO.manuDate }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ productVO.price }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ productVO.regDate }</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ż���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="button" value="-">
			<b id="result">1</b>
			<input type="hidden" id="amount" name="amount" value="1">
			<input type="hidden" id="productAmount" name="productAmount" value="${ productVO.amount }">
			<input type="hidden" name="prod_no" value="${ productVO.prodNo }">
			<input type="button" value="+">
			<b id="limit"></b>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�̹��� <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<!-- ���̺� ���� -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="26">
						<c:if test="${ count > 0 }">
							<c:forEach var="i" items="${ uploadList }" begin="0" step="1" end="${ count-1 }">
								<b id="123">
									<img src="/images/uploadFiles/${ i.fileName }"/><br/>
									${ i.fileName }<br/>
								</b>
							</c:forEach>
						</c:if>
						<c:if test="${ count <= 0 }">
						�̹�������
						</c:if>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>



<table width="100%" border="0" cellspacing="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">

		<table border="0" cellspacing="0">
			<tr>
			
				<c:if test="${ sessionScope.user.userId == 'non-member' }">userId == non-member</c:if>
				<c:if test="${ sessionScope.user.userId != 'non-member' }">userId != non-member</c:if>
				<c:if test="${ sessionScope.user.role == 'user' }">role == user</c:if>
				<c:if test="${ sessionScope.user.role != 'user' }">role != user</c:if>
				
				<c:if test="${ sessionScope.user.userId == 'non-member' || sessionScope.user.role == 'user' }">
			
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					��ٱ��� ���
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
				<td width="30"></td>
				
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						����
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<td width="30"></td>
				</c:if>
				
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					����
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
</form>

</body>
</html>