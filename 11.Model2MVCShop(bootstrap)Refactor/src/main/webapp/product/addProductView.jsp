<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
   <!-- calendar.js -->
   <script type="text/javascript" src="../javascript/calendar.js"></script>
   
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		$(function(){
			//�������ڸ� Ķ���� ��¥ Ŭ���ؼ� ���
			$("#show_calendar").bind("click",function(){
				show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
			})
			
			//��ǰ��Ϲ�ư Ŭ��
			$("button").bind("click",function(){
				alert('a');
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
				
				$("form").attr("method","post").attr("action","/product/addProduct").submit();
			})
		
			//���� ���ε� ����
			$("input[name='uploadfile']").bind("change",function(){
				var fileCnt = $("input[name='uploadfile']")[0].files.length;
				if(fileCnt > 5){
					$("input[name='uploadfile']").val("");
					$( $("div.col-sm-4")[5] ).append("<strong class='text-danger'>�ִ� 5������ ���ε� �����մϴ�</strong>");
				}else{
					$( $( $("div.col-sm-4")[5] ).children("strong") ).remove();
				}
			})
		});
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">��ǰ���</h3>
	       <h5 class="text-muted">��ǰ ������ <strong class="text-danger">���</strong>�� �ּ���.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data">

			<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="��� ��ǰ��">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��� ��ǰ������">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="��� ��������">
		      <img src="../images/ct_icon_date.gif" width="15" height="15" id="show_calendar" />
		    </div>
		  </div>

			<div class="form-group">
		    <label for="amount" class="col-sm-offset-1 col-sm-3 control-label">��ǰ����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="amount" name="amount" placeholder="��� ��ǰ����">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" placeholder="��� ����">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadfile" name="uploadfile" placeholder="��� ��ǰ�̹���" multiple="multiple">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary btn" href="javascript:history.back();" role="button">�� &nbsp;��</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
 	
</body>

</html>