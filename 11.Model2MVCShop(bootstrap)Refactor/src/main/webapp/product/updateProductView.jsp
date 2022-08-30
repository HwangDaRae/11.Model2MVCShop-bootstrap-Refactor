<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>��ǰ��������</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>
<script type="text/javascript" src="/javascript/calendar.js"></script>

<script type="text/javascript">
$(function(){
	$("td.ct_btn01:contains('����')").bind("click",function(){
		var prodName = $("input[name='prodName']").val();
		var prodDetail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var amount = $("input[name='amount']").val();
		var price = $("input[name='price']").val();
		var uploadfile = $("input[name='uploadfile']").val();
		
		if(prodName == "" || prodName.length < 1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(prodDetail == "" || prodDetail.length < 1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(manuDate == "" || manuDate.length < 1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(amount == "" || amount.length < 1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == "" || price.length < 1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(uploadfile == "" || uploadfile.length < 1){
			alert("������ �ݵ�� 1���̻� ���ε��ϼž� �մϴ�.");
			return;
		}
		
		$("form").attr("action","/product/updateProduct").submit();
	})
	
	$("td.ct_btn01:contains('���')").bind("click",function(){
		$("form").each(function(){
			this.reset();
		})
	})
	
	var fileCnt = ${ count };
	$("input[name='uploadfile']").bind("change",function(){
		var fileLength = $("input[name='uploadfile']")[0].files.length;
		alert(fileLength);
		if(fileCnt + fileLength > 5){
			$("#limit").text("�ִ� 5������ ���ε� �����մϴ�");
			$("input[name='uploadfile']").val("");
		}else{
			$("#limit").text(" ");
		}
	})
	
	$("input[value='���ϻ���']").bind("click",function(){
		$(this).parent().remove();
		fileCnt--;
	})	
	
	$("#show_calendar").bind("click",function(){
		show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)
	})
	
});

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="detailForm" method="post" enctype="multipart/form-data">

<input type="hidden" name="prodNo" value="${ productVO.prodNo }"/>
<input type="hidden" name="fileName" value="${ productVO.fileName }"/>
<input type="hidden" name="prodName" value="${ productVO.prodName }"/>
<input type="hidden" name="regDate" value="${ productVO.regDate }"/>

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">��ǰ����</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
						<input 	type="text" disabled="disabled" class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20" value="${ productVO.prodName }">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			��ǰ������ <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="prodDetail" value="${ productVO.prodDetail }" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="10"	minLength="6">
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������
			<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="manuDate" readonly="readonly" value="${ productVO.manuDate }" class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6" />
			&nbsp;
			<img src="/images/ct_icon_date.gif" width="15" height="15" id="show_calendar" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="amount" value="${ productVO.amount }"
						class="ct_input_g" style="width: 100px; height: 19px" maxLength="50"/>&nbsp;��
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="price" value="${ productVO.price }"
						class="ct_input_g" style="width: 100px; height: 19px" maxLength="50"/>&nbsp;��
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��ǰ�̹���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="file" name="uploadfile" multiple="multiple">
			<b id="limit"></b>
		</td>
		<!-- ���̺� ���� -->
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="26">
					<c:if test="${ count > 0 }">
						<c:forEach var="i" items="${ uploadList }" begin="0" step="1" end="${ count-1 }">
							<b id="${i.fileName }">
								<img src="/images/uploadFiles/${ i.fileName }"/><br/>
								<input type="file" name="uploadfile" value="���ϼ���" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13">
								<input type="button" value="���ϻ���">${ i.fileName }<br/>
							</b>
						</c:forEach>
					</c:if>
				</td>
			</tr>
		</table>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
						����
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif"width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						���
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>