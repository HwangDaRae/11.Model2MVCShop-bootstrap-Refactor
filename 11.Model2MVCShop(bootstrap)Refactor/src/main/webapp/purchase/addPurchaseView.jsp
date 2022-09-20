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
   <!-- calendar.js -->
   <script type="text/javascript" src="/javascript/calendar.js"></script>
   <!-- import.payment.js -->
   <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
     <!-- import�� ����ϱ� ���� -->
     <script type="text/javascript">
     function requestPayment(){
    	 alert('����� ����?');
    	 IMP.init("imp83557107"); // ������ �ĺ��ڵ�
         IMP.request_pay({
        	//�ſ�ī�� ����
			/*
        	pg : 'danal_tpay',
			pay_method : 'card',
			merchant_uid: 'merchant_' + new Date().getTime(), // �������� �����ϴ� �ֹ� ��ȣ
			name : '������������',
			amount : 0,
			customer_uid : 'your-customer-unique-id', // �ʼ� �Է�.
			buyer_email : 'iamport@siot.do',
			buyer_name : '������Ʈ',
			buyer_tel : '02-1234-1234'
			*/
			
			//īī������
			/*
   			pg : 'kakaopay',
			pay_method : 'card',
			merchant_uid: 'merchant_' + new Date().getTime(), // �������� �����ϴ� �ֹ� ��ȣ
			name : '������������',
			amount : 10,
			customer_uid : 'your-customer-unique-id', // �ʼ� �Է�.
			buyer_email : 'iamport@siot.do',
			buyer_name : '������Ʈ',
			buyer_tel : '02-1234-1234'
			*/
			
			//���̹�����
			
			
			//������ �Ա�
			/*
			pg : 'chai',
			pay_method : 'trans',
			
			merchant_uid: 'merchant_' + new Date().getTime(), // �������� �����ϴ� �ֹ� ��ȣ
			name : '������������',
			amount : 10,
			customer_uid : 'your-customer-unique-id', // �ʼ� �Է�.
			buyer_email : 'iamport@siot.do',
			buyer_name : '������Ʈ',
			buyer_tel : '02-1234-1234'
			*/
     	}, function(response) {
     		//���� �� ȣ��Ǵ� callback�Լ�
     		if ( response.success ) { //���� ����
     			alert("�������� : " + response);
     		} else {
     			alert('�������� : ' + response.error_msg);
     		}
     	})
     }
     </script>
     
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
			
			$("button:contains('���ſϷ�')").bind("click",function(){
				//$("form").attr("method","post").attr("action","/purchase/addPurchase").submit();
				//import�� �����ϱ�
				alert('���ſϷ� Ŭ��');
				requestPayment();
			});
			
			$("button:contains('����')").bind("click",function(){
				history.back();
			});
			
			//�������ڸ� Ķ���� ��¥ Ŭ���ؼ� ���
			$("#show_calendar").bind("click",function(){
				show_calendar('document.detailForm.divyDate', document.detailForm.divyDate.value);
			})
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
	
		<div class="form-horizontal">
	
		<div class="page-header">
	       <h3 class=" text-info">�����������</h3>
	    </div>
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" name="prodNo" value="${ productVO.prodNo }" placeholder="��ǰ��ȣ" readonly>
		    </div>
		  </div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${ productVO.prodName }" placeholder="��ǰ��" readonly>
		    </div>
		  </div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${ productVO.prodDetail }" placeholder="��ǰ������" readonly>
		    </div>
		  </div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" value="${ productVO.manuDate }" placeholder="��������" readonly>
		    </div>
		  </div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" value="${ productVO.price }" placeholder="����" readonly>
		    </div>
		  </div>
		
		<hr/>
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="regDate" name="regDate" value="${ productVO.regDate }" placeholder="�������" readonly>
		    </div>
		  </div>
		
		<hr/>
		
		</div>
		
	</div>
	<div class="container">
		
		<div class="form-horizontal">
		
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
			<div class="col-sm-2">
				<select class="form-control" name="paymentOption" id="paymentOption">
					<option value="1" ${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  } >���ݱ���</option>
					<option value="2" ${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  } >�ſ뱸��</option>
				</select>
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="�������̸�">
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="�����ڿ���ó">
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="�������ּ�">
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="���ſ�û����">
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="divyDate" name="divyDate">
				<img src="../images/ct_icon_date.gif" width="15" height="15" id="show_calendar" />
			</div>
		</div>
		
		<hr/>
		
		<div class="form-group">
			<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">���ż���</label>
			<div class="col-sm-4">
				<input type="button" value="-">
				<b id="result">${ amount }</b>
				<input type="hidden" id="amount" name="amount" value="${ amount }">
				<input type="hidden" id="productAmount" name="productAmount" value="${ productVO.amount }">
				<input type="hidden" name="prod_no" value="${ productVO.prodNo }">
				<input type="button" value="+">
				<b id="limit"></b>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">���ſϷ�</button>
	  			<button type="button" class="btn btn-primary">����</button>
	  		</div>
		</div>
		
		<br/>
		
		</div>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	</form>

</body>

</html>