<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
   <script type="text/javascript" src="/javascript/calendar.js"></script>
   
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
        #limit {
        	font-size: 20px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		$(function(){
			$("button").bind("click",function(){
				var prodName = $("input[name='prodName']").val();
				var prodDetail = $("input[name='prodDetail']").val();
				var manuDate = $("input[name='manuDate']").val();
				var amount = $("input[name='amount']").val();
				var price = $("input[name='price']").val();
				
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
				if(fileCnt + fileLength > 5){
					$("#limit").text("�ִ� 5������ ���ε� �����մϴ�");
					$("input[name='uploadfile']").val("");
				}else{
					$("#limit").text(" ");
				}
			})
			
			$("input[value='���ϼ���']").bind("click",function(){
				var value = $(this).parent().attr("id");
				//type='hidden' name='deleteFile'�� ��ǰ���� �ִ´�
				$($(this).parent().parent().children()[0]).attr("value", value)
			})
			
			$("input[value='���ϻ���']").bind("click",function(){
				var value = $(this).parent().attr("id");
				//type='hidden' name='deleteFile'�� ��ǰ���� �ִ´�
				$($(this).parent().parent().children()[0]).attr("value", value)
				$(this).parent().remove();
				fileCnt--;
			})
			
			$("#show_calendar").bind("click",function(){
				show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)
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
	       <h3 class=" text-info">��ǰ��������</h3>
	       <h5 class="text-muted">��ǰ ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm" action="/product/updateProduct" method="post" enctype="multipart/form-data">

		<input type="hidden" name="prodNo" value="${ productVO.prodNo }"/>
		<input type="hidden" name="fileName" value="${ productVO.fileName }"/>
		<input type="hidden" name="regDate" value="${ productVO.regDate }"/>
		
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" value="${ productVO.prodNo }" placeholder="�ߺ�Ȯ���ϼ���"  readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">��ǰ��ȣ�� �����Ұ�</strong>
		      </span>
		    </div>
		  </div>

			<div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${productVO.prodName}" placeholder="�����ǰ��">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail"  value="${productVO.prodDetail}" placeholder="�����ǰ������">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="manuDate" value="${productVO.manuDate}" placeholder="������������">
		      <img src="/images/ct_icon_date.gif" width="15" height="15" id="show_calendar" />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="amount" name="amount"  value="${productVO.amount}" placeholder="�������">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price"  value="${productVO.price}" placeholder="���氡��">
		    </div>
		  </div>
		  
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">��ǰ�̹���</label>
			<div class="col-sm-4">
				<input type="file" class="form-control" id="uploadfile" name="uploadfile" multiple="multiple">
				<b id="limit"></b>
				<div class="container" id="container">
					<c:if test="${ count > 0 }">
					<c:forEach var="i" items="${ uploadList }" begin="0" end="${ count-1 }" step="1">
						<div class="col-md-4">
							<input type="hidden" name="deleteFile">
							<b id="${i.fileName }">
								<img src="/images/uploadFiles/${ i.fileName }" height="150" width="150">
								<input type="file" name="uploadfile" value="���ϼ���" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13">
								<input type="button" value="���ϻ���">${ i.fileName }<br/>
							</b>
						</div>
					</c:forEach>
					</c:if>
				</div>				
			</div>
		</div>
		  
		<div class="form-group">
			<div class="col-sm-offset-4  col-sm-4 text-center">
				<button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
				<a class="btn btn-primary btn" href="javascript:history.back();" role="button">�� &nbsp;��</a>
			</div>
		</div>
	</form>
		<!-- form End /////////////////////////////////////-->
	    
 	</div>
	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
</body>

</html>