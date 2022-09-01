<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ���Ż�ǰ div Start /////////////////////////////////////-->
	<div class="container">

		<div class="page-header text-info">
			<h3>���ſϷ�</h3>
		</div>

		<!--  table Start /////////////////////////////////////-->
		<table class="table table-hover table-striped">

			<thead>
				<tr class="ct_list_pop" id="divDataId">
					<th align="center">�̹���</th>
					<th></th>
					<th align="left">��ǰ ����</th>
					<th></th>
					<th align="left">��ǰ ������</th>
					<th></th>
					<th align="left">����</th>
					<th></th>
					<th align="left">����</th>
					<th></th>
					<th align="left">�� ����</th>
				</tr>
			</thead>

			<tbody>

				<c:forEach var="i" begin="0" end="${ fn:length(prodList) -1 }" step="1">
					<tr class="ct_list_pop" id="divDataId">
						<td align="center">
							<img height="100" width="100" src="/images/uploadFiles/${ uploadList[0].fileName }" />
						</td>
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
				</c:forEach>

			</tbody>

		</table>
		<!--  table End /////////////////////////////////////-->

	</div>
	<!--  ���Ż�ǰ ȭ�鱸�� div End /////////////////////////////////////-->
	<div class="container">
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�ֹ���ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${ list[0].tranId }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ھ��̵�</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${ list[0].buyer.userId == 'non-member' }">
				<td>��ȸ��</td>
				</c:if>
				<c:if test="${ list[0].buyer.userId != 'non-member' }">
				<td>${ list[0].buyer.userId }</td>
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>
			<div class="col-xs-8 col-md-4">
				${ (fn:trim(list[0].paymentOption) == '1')?"���ݱ���":"�ſ뱸��" }
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������̸�</strong></div>
			<div class="col-xs-8 col-md-4">${ list[0].receiverName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">${ list[0].receiverPhone }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${ list[0].divyAddr }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">${ list[0].divyRequest }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����������</strong></div>
			<div class="col-xs-8 col-md-4">${ list[0].divyDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ����</strong></div>
			<div class="col-xs-8 col-md-4">${ list[0].totalPrice }��</div>
		</div>
		
		<hr/>
		
 	</div>
	
</body>

</html>