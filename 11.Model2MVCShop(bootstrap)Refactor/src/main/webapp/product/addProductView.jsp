<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
			//제조일자를 캘린더 날짜 클릭해서 등록
			$("#show_calendar").bind("click",function(){
				show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
			})
			
			//상품등록버튼 클릭
			$("button").bind("click",function(){
				alert('a');
				var prodName = $("input[name='prodName']").val();
				var prodDetail = $("input[name='prodDetail']").val();
				var manuDate = $("input[name='manuDate']").val();
				var amount = $("input[name='amount']").val();
				var price = $("input[name='price']").val();
				var uploadfile = $("input[name='uploadfile']").val();
				
				if(prodName == "" || prodName.length < 1){
					alert("상품명은 반드시 입력하여야 합니다.");
					return;
				}
				if(prodDetail == "" || prodDetail.length < 1){
					alert("상품상세정보는 반드시 입력하여야 합니다.");
					return;
				}
				if(manuDate == "" || manuDate.length < 1){
					alert("제조일자는 반드시 입력하셔야 합니다.");
					return;
				}
				if(amount == "" || amount.length < 1){
					alert("수량은 반드시 입력하셔야 합니다.");
					return;
				}
				if(price == "" || price.length < 1){
					alert("가격은 반드시 입력하셔야 합니다.");
					return;
				}
				if(uploadfile == "" || uploadfile.length < 1){
					alert("파일은 반드시 1개이상 업로드하셔야 합니다.");
					return;
				}
				
				$("form").attr("method","post").attr("action","/product/addProduct").submit();
			})
		
			//파일 업로드 제어
			$("input[name='uploadfile']").bind("change",function(){
				var fileCnt = $("input[name='uploadfile']")[0].files.length;
				if(fileCnt > 5){
					$("input[name='uploadfile']").val("");
					$( $("div.col-sm-4")[5] ).append("<strong class='text-danger'>최대 5개까지 업로드 가능합니다</strong>");
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
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">상품등록</h3>
	       <h5 class="text-muted">상품 정보를 <strong class="text-danger">등록</strong>해 주세요.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm" method="post" enctype="multipart/form-data">

			<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="등록 상품명">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="등록 상품상세정보">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="등록 제조일자">
		      <img src="../images/ct_icon_date.gif" width="15" height="15" id="show_calendar" />
		    </div>
		  </div>

			<div class="form-group">
		    <label for="amount" class="col-sm-offset-1 col-sm-3 control-label">상품수량</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="amount" name="amount" placeholder="등록 상품수량">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" placeholder="등록 가격">
		    </div>
		  </div>

			<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadfile" name="uploadfile" placeholder="등록 상품이미지" multiple="multiple">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >등 &nbsp;록</button>
			  <a class="btn btn-primary btn" href="javascript:history.back();" role="button">취 &nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->
 	
</body>

</html>