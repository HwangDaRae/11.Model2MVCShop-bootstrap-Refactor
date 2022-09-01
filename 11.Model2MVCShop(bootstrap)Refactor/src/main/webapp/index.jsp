<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// �α��ν� Forward  /////////////////////////////////////// -->
 <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- �ؿ� 4���� dialog -->
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<!-- dialog function�� �� ã�´� -->
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		label, input { display:block; }
		input.text { margin-bottom:12px; width:95%; padding: .4em; }
		fieldset { padding:0; border:0; margin-top:25px; }
		h1 { font-size: 1.2em; margin: .6em 0; }
		div#users-contain { width: 350px; margin: 20px 0; }
		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
		.ui-dialog .ui-state-error { padding: .3em; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
	</style>
   	
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

		//============= ��ǰ �˻� ==============
		function fncSearch(){
			alert('a');
			$("a[href='#']:contains('��ǰ�˻�')").bind(function(){
				//$(self.location).attr("method","post").attr("action","/product/listProduct").submit();
				self.location = "/product/listProduct";
			});
		}
		
		//============= �α��� ȭ���̵� =============
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#']:contains('�� �� ��')").on("click" , function() {
				self.location = "/user/login"
			});
		});
		
		//ȸ�����Խ� dialog ����
		$( function() {
			var dialog, form;
			
			//emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
			userId = $( "#userId" ),
			password = $( "#password" ),
			password2 = $( "#password2" ),
			userName = $( "#userName" ),
			ssn = $( "#ssn" ),
			addr = $( "#addr" ),
			phone = $( "#phone" ),
			email = $( "#email" ),
			//dialog�� ��� text
			allFields = $( [] ).add( userId ).add( password ).add( password2 ).add( userName ).add( ssn ).add( addr ).add( phone ).add( email ),
			tips = $( ".validateTips" );
			
			//���޼� üũ ����� �����ִ� ���� ������� �ǰ� ������ ���� �������
			function updateTips( t ) {
				tips.text( t ).addClass( "ui-state-highlight" );
					setTimeout(function() {
				    	tips.removeClass( "ui-state-highlight", 2500 );
					}, 500 );
			}//end of updateTips( t )
			//�Է��ʵ尡 �������� �ǰ� ��ȿ�� üũ ����� �����ִ� ���� �޽����� ���´�
			function checkLength( o, n, min, max ) {
				if ( o.val().length > max || o.val().length < min ) {
					//��ȿ�� �˻翡�� �������� ������ text�� �������� �ȴ�
					/* o.addClass( "ui-state-error" ); */
			    	updateTips( n + "�� ���̴� " + min + "���� " + max + "������ �Է����ּ���." );
			   		return false;
			    } else {
			    	return true;
			    }
			}//end of checkLength( o, n, min, max )
			//�̸��� üũ �̰ɷ� ����
			function checkRegexp( o, regexp, n ) {
				if ( !( regexp.test( o.val() ) ) ) {
					o.addClass( "ui-state-error" );
				    updateTips( n );
				    return false;
				} else {
				    return true;
				}	
			}//end of checkRegexp( o, regexp, n )
			
			//�ֹε�Ϲ�ȣ üũ
			function PortalJuminCheck(fieldValue){
			    var pattern = /^([0-9]{6})-?([0-9]{7})$/;
				var num = fieldValue;
			    if (!pattern.test(num)) return false; 
			    num = RegExp.$1 + RegExp.$2;
				var sum = 0;
				var last = num.charCodeAt(12) - 0x30;
				var bases = "234567892345";
				for (var i=0; i<12; i++) {
					if (isNaN(num.substring(i,i+1))) return false;
					sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
				}
				var mod = sum % 11;
				return ((11 - mod) % 10 == last) ? true : false;
			}//end of PortalJuminCheck(fieldValue)
			
			//user������ db�� ������
			function addUser() {
				var valid = true;
				//��ȿ�� �˻�� �������� �� text�� reset�Ѵ�
				allFields.removeClass( "ui-state-error" );
				
				//��ȿ���˻�
				//object, �̸�, �ּұ���, �ִ����
				valid = valid && checkLength( userId, "���̵�", 1, 20 );
				valid = valid && checkLength(password, "��й�ȣ", 1, 10);
				valid = valid && checkLength(password2, "��й�ȣ Ȯ��", 1, 10);
				
				if (password.val().trim().length != 0 && password2.val().trim().length != 0) {
					if (parseInt(password.val()) == parseInt(password2.val())) {
						password.removeClass("ui-state-error");
						password2.removeClass("ui-state-error");
						valid = true;
					} else {
						password2.addClass("ui-state-error");
						updateTips("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
						valid = false;
					}
				}

				valid = valid && checkLength(userName, "�̸�", 1, 50);

				if (email.val() != "") {
					if (email.val().indexOf('@') < 1 || email.val().indexOf('@') == -1 || email.val().indexOf('.') == -1) {
						//valid = valid && checkRegexp( email, emailRegex, "�̸��������� Ȯ�����ּ���" );
						updateTips("�̸��� ������ Ȯ�����ּ���");
						valid = false;
					} else {
						valid = true;
					}
				}

				//db ���ٿ���
				if (valid) {
					document.dialogForm.submit();
					dialog.dialog("close");
				}

				return valid;
			}//end of addUser()

			dialog = $("#dialog-form").dialog({
				autoOpen : false,
				height : 750,
				width : 550,
				modal : true,
				buttons : {
					"�����ϱ�" : addUser,
					��� : function() {
						dialog.dialog("close");
					}
				},
				close : function() {
					form[0].reset();
				}
			});//end of dialog ����

			form = dialog.find("form").on("submit", function(event) {
				event.preventDefault();
				addUser();
			});

			$("a[href='#' ]:contains('ȸ������')").on("click" , function() {
				dialog.dialog("open");
				$(".validateTips_checkDuplication").text("");
			});
		});
		
		// ȸ�����Խ� �������̵� ��ȭ�Ҷ����� ��밡������ db���� Ȯ���Ѵ�
		$(function(){
			//keyup, keydown, change���� �� db���� ��� userId�� ���� ������ ������ ��� ������ ������ �� �ִ�
			$("input[id='userId'][class='text ui-widget-content ui-corner-all']").bind("keyup",function(){
				var userTextId = $("input[id='userId'][class='text ui-widget-content ui-corner-all']").val();
				$.ajax({
					url : "/user/json/checkDuplication",
					method : "POST",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						userId : userTextId
					}),
					dataType : "json",
					success : function(JSONData, status) {
						if(JSONData.result === "�̹� ����ϰ� �ִ� ���̵��Դϴ�"){
							$(".validateTips_checkDuplication").css("color","red");
						}else{
							$(".validateTips_checkDuplication").css("color","blue");
						}
						
						if(userTextId.length != 0 ){
							$(".validateTips_checkDuplication").text( userTextId + '�� ' + JSONData.result );
						}else{
							$(".validateTips_checkDuplication").text("");
						}
					}
				})//end of ajax
			});
		});
		
	</script>	
	
