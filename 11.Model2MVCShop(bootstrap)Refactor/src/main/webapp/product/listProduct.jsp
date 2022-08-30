<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<script src="//code.jquery.com/jquery-2.1.4.js" type="text/javascript"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">

$(function(){
	
	$("#navigator_start").bind("click",function(){
		fncGetList(1)
	})
	
	$("#navigator_before").bind("click",function(){
		fncGetList(${ resultPage.beginUnitPage-1 })
	})
	
	$("#navigator_after").bind("click",function(){
		fncGetList(${ resultPage.endUnitPage+1 })
	})
	
	$("#navigator_end").bind("click",function(){
		fncGetList('${ resultPage.maxPage }')
	})
	
	$("b:contains('���ݼ�')").bind("click",function(){
		if( $(this).attr("id") == 'asc' ){
			fncGetSortList('asc')
		}else{
			fncGetSortList('desc')
		}
	})
	
	$("td.ct_btn01:contains('�˻�')").bind("click",function(){
		fncGetProductList()
	})
	
	$(".ct_list_").bind("click",function(){
		var prodNo = $(this).parent().parent().attr("id");
		var ajax_id = $(this).text();
		alert("ajax_id : " + ajax_id);
		var proTranCode = $($(this).parent().parent().children()[2]).attr("id");
		
		if($(this).text().trim() == "-����ϱ�"){
			location.href="/purchase/updateTranCodeByProd?prodNo="+id+"&currentPage=${ resultPage.currentPage }&tranCode=2&menu=${ menu }";
		}else if(proTranCode == 0){
			alert('a');
			location.href="/product/getProduct/"+id+"/${ menu }";
		}else{
			alert('b');
			
			$.ajax(
					{
						url : "/product/json/getProduct/"+prodNo+"/${ menu }" ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {

							//Debug...
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);
							
							var displayValue = "<h3>"
											+"��ǰ��ȣ : "+JSONData.productVO.prodNo+"<br/>"
											+"��ǰ�̸� : "+JSONData.productVO.prodName+"<br/>"
											+"��ǰ������ : "+JSONData.productVO.prodDetail+"<br/>"
											+"�������� : "+JSONData.productVO.manuDate+"<br/>"
											+"���� : "+JSONData.productVO.price+"<br/>"
											+"�������� : "+JSONData.productVO.regDate+"<br/>"
											+"���� : "+JSONData.productVO.amount+"<br/>"
											+"��ǰ�ڵ� : "+JSONData.productVO.proTranCode+"<br/>"
											/* +"JSONData.uploadList.file_path : "+JSONData.uploadList[0].file_path+"<br/>" */
											+"�̹����̸� : "+JSONData.uploadList[0].fileName+"<br/>"
											+"�̹������� : "+JSONData.count+"<br/>"
											+"</h3>";
										
							//Debug...
							console.log("displayValue : " + displayValue);
							$("h3").remove();
							$( "#" + ajax_id + "" ).html(displayValue);
						}
				});
			
		}
	})
	
	//Autocomplete
	$("#searchId").bind("click",function(){
		$.ajax(
				{
					url : "/product/autocompleteProduct" ,
					method : "POST" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						$( "#searchId" ).autocomplete({
							  source: JSONData
						});
					}
				});
	});

	/*
	var page = 1;
	$(window).scroll(function() {
		var testValue = "$(document).height() - 100 : " + parseInt($(document).height() - 100) + "\n"
						+ "$(window).height() : " + parseInt($(window).height()) + "\n"
						+ "$(window).scrollTop() : " + parseInt($(window).scrollTop()) + "\n";
		console.log(testValue);
	    if ($(document).height() + 300 <= parseInt($(window).height()) + parseInt($(window).scrollTop()) ){
	    	alert("scroll �۵�");
	    	
	    	$.ajax(
	    			{
	    				url : "/product/json/listProduct" ,
	    				data : {
	    					currentpage : page
	    				},
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
						var displayValue = "<h3>"
										+"JSONData.resultPage.currentPage : "+JSONData.resultPage.currentPage+"<br/>"
										+"JSONData.resultPage.totalCount : "+JSONData.resultPage.totalCount+"<br/>"
										+"JSONData.resultPage.maxPage : "+JSONData.resultPage.maxPage+"<br/>"
										+"JSONData.resultPage.beginUnitPage : "+JSONData.resultPage.beginUnitPage+"<br/>"
										+"JSONData.resultPage.endUnitPage : "+JSONData.resultPage.endUnitPage+"<br/>"
										+"JSONData.searchVO.searchCondition : "+JSONData.searchVO.searchCondition+"<br/>"
										+"JSONData.searchVO.searchKeyword : "+JSONData.searchVO.searchKeyword+"<br/>"
										+"JSONData.searchVO.pageSize : "+JSONData.searchVO.pageSize+"<br/>"
										+"JSONData.searchVO.priceSort : "+JSONData.searchVO.priceSort+"<br/>"
										+"JSONData.list[0].prodNo : "+JSONData.list[0].prodNo+"<br/>"
										+"JSONData.listSize : "+JSONData.listSize+"<br/>"
										+"JSONData.menu : "+JSONData.menu+"<br/>"
										+"</h3>";
							alert(status);
							
							$.each(JSONData, function(index, item){
								console.log('each ����, item : ' + item);
								
								//form�� 3��° �ڽ� table�� ���δ�
								var displayValue = 
										"<tr class='ct_list_pop' id='"+item[index]+"'>"
											+"<td align='center'><img src='/images/uploadFiles/"+JSONData.uploadList[index]+"/></td>"
											+"<td></td>"
											+"<td align='left'><b class='ct_list_'>"+JSONData.list[index]+"</b></td>"
											+"<td></td>"
											+"<td align='left'>"+JSONData.list[index].price+"</td>"
											+"<td></td>"
											+"<td align='left'>"+JSONData.list[index].regDate+"</td>"
											+"<td></td>"
											+"<td align='left'>"
												+"<c:if test='${ fn:trim(list[i].proTranCode) == "+0+" }'>�Ǹ���</c:if>"
												+"<c:if test='${ fn:trim(list[i].proTranCode) == "+1+" }'>���ſϷ�<c:if test='${ menu == "+manage+" }'><b class='ct_list_'>-����ϱ�</b></c:if></c:if>"
												+"<c:if test='${ fn:trim(list[i].proTranCode) == "+2+" }'>�����</c:if>"
												+"<c:if test='${ fn:trim(list[i].proTranCode) == "+3+" }'>��ۿϷ�</c:if>"
											+"</td>"
										+"</tr>"
										+"<tr>"
											+"<td id='"+JSONData.list[index].prodName+"' colspan='11' bgcolor='D6D7D6' height='1'></td>"
										+"</tr>";
										
										console.log("displayValue : " + displayValue);
										$( $("form").children()[3] ).append(displayValue);

						})//$.each
					}//success
	    		});//end of ajax
			
				//���������� ����
				page++;
	    		
	    	}//end of if
	    });//end of scroll
	*/
	
	
		
})


