<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- 밑에 4개는 dialog -->
	<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<!-- dialog function을 못 찾는다 -->
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
	<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body > div.container{ border: 3px solid #D6CDB7; margin-top: 10px; }
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

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});
		
		//회원가입시 dialog 띄운다
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
			//dialog의 모든 text
			allFields = $( [] ).add( userId ).add( password ).add( password2 ).add( userName ).add( ssn ).add( addr ).add( phone ).add( email ),
			tips = $( ".validateTips" );
			
			//요휴성 체크 결과를 보여주는 란이 노란색이 되고 서서히 색이 사라진다
			function updateTips( t ) {
				tips.text( t ).addClass( "ui-state-highlight" );
					setTimeout(function() {
				    	tips.removeClass( "ui-state-highlight", 2500 );
					}, 500 );
			}//end of updateTips( t )
			//입력필드가 빨간색이 되고 유효성 체크 결과를 보여주는 란에 메시지가 나온다
			function checkLength( o, n, min, max ) {
				if ( o.val().length > max || o.val().length < min ) {
					//유효성 검사에서 적합하지 않으면 text가 빨간색이 된다
					/* o.addClass( "ui-state-error" ); */
			    	updateTips( n + "의 길이는 " + min + "에서 " + max + "까지로 입력해주세요." );
			   		return false;
			    } else {
			    	return true;
			    }
			}//end of checkLength( o, n, min, max )
			//이메일 체크 이걸로 안함
			function checkRegexp( o, regexp, n ) {
				if ( !( regexp.test( o.val() ) ) ) {
					o.addClass( "ui-state-error" );
				    updateTips( n );
				    return false;
				} else {
				    return true;
				}	
			}//end of checkRegexp( o, regexp, n )
			
			//주민등록번호 체크
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
			
			//user정보를 db로 보낸다
			function addUser() {
				var valid = true;
				//유효성 검사로 빨간색이 된 text를 reset한다
				allFields.removeClass( "ui-state-error" );
				
				//유효성검사
				//object, 이름, 최소길이, 최대길이
				valid = valid && checkLength( userId, "아이디", 1, 20 );
				valid = valid && checkLength(password, "비밀번호", 1, 10);
				valid = valid && checkLength(password2, "비밀번호 확인", 1, 10);
				
				if (password.val().trim().length != 0 && password2.val().trim().length != 0) {
					if (parseInt(password.val()) == parseInt(password2.val())) {
						password.removeClass("ui-state-error");
						password2.removeClass("ui-state-error");
						valid = true;
					} else {
						password2.addClass("ui-state-error");
						updateTips("비밀번호가 일치하지 않습니다");
						valid = false;
					}
				}

				valid = valid && checkLength(userName, "이름", 1, 50);

				if (email.val() != "") {
					if (email.val().indexOf('@') < 1 || email.val().indexOf('@') == -1 || email.val().indexOf('.') == -1) {
						//valid = valid && checkRegexp( email, emailRegex, "이메일형식을 확인해주세요" );
						updateTips("이메일 형식을 확인해주세요");
						valid = false;
					} else {
						valid = true;
					}
				}

				//db 갖다오기
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
					"가입하기" : addUser,
					취소 : function() {
						dialog.dialog("close");
					}
				},
				close : function() {
					form[0].reset();
				}
			});//end of dialog 정보

			form = dialog.find("form").on("submit", function(event) {
				event.preventDefault();
				addUser();
			});

			$("a:contains('회')").on("click" , function() {
				//alert('a');
				dialog.dialog("open");
				$(".validateTips_checkDuplication").text("");
			});
		});
		
		// 회원가입시 유저아이디가 변화할때마다 사용가능한지 db가서 확인한다
		$(function(){
			//keyup, keydown, change했을 때 db가서 모든 userId랑 비교해 있으면 빨간색 경고 없으면 가입할 수 있다
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
						if(JSONData.result === "이미 사용하고 있는 아이디입니다"){
							$(".validateTips_checkDuplication").css("color","red");
						}else{
							$(".validateTips_checkDuplication").css("color","blue");
						}
						
						if(userTextId.length != 0 ){
							$(".validateTips_checkDuplication").text( userTextId + '는 ' + JSONData.result );
						}else{
							$(".validateTips_checkDuplication").text("");
						}
					}
				})//end of ajax
			});//end of keyup
		});
		
	</script>		
	
</head>

<body>
	
	<div id="dialog-form" title="회원가입">
	  <p class="validateTips"></p>
	 
		<form name="dialogForm" action="/user/addUser" method="post">
			<fieldset>
				<label for="name">아이디</label>
				<input type="text" name="userId" id="userId" class="text ui-widget-content ui-corner-all">
				<p class="validateTips_checkDuplication"></p>
				<label for="name">비밀번호</label>
				<input type="password" name="password" id="password" class="text ui-widget-content ui-corner-all">
				<label for="name">비밀번호 확인</label>
				<input type="password" name="password2" id="password2" class="text ui-widget-content ui-corner-all">
				<label for="name">이름</label>
				<input type="text" name="userName" id="userName" class="text ui-widget-content ui-corner-all">
				<label for="name">주민번호</label>
				<input type="text" name="ssn" id="ssn" class="text ui-widget-content ui-corner-all">
				<label for="name">주소</label>
				<input type="text" name="addr" id="addr" class="text ui-widget-content ui-corner-all">
				<label for="name">휴대전화번호</label>
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
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					    </div>
					  </div>
			
					</form>
			   	 </div>
			
			</div>
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>