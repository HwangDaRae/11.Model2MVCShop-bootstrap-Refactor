<%@page import="com.model2.mvc.service.domain.User"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>

<script type="text/javascript">
	function history() {
		popWin = window.open( "/history.jsp", "popWin",
			"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	}

	//==> jQuery ���� �߰��� �κ�
	$(function() {
		//==> ����������ȸ Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(".Depth03:contains('����������ȸ')").bind( "click",function() {
			//Debug..
			//alert(  $( ".Depth03:contains('����������ȸ')" ).html() );
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
		});

		//==> ȸ��������ȸ Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(".Depth03:contains('ȸ��������ȸ')").bind( "click",function() {
			//Debug..
			//alert(  $( ".Depth03:contains('ȸ��������ȸ')" ) );
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/user/listUser");
		});
		
		$(".Depth03:contains('�ǸŻ�ǰ���')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/addProductView");
		});
		
		$(".Depth03:contains('�ǸŻ�ǰ����')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct/manage");
		});
		
		$(".Depth03:contains('�� ǰ �� ��')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/product/listProduct/search");
		});
		
		$(".Depth03:contains('�����̷���ȸ')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/listPurchase");
		});
		
		$(".Depth03:contains('��ٱ���')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/cart/listCart");
		});
		
		$(".Depth03:contains('��ȸ���ֹ���ȸ')").bind( "click",function() {
			$(window.parent.frames["rightFrame"].document.location).attr("href", "/purchase/nonMemberPurchase");
		});
		
		$(".Depth03:contains('�ֱ� �� ��ǰ')").bind( "click",function() {
			history();
		});
	});
</script>
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="159" border="0" cellspacing="0" cellpadding="0">
<!--menu 01 line-->
<tr>
	<td valign="top">
		<table border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<c:if test="${ !empty user }">
					<tr>
						<td class="Depth03">����������ȸ</td>
					</tr>
				</c:if>
				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03">ȸ��������ȸ</td>
					</tr>
				</c:if>
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<c:if test="${user.role == 'admin'}">
<!--menu 02 line-->
<tr>
<td valign="top"> 
	<table  border="0" cellspacing="0" cellpadding="0" width="159">
		<tr>
			<td class="Depth03">
				<!-- <a href="/product/addProductView" target="rightFrame">�ǸŻ�ǰ���</a> -->
				�ǸŻ�ǰ���
			</td>
		</tr>
		<tr>
		<td class="Depth03">
				<!-- <a href="/product/listProduct/manage" target="rightFrame">�ǸŻ�ǰ����</a> -->
				�ǸŻ�ǰ����
			</td>
		</tr>
		<tr>
			<td class="DepthEnd">&nbsp;</td>
		</tr>
	</table>
</td>
</tr>
</c:if>

<!--menu 03 line-->
<tr>
<td valign="top">
	<table  border="0" cellspacing="0" cellpadding="0" width="159">
		<tr>
			<td class="Depth03"><!-- /menu=search -->
				<!-- <a href="/product/listProduct/search" target="rightFrame">�� ǰ �� ��</a> -->
				�� ǰ �� ��
			</td>
		</tr>
		<c:if test="${ !empty user && user.role == 'user'}">
		<tr>
			<td class="Depth03">
				<!-- <a href="/purchase/listPurchase" target="rightFrame">�����̷���ȸ</a><br/> -->
				�����̷���ȸ
			</td>
		</tr>
		</c:if>
		<tr>
			<td class="Depth03">
				<!-- <a href="/cart/listCart" target="rightFrame">��ٱ���</a><br/> -->
				��ٱ���
			</td>
		</tr>
		<c:if test="${ empty user || user.userId == 'non-member' }">
		<tr>
			<td class="Depth03">
				<!-- <a href="/purchase/nonMemberPurchase" target="rightFrame">��ȸ���ֹ���ȸ</a><br/> -->
				��ȸ���ֹ���ȸ
			</td>
		</tr>
		</c:if>
		<tr>
		<td class="DepthEnd">&nbsp;</td>
		</tr>
		<tr>
			<td class="Depth03">
			<!-- <a href="javascript:history()">�ֱ� �� ��ǰ</a> -->
			�ֱ� �� ��ǰ
			</td>
		</tr>
	</table>
</td>
</tr>

</table>
</body>
</html>