function fncGetList(currentPage) {
	$("#currentPage").val(currentPage);
	$("form").submit();
}

function fncGetProductList() {
	document.detailForm.searchCondition.value = document.detailForm.searchCondition.value;
	document.forms[0].elements[2].value = document.forms[0].elements[2].value;
	$("form").submit();
}

function fncGetSortList(priceSort) {
	$("input[name='priceSort']").val(priceSort);
	$("form").submit();
}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct" method="post">
<!-- hidden name : menu, currentPage, priceSort -->
<input type="hidden" name="menu" value="${ menu }">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01"> ${ sessionScope.user.role } ${ menu }
						<c:if test="${ menu == 'manage' }">
							��ǰ����
						</c:if>
						<c:if test="${ menu != 'manage' }">
							��ǰ �����ȸ
						</c:if>					
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ (searchVO.searchCondition == '0')?"selected":"" } >��ǰ��ȣ</option>
				<option value="1" ${ (searchVO.searchCondition == '1')?"selected":"" } >��ǰ��</option>
				<option value="2" ${ (searchVO.searchCondition == '2')?"selected":"" } >��ǰ����</option>
			</select>
			<input id="searchId" type="text" name="searchKeyword" value="${ searchVO.searchKeyword }" class="ct_input_g" style="width:200px; height:19px" />
		</td>
	
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >��ü ${ resultPage.totalCount } �Ǽ�, ���� ${ resultPage.currentPage } ������
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<b id="asc">���� ���ݼ�</b>&nbsp;/&nbsp;<b id="desc">���� ���ݼ�</b>
		<input type="hidden" name="priceSort" value="${ searchVO.priceSort }">
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">image</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:set var="size" value="${ fn:length(list) }" />

	<c:if test="${ !empty sessionScope.user && sessionScope.user.role == 'admin' }">
		<c:forEach var="i" begin="0" end="${ size-1 }" step="1">
			<tr class="ct_list_pop" id="${ list[i].prodNo }">
				<td align="center">
					<img src="/images/uploadFiles/${ uploadList[i] }"/>
				</td>
				<td></td>
				<td align="left">
					<!-- �Ǹ��ڵ尡 0�� �ƴϸ� ��ǰ���� �Ұ� -->
					<b class="ct_list_">${ list[i].prodName }</b>
					<%-- <a href="/product/updateProductView/${ list[i].prodNo }/${ menu }">${ list[i].prodName }</a> --%>
				</td>				
				<td></td>
				<td align="left">${ list[i].price }</td>
				<td></td>
				<td align="left">${ list[i].regDate }</td>
				<td></td>
				<td align="left">
					<c:if test="${ fn:trim(list[i].proTranCode) == '0' }">
						�Ǹ���
					</c:if>
					<c:if test="${ fn:trim(list[i].proTranCode) == '1' }">
						���ſϷ�
						<c:if test="${ menu == 'manage' }">
							<b class="ct_list_">-����ϱ�</b>
							<%-- -<a href="/purchase/updateTranCodeByProd?prodNo=${ list[i].prodNo }&currentPage=${ resultPage.currentPage }&tranCode=2&menu=${ menu }">����ϱ�</a> --%>
						</c:if>
					</c:if>
					<c:if test="${ fn:trim(list[i].proTranCode) == '2' }">
						�����
					</c:if>
					<c:if test="${ fn:trim(list[i].proTranCode) == '3' }">
						��ۿϷ�
					</c:if>									
				</td>	
			</tr>
			<tr>
				<td id="${ list[i].prodName }" colspan="11" bgcolor="D6D7D6" height="1"></td>
			</tr>
		</c:forEach>
	</c:if>
	<!-- ȸ��, ��ȸ�� -->
	<c:if test="${ sessionScope.user.role != 'admin' }">
		<c:forEach var="i" begin="0" end="${ listSize-1 }" step="1">
			<tr class="ct_list_pop" id="${ list[i].prodNo }">
				<td align="center">${ listSize-i }</td>
				<td></td>
				<td align="left"  id="${ list[i].proTranCode }">
					<c:if test="${ fn:trim(list[i].proTranCode) == '0' }">
						<b class="ct_list_">${ list[i].prodName }</b>
						<%-- <a href="/product/getProduct/${ list[i].prodNo }/${ menu }">${ list[i].prodName }</a> --%>
					</c:if>
					<c:if test="${ fn:trim(list[i].proTranCode) != '0' }">
						${ list[i].prodName }
					</c:if>
				</td>
				
				<td></td>
				<td align="left">${ list[i].price }</td>
				<td></td>
				<td align="left">${ list[i].regDate }</td>
				<td></td>
				<td align="left">
					<c:if test="${ fn:trim(list[i].proTranCode) == '0' }">
						�Ǹ���
					</c:if>
					<c:if test="${ fn:trim(list[i].proTranCode) != '0' }">
						������
					</c:if>
				</td>	
			</tr>
			<tr>
				<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			</tr>
		</c:forEach>
	</c:if>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" name="currentPage" id="currentPage" value="0"/>
			<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>
