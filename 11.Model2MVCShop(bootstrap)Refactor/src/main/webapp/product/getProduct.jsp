<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
					$("#limit").text("더이상 구매하실 수 없습니다");
					return;
				}
				$("#amount").val(number);
				$("#result").text(number);
			})
			
			$("button:contains('장바구니 담기')").bind("click",function(){
				if(confirm('장바구니에 담으시겠습니까?')){
					$("form").attr("method","post").attr("action","/cart/addCart").submit();
				}
			});
			
			$("button:contains('구매')").bind("click",function(){
				$("form").attr("method","post").attr("action","/purchase/addPurchaseView").submit();
			});
			
			$("button:contains('이전')").bind("click",function(){
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
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.prodNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.prodName }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.prodDetail }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.manuDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.price }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${ productVO.regDate }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매수량</strong></div>
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
	  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
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
				이미지없음
				</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<c:if test="${ user.role != 'admin' }">
		  			<button type="button" class="btn btn-primary">장바구니 담기</button>
	  				<button type="button" class="btn btn-primary">구매</button>
	  			</c:if>
	  				<button type="button" class="btn btn-primary">이전</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->
	</form>

</body>

</html>