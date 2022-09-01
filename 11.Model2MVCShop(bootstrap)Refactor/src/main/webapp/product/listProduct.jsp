<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
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
			
			$("b:contains('���ݼ�')").bind("click",function(){
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
			
			//�˻� Ŭ���� �˻����ǿ� �´� �����͸� display
			$("button").bind("click",function(){
				fncGetProductList();
			});
			
			//��������¡
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
										
										//form�� 3��° �ڽ� table�� ���δ�
										var displayValue = "<div class='col-md-4'>"
																+"<a href='javascript:getProductGo("+item.prodNo+")'>"
																	+"<img src='/images/uploadFiles/"+item.fileName+"' height='300' width='300'>"
																+"</a>"
																+"<p align='center' style='font-size: 30px'>"+item.prodName+"</p>"
																+"<p align='center' style='font-size: 20px'>"+item.prodDetail+"</p>"
																+"<p align='center' style='font-size: 20px; color: red;'>"+item.price+"��</p>"
															+"</div>";
												console.log("displayValue : " + displayValue);
												$("#container").append(displayValue);
												
								});//$.each
								
							}//success
			    		});//end of ajax
					//���������� ����
					page++;
			    		
			    	}//end of if
			    });//end of scroll
		});
		
		//����� Ŭ���� �󼼻�ǰ��ȸ ������ or ��ǰ���� �������� �̵�
		function getProductGo(prodNo){
			tmp = ('${menu}'==='manage')?'manage':'search';
			
			if(tmp === 'manage'){
				self.location = "/product/updateProductView/"+prodNo+"/manage";
			}else{
				location.href = "/product/getProduct/"+prodNo+"/search";
			}
		}

		//�˻���ư Ŭ���� �˻� ���뿡 �´� ��ǰ����Ʈ�� display
		function fncGetProductList() {
			document.detailForm.searchCondition.value = document.detailForm.searchCondition.value;
			document.forms[0].elements[1].value = document.forms[0].elements[1].value;
			$("#currentPage").val("1");
			$("form").attr("method","post").attr("action","/product/listProduct").submit();
		}
		
		//���ݼ� ����
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>��ǰ�����ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<b id="asc">���� ���ݼ�</b>&nbsp;/&nbsp;<b id="desc">���� ���ݼ�</b>
		    	</p>
		    </div>
		    
			<div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm" action="/product/listProduct" method="post">
			 
			<div class="form-group">
				<select class="form-control" name="searchCondition" >
					<option value="0"  ${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>��ǰ��ȣ</option>
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>��ǰ��</option>
					<option value="2"  ${ ! empty search.searchCondition && search.searchCondition == 2 ? "selected" : "" }>��ǰ����</option>
				</select>
			</div>
			 
			<div class="form-group">
				<label class="sr-only" for="searchKeyword">�˻���</label>
				<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���" value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
			</div>
			
			<button type="button" class="btn btn-default">�˻�</button>
			
			<!-- PageNavigation ���� ������ ���� ������ �κ� -->
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<input type="hidden" name="menu" value="${ menu }">
			<input type="hidden" name="priceSort" value="${ searchVO.priceSort }">
			  
			</form>
			</div>
	    	
		</div>		
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

	<!-- ����Ϸ� list display start -->
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
				<p align="center" style="font-size: 20px; color: red;">${ list[i].price }��</p>
			</div>
		</c:forEach>
		</c:if>
	</div> 	
	<!-- ����Ϸ� list display end -->
	
</body>

</html>