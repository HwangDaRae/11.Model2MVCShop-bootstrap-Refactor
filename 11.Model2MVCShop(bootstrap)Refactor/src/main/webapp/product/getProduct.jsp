<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		$(function(){
			var productAmount = $("#productAmount").val();
			var number = $("#result").text();
			
			$("input[value='-']").bind("click",function(){
				number--;
				if( parseInt(number) == 0 ){
					number = 1;
				}else{
					$("#limit").text(" ");
				}
				$("#amount").val(number);
				$("#result").text(number);
			})
			
			$("input[value='+']").bind("click",function(){
				if(parseInt(number) < parseInt(productAmount)){
					number++;
				}else if(parseInt(number) == parseInt(productAmount)){
					$("#limit").text("���̻� �����Ͻ� �� �����ϴ�");
					return;
				}
				$("#amount").val(number);
				$("#result").text(number);
			})
			
			$("button:contains('��ٱ��� ���')").bind("click",function(){
				if(confirm('��ٱ��Ͽ� �����ðڽ��ϱ�?')){
					$("form").attr("method","post").attr("action","/cart/addCart").submit();
				}
			});
			
			$("button:contains('����')").bind("click",function(){
				$("form").attr("method","post").attr("action","/purchase/addPurchaseView").submit();
			});
			
			$("button:contains('����')").bind("click",function(){
				history.back();
			});
		});
	</script>
	
</head>

<body>
	<form name="detailForm" method="post" action="/cart/addCart">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.prodNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.prodName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.prodDetail }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.manuDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.price }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.regDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ż���</strong></div>
			<div class="col-xs-8 col-md-4">
				<input type="button" value="-">
				<b id="result">1</b>
				<input type="hidden" id="amount" name="amount" value="1">
				<input type="hidden" id="productAmount" name="productAmount" value="${ productVO.amount }">
				<input type="hidden" name="prod_no" value="${ productVO.prodNo }">
				<input type="button" value="+">
				<b id="limit"></b>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${ count > 0 }">
					<c:forEach var="i" items="${ uploadReturnList }" begin="0" step="1" end="${ count-1 }">
						<div class="container">
							<div class="col-md-12">
								<img src="/images/uploadFiles/${ i.fileName }"/><br/>
								${ i.fileName }<br/>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${ count <= 0 }">
				�̹�������
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<c:if test="${ user.role != 'admin' }">
		  			<button type="button" class="btn btn-primary">��ٱ��� ���</button>
	  				<button type="button" class="btn btn-primary">����</button>
	  			</c:if>
	  				<button type="button" class="btn btn-primary">����</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	</form>

</body>

</html>