<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// 로그인시 Forward  /////////////////////////////////////// -->
 <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 밑에 4개는 dialog -->
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	<!-- CDN(Content Delivery Network) 호스트 사용 -->
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<!-- dialog function을 못 찾는다 -->
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

		//============= 상품 검색 ==============
		function fncSearch(){
			alert('a');
			$("a[href='#']:contains('상품검색')").bind(function(){
				//$(self.location).attr("method","post").attr("action","/product/listProduct").submit();
				self.location = "/product/listProduct";
			});
		}
		
		//============= 로그인 화면이동 =============
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#']:contains('로 그 인')").on("click" , function() {
				self.location = "/user/login"
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

			$("a[href='#' ]:contains('회원가입')").on("click" , function() {
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
			});
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
	                 <li><a href="#">회원가입</a></li>
	                 <li><a href="#">로 그 인</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<!-- 다단레이아웃  Start /////////////////////////////////////-->
		<div class="row">
	
			<!--  Menu 구성 Start /////////////////////////////////////-->     	
			<div class="col-md-3">
		        
		       	<!--  회원관리 목록에 제목 -->
				<!-- <div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-heart"></i> 회원관리
         			</div>
         			 회원관리 아이템
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">개인정보조회</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">회원정보조회</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
					</ul>
		        </div> -->
               
               
				<!-- <div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-briefcase"></i> 판매상품관리
         			</div>
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">판매상품등록</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">판매상품관리</a> <i class="glyphicon glyphicon-ban-circle"></i>
						 </li>
					</ul>
		        </div> -->
               
               
				<div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-shopping-cart"></i> 비회원
	    			</div>
					<ul class="list-group">
						 <li class="list-group-item"><a href="/product/listProduct/search">상품검색</a></li>
						  <li class="list-group-item">
						  	<a href="/purchase/nonMemberPurchase">비회원주문조회</a></i>
						  </li>
						 <li class="list-group-item">
						 	<a href="/cart/listCart">장바구니</a></i>
						 </li>
					</ul>
				</div>
				
			</div>
			<!--  Menu 구성 end /////////////////////////////////////-->   

	 	 	<!--  Main start /////////////////////////////////////-->   		
	 	 	<div class="col-md-9">
				<div class="jumbotron">
			  		<h1>Model2 MVC Shop</h1>
			  		<p>로그인 후 사용가능...</p>
			  		<p>로그인 전 검색만 가능합니다.</p>
			  		<p>회원가입 하세요.</p>
			  		
			  		<div class="text-center">
			  			<a class="btn btn-info btn-lg" href="#" role="button">회원가입</a>
			  			<a class="btn btn-info btn-lg" href="#" role="button">로 그 인</a>
			  		</div>
			  	
			  	</div>
	        </div>
	   	 	<!--  Main end /////////////////////////////////////-->   		
	 	 	
		</div>
		<!-- 다단레이아웃  end /////////////////////////////////////-->
		
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>