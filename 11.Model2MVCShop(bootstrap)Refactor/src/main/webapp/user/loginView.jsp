<%@ page contentType="text/html; charset=euc-kr" %>

<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>�α��� ȭ��</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
	<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<!-- dialog function�� �� ã�´� -->
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script type="text/javascript">
	   
		$( function() {
			
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#userId").focus();
			
			//==>"Login"  Event ����
			$("img[src='/images/btn_login.gif']").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID �� �Է����� �����̽��ϴ�.');
					$("input:text").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
					$("input:password").focus();
					return;
				}
				
				$.ajax( 
						{
							url : "/user/json/login",
							method : "POST" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify({
								userId : id,
								password : pw
							}),
							success : function(JSONData , status) {
								//Debug...
								//alert(status);
								//alert("JSONData : \n"+JSONData);
								//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
								
								if( JSONData != null ){
									//[���1]
									//$(window.parent.document.location).attr("href","/index.jsp");
									
									//[���2]
									//window.parent.document.location.reload();
									
									//[���3]
									$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
									$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
									$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
									
									//==> ��� 1 , 2 , 3 ��� ����
								}else{
									alert("���̵� , �н����带 Ȯ���Ͻð� �ٽ� �α���...");
								}
							}
				});
			});
		});		
		
		//============= ȸ��������ȭ���̵� =============
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
					o.addClass( "ui-state-error" );
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
				
				if (password.val().trim().length != 0
						&& password2.val().trim().length != 0) {
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
					if (email.val().indexOf('@') < 1
							|| email.val().indexOf('@') == -1
							|| email.val().indexOf('.') == -1) {
						//valid = valid && checkRegexp( email, emailRegex, "�̸��������� Ȯ�����ּ���" );
						updateTips("�̸��� ������ Ȯ�����ּ���");
						console.log("6 : " + valid);
						valid = false;
					} else {
						valid = true;
					}
				}

				//db ���ٿ���
				//$("form[name='dialogForm']").submit();
				if (valid) {
					document.dialogForm.submit();
					dialog.dialog("close");
				}

				return valid;
			}//end of addUser()

			dialog = $("#dialog-form").dialog({
				autoOpen : false,
				height : 600,
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

			$("img[src='/images/btn_add.gif']").on("click", function() {
				dialog.dialog("open");
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
						$(".validateTips_checkDuplication").text( userTextId + '�� ' + JSONData.result );
					}
				})//end of ajax */
			});
		});
	</script>		
	
</head>

<body bgcolor="#ffffff" text="#000000" >
<!-- dialog -->
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

<form>

<div align="center" >

<table WITH="100%" HEIGHT="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
<tr>
<td ALIGN="CENTER" VALIGN="MIDDLE">

<table width="650" height="390" border="5" cellpadding="0" cellspacing="0" bordercolor="#D6CDB7">
  <tr> 
    <td width="10" height="5" align="left" valign="top" bordercolor="#D6CDB7">
    	<table width="650" height="390" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="305">
            <img src="/images/logo-spring.png" width="305" height="390"/>
          </td>
          <td width="345" align="left" valign="top" background="/images/login02.gif">
          	<table width="100%" height="220" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="30" height="100">&nbsp;</td>
                <td width="100" height="100">&nbsp;</td>
                <td height="100">&nbsp;</td>
                <td width="20" height="100">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="50">&nbsp;</td>
                <td width="100" height="50">
                	<img src="/images/text_login.gif" width="91" height="32"/>
                </td>
                <td height="50">&nbsp;</td>
                <td width="20" height="50">&nbsp;</td>
              </tr>
              <tr> 
                <td width="200" height="50" colspan="4"></td>
              </tr>              
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="/images/text_id.gif" width="100" height="30"/>
                </td>
                <td height="30">
                  <input 	type="text" name="userId"  id="userId"  class="ct_input_g" 
                  				style="width:180px; height:19px"  maxLength='50'/>          
          		</td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="30">&nbsp;</td>
                <td width="100" height="30">
                	<img src="/images/text_pas.gif" width="100" height="30"/>
                </td>
                <td height="30">                    
                    <input 	type="password" name="password" class="ct_input_g" 
                    				style="width:180px; height:19px"  maxLength="50" />
                </td>
                <td width="20" height="30">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30" height="20">&nbsp;</td>
                <td width="100" height="20">&nbsp;</td>
                <td height="20" align="center">
   				    <table width="136" height="20" border="0" cellpadding="0" cellspacing="0">
                       <tr> 
                         <td width="56">
                         		<img src="/images/btn_login.gif" width="56" height="20" border="0"/>
                         </td>
                         <td width="10">&nbsp;</td>
                         <td width="70">
                         		<div id="dialog-form"></div>
                       			<img src="/images/btn_add.gif" width="70" height="20" border="0">
                         </td>
                       </tr>
                     </table>
                 </td>
                 <td width="20" height="20">&nbsp;</td>
                </tr>
              </table>
            </td>
      	</tr>                            
      </table>
      </td>
  </tr>
</table>
</td>
</TR>
</TABLE>

</div>

</form>

</body>
</html>