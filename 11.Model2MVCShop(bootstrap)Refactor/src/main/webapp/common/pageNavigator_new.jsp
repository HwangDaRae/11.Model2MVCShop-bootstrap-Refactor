<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<div class="container text-center">
		 
		 <nav>
		  <!-- 크기조절 :  pagination-lg pagination-sm-->
		  <ul class="pagination" >
		    
		    <!--  <<== 좌측 nav -->
		  	<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		 		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li>
			</c:if>
		      <a href="javascript:fncGetUserList('${ resultPage.beginUnitPage - resultPage.pageUnit }')" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    
		    <!--  중앙  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				
				<c:if test="${ resultPage.currentPage == i }">
					<!--  현재 page 가르킬경우 : active -->
				    <li class="active">
				    	<a href="javascript:fncGetUserList('${ i }');">${ i }<span class="sr-only">(current)</span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage != i}">	
					<li>
						<a href="javascript:fncGetUserList('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  우측 nav==>> -->
		     <c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		  		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
		      <a href="javascript:fncGetUserList('${ resultPage.endUnitPage + 1 }')" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		
</div>
 


<div class="container">
	<nav>
		<ul class="pager">
			<c:if test="${ resultPage.currentPage <= 1 }">
		 		<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > 1 }">
		 		<li>
			</c:if>
			<a href="javascript:fncGetUserList('${ resultPage.currentPage-1}')" aria-label="Previous"><span aria-hidden="true">Previous</span></a></li>
		    
			<b></b>
			
			<c:if test="${ resultPage.currentPage >= resultPage.maxPage }">
				<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage < resultPage.maxPage }">
				<li>
			</c:if>
			<a href="javascript:fncGetUserList('${resultPage.currentPage + 1}')">Next</a></li>
			
		</ul>
	</nav>
</div>


<div class="container">
	<nav>
		<ul class="pager"> 
			<c:if test="${ resultPage.beginUnitPage <= 1 }">
				<li class="previous disabled">
			</c:if>
			<c:if test="${ resultPage.beginUnitPage > 1 }">
				<li class="previous">
			</c:if>
			<a href="javascript:fncGetUserList('${ resultPage.beginUnitPage-resultPage.pageUnit}')" aria-label="Previous">Older</a></li>
			   
			<b></b>
			
			<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
				<li class="next disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li class="next">
			</c:if>
			<a href="javascript:fncGetUserList('${resultPage.endUnitPage + 1}')">Newer</a></li>
			
		</ul>
	</nav>
</div>