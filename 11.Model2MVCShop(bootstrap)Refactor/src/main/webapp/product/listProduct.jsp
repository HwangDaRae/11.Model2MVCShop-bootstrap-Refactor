<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		$(function() {
			
			$("b:contains('가격순')").bind("click",function(){
				if( $(this).attr("id") == 'asc' ){
					fncGetSortList('asc');
				}else{
					fncGetSortList('desc');
				}
			});
			
			//Autocomplete
			$("#searchKeyword").bind("click",function(){
				searchCondition = $("option:selected").val();
				$.ajax(
						{
							url : "/product/autocompleteProduct" ,
							method : "POST" ,
							dataType : "json" ,
							data : JSON.stringify({
								searchCondition : searchCondition
							}),
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								$( "#searchKeyword" ).autocomplete({
									  source: JSONData
								});
							}
						});
			});
			
			//검색 클릭시 검색조건에 맞는 데이터를 display
			$("button").bind("click",function(){
				fncGetProductList();
			});
			
			//무한페이징
			page = 1;
			$(window).scroll(function() {
				if ($(document).height() - 1100 <= parseInt($(window).scrollTop()) ){
					searchCondition = $("option:selected").val();
					searchKeyword = $("input[name='searchKeyword']").val();
					priceSort = $("input[name='priceSort']").val();
					console.log("searchCondition : " + searchCondition);
					console.log("searchKeyword : " + searchKeyword);
					console.log("page : " + page);
					
					$.ajax(
			    			{
			    				url : "/product/json/listProduct" ,
			    				data : JSON.stringify({
			    					currentPage : page,
			    					searchCondition : searchCondition,
			    					searchKeyword : searchKeyword,
			    					priceSort : priceSort
			    				}),
								method : "POST" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(item, status) {
									//alert(status);
									$.each(item, function(index, item){
										
										//form의 3번째 자식 table에 붙인다
										var displayValue = "<div class='col-md-4'>"
																+"<a href='javascript:getProductGo("+item.prodNo+")'>"
																	+"<img src='/images/uploadFiles/"+item.fileName+"' height='300' width='300'>"
																+"</a>"
																+"<p align='center' style='font-size: 30px'>"+item.prodName+"</p>"
																+"<p align='center' style='font-size: 20px'>"+item.prodDetail+"</p>"
																+"<p align='center' style='font-size: 20px; color: red;'>"+item.price+"원</p>"
															+"</div>";
												console.log("displayValue : " + displayValue);
												$("#container").append(displayValue);
												
								});//$.each
								
							}//success
			    		});//end of ajax
					//현재페이지 증가
					page++;
			    		
			    	}//end of if
			    });//end of scroll
		});
		
		//썸네일 클릭시 상세상품조회 페이지 or 상품수정 페이지로 이동
		function getProductGo(prodNo){
			tmp = ('${menu}'==='manage')?'manage':'search';
			
			if(tmp === 'manage'){
				self.location = "/product/updateProductView/"+prodNo+"/manage";
			}else{
				location.href = "/product/getProduct/"+prodNo+"/search";
			}
		}

		//검색버튼 클릭시 검색 내용에 맞는 상품리스트를 display
		function fncGetProductList() {
			document.detailForm.searchCondition.value = document.detailForm.searchCondition.value;
			document.forms[0].elements[1].value = document.forms[0].elements[1].value;
			$("#currentPage").val("1");
			$("form").attr("method","post").attr("action","/product/listProduct").submit();
		}
		
		//가격순 정렬
		function fncGetSortList(priceSort) {
			$("input[name='priceSort']").val(priceSort);
			$("#currentPage").val("1");
			$("form").submit();
		}
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>상품목록조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<b id="asc">낮은 가격순</b>&nbsp;/&nbsp;<b id="desc">높은 가격순</b>
		    	</p>
		    </div>
		    
			<div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm" action="/product/listProduct" method="post">
			 
			<div class="form-group">
				<select class="form-control" name="searchCondition" >
					<option value="0"  ${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>상품번호</option>
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>상품명</option>
					<option value="2"  ${ ! empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>상품가격</option>
				</select>
			</div>
			 
			<div class="form-group">
				<label class="sr-only" for="searchKeyword">검색어</label>
				<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
			</div>
			
			<button type="button" class="btn btn-default">검색</button>
			
			<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<input type="hidden" name="menu" value="${ menu }">
			<input type="hidden" name="priceSort" value="${ searchVO.priceSort }">
			  
			</form>
			</div>
	    	
		</div>		
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

	<!-- 썸네일로 list display start -->
	<div class="container" id="container">
		<c:set var="size" value="${ fn:length(list) }" />
		<c:if test="${ size > 0 }">
		<c:forEach var="i" begin="0" end="${ size-1 }" step="1">
			<div class="col-md-4">
				<a href="javascript:getProductGo('${ list[i].prodNo }')">
					<img src="/images/uploadFiles/${ uploadList[i] }" height="300" width="300">
				</a>
				<p align="center" style="font-size: 30px">${ list[i].prodName }</p>
				<p align="center" style="font-size: 20px">${ list[i].prodDetail }</p>
				<p align="center" style="font-size: 20px; color: red;">${ list[i].price }원</p>
			</div>
		</c:forEach>
		</c:if>
	</div> 	
	<!-- 썸네일로 list display end -->
	
</body>

</html>