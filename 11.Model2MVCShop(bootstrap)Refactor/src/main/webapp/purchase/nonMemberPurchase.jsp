<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$("input[value='�ֹ���ȸ']").bind("click",function(){
		if( $("#tranId").val().length == 14 ){
			$("form").attr("method","post").attr("action","/purchase/getNonMemPurchase").submit();
		}
	})
});
</script>
</head>
<body>
	<form name="detailForm" action="/purchase/getNonMemPurchase" method="post">
		<table>
			<tr>
				<td>�ֹ���ȣ : <input type="text" id="tranId" name="tranId"><input type="button" value="�ֹ���ȸ"></td>
			</tr>
		</table>
	</form>
</body>
</html>