</head>

<body>
	
	<div id="dialog-form" title="ȸ������">
	  <p class="validateTips"></p>
	 
		<form name="dialogForm" action="/user/addUser" method="post">
			<fieldset>
				<label for="name">���̵�</label>
				<input type="text" name="userId" id="userId" class="text ui-widget-content ui-corner-all">
				<p class="validateTips_checkDuplication"></p>
				<label for="name">��й�ȣ</label>
				<input type="password" name="password" id="password" class="text ui-widget-content ui-corner-all">
				<label for="name">��й�ȣ Ȯ��</label>
				<input type="password" name="password2" id="password2" class="text ui-widget-content ui-corner-all">
				<label for="name">�̸�</label>
				<input type="text" name="userName" id="userName" class="text ui-widget-content ui-corner-all">
				<label for="name">�ֹι�ȣ</label>
				<input type="text" name="ssn" id="ssn" class="text ui-widget-content ui-corner-all">
				<label for="name">�ּ�</label>
				<input type="text" name="addr" id="addr" class="text ui-widget-content ui-corner-all">
				<label for="name">�޴���ȭ��ȣ</label>
				<input type="text" name="phone" id="phone" class="text ui-widget-content ui-corner-all">
				<label for="email">Email</label>
				<input type="text" name="email" id="email" class="text ui-widget-content ui-corner-all">
	 
	      		<!-- Allow form submission with keyboard without duplicating the dialog button -->
	      		<input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
			</fieldset>
		</form>
	</div>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
		
        <div class="container">
        
        	<a class="navbar-brand" href="#">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
			<div class="collapse navbar-collapse"  id="target">
	             <ul class="nav navbar-nav navbar-right">
	                 <li><a href="#">ȸ������</a></li>
	                 <li><a href="#">�� �� ��</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- �ٴܷ��̾ƿ�  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu ���� Start /////////////////////////////////////-->     	
			<div class="col-md-3">
		        
		       	<!--  ȸ������ ��Ͽ� ���� -->
				<!-- <div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-heart"></i> ȸ������
         			</div>
         			 ȸ������ ������
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">����������ȸ</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">ȸ��������ȸ</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
					</ul>
		        </div> -->
               
               
				<!-- <div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-briefcase"></i> �ǸŻ�ǰ����
         			</div>
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ���</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ����</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
					</ul>
		        </div> -->
               
               
				<div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-shopping-cart"></i> ��ȸ��
	    			</div>
					<ul class="list-group">
						 <li class="list-group-item"><a href="/product/listProduct/search">��ǰ�˻�</a></li>
						  <li class="list-group-item">
						  	<a href="/purchase/nonMemberPurchase">��ȸ���ֹ���ȸ</a></i>
						  </li>
						 <li class="list-group-item">
						 	<a href="/cart/listCart">��ٱ���</a></i>
						 </li>
					</ul>
				</div>
				
			</div>
			<!--  Menu ���� end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>�α��� �� ��밡��...</p>
			  		<p>�α��� �� �˻��� �����մϴ�.</p>
			  		<p>ȸ������ �ϼ���.</p>
			  		
			  		<div class="text-center">
			  			<a class="btn btn-info btn-lg" href="#" role="button">ȸ������</a>
			  			<a class="btn btn-info btn-lg" href="#" role="button">�� �� ��</a>
			  		</div>
			  	
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- �ٴܷ��̾ƿ�  end /////////////////////////////////////-->
		
	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->

</body>

</html>