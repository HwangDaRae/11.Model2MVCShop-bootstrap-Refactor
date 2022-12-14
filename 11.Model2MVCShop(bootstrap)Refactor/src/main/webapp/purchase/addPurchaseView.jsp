<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="EUC-KR">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
<!-- calendar.js -->
<script type="text/javascript" src="/javascript/calendar.js"></script>
<!-- import.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
	body {
		padding-top: 50px;
	}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<!-- import를 사용하기 위함 -->
<script type="text/javascript">
	function requestPayment() {
		alert('여기로 오나?');
		IMP.init("imp83557107"); // 가맹점 식별코드로 IMP 객체를 초기화한다
		IMP.request_pay({
			//pay_method : card(신용카드), trans(실시간계좌이체), vbank(가상계좌), phone(휴대폰소액결제)
			//신용카드 결제
			/*
				pg : 'danal_tpay',
				pay_method : 'card',
				merchant_uid: 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호
				name : '최초인증결제',
				amount : 100,
				customer_uid : 'your-customer-unique-id', // 필수 입력.
				buyer_email : 'iamport@siot.do',
				buyer_name : '아임포트',
				buyer_tel : '02-1234-1234'
			 */

			//카카오페이
			/*
				pg : 'kakaopay',
				pay_method : 'card',
				merchant_uid: 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호
				name : '최초인증결제',
				amount : 100,
				customer_uid : 'your-customer-unique-id', // 필수 입력.
				buyer_email : 'iamport@siot.do',
				buyer_name : '아임포트',
				buyer_tel : '02-1234-1234'
			 */

			//휴대폰결제
			/*
			    pg : 'html5_inicis',
			    pay_method : 'phone',
			    merchant_uid: 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
			    name : '주문명:결제테스트',
			    amount : 100,
			    buyer_email : 'iamport@siot.do',
			    buyer_name : '구매자이름',
			    buyer_tel : '010-1234-5678',
			    buyer_addr : '서울특별시 강남구 삼성동',
			    buyer_postcode : '123-456',
			    m_redirect_url : '{모바일에서 결제 완료 후 리디렉션 될 URL}' // 예: https://www.my-service.com/payments/complete/mobile
			 */

			//무통장 입금
			///*
			pg : 'html5_inicis',
			pay_method : 'vbank',
			merchant_uid : 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
			name : '주문명:결제테스트',
			amount : 100,
			buyer_email : 'itzrb577@naver.com',
			buyer_name : '황다래',
			buyer_tel : '010-8325-6825',
			//buyer_addr : '서울특별시 강남구 삼성동',
			//buyer_postcode : '123-456',
			//m_redirect_url : '{모바일에서 결제 완료 후 리디렉션 될 URL}', // 예: https://www.my-service.com/payments/complete/mobile
			//notice_url : 'http://192.168.0.74:8080/purchase/json/complete', //웹훅수신 URL 설
		//*/

		//토스페이
		/*
		    pg : 'tosspay',
		    pay_method : 'card',
		    merchant_uid: 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
		    name : '주문명:결제테스트',
		    amount : 100,
		    buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456',
		    m_redirect_url : '{모바일에서 결제 완료 후 리디렉션 될 URL}' // 예: https://www.my-service.com/payments/complete/mobile	
		 */

		//실시간 계좌이체
		/*
		    pg : 'html5_inicis',
		    pay_method : 'trans',
		    merchant_uid: 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호를 전달
		    name : '주문명:결제테스트',
		    amount : 100,
		    buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456',
		    m_redirect_url : '{모바일에서 결제 완료 후 리디렉션 될 URL}' // 예: https://www.my-service.com/payments/complete/mobile
		 */

		}, function(rsp) { // callback
			if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
				// jQuery로 HTTP 요청
    			//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
				jQuery.ajax({
					url : "/purchase/json/complete", // 예: https://www.myservice.com/payments/complete
					method : "POST",
					dataType : "json",
					headers : {
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						imp_uid : rsp.imp_uid,
						merchant_uid : rsp.merchant_uid,
						status : rsp.status
					})
				}).done(function(data) {
					// 가맹점 서버 결제 API 성공시 로직
					//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
					if (everythings_fine) {
		    			var msg = '결제가 완료되었습니다.';
		    			msg += '\n고유ID : ' + rsp.imp_uid;
		    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		    			msg += '\결제 금액 : ' + rsp.paid_amount;
		    			msg += '카드 승인번호 : ' + rsp.apply_num;

						alert(msg);
					} else {
						//[3] 아직 제대로 결제가 되지 않았습니다.
						//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
					}
				});
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
	}
</script>

<script type="text/javascript">
	$(function() {
		var productAmount = $("#productAmount").val();
		var number = $("#result").text();

		$("input[value='-']").bind("click", function() {
			number--;
			if (parseInt(number) == 0) {
				number = 1;
			} else {
				$("#limit").text(" ");
			}
			$("#amount").val(number);
			$("#result").text(number);
		})

		$("input[value='+']").bind("click", function() {
			if (parseInt(number) < parseInt(productAmount)) {
				number++;
			} else if (parseInt(number) == parseInt(productAmount)) {
				$("#limit").text("더이상 구매하실 수 없습니다");
				return;
			}
			$("#amount").val(number);
			$("#result").text(number);
		})

		$("button:contains('구매완료')").bind("click", function() {
			//$("form").attr("method","post").attr("action","/purchase/addPurchase").submit();
			//import로 구매하기
			alert('구매완료 클릭');
			requestPayment();
		});

		$("button:contains('이전')").bind("click", function() {
			history.back();
		});

		//제조일자를 캘린더 날짜 클릭해서 등록
		$("#show_calendar").bind(
				"click",
				function() {
					show_calendar('document.detailForm.divyDate',
							document.detailForm.divyDate.value);
				})
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

			<div class="form-horizontal">

				<div class="page-header">
					<h3 class=" text-info">배송정보기입</h3>
				</div>

				<div class="form-group">
					<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodNo" name="prodNo"
							value="${ productVO.prodNo }" placeholder="상품번호" readonly>
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodName"
							name="prodName" value="${ productVO.prodName }" placeholder="상품명"
							readonly>
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="prodDetail"
							name="prodDetail" value="${ productVO.prodDetail }"
							placeholder="상품상세정보" readonly>
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="manuDate"
							name="manuDate" value="${ productVO.manuDate }"
							placeholder="제조일자" readonly>
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="price" name="price"
							value="${ productVO.price }" placeholder="가격" readonly>
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="userId" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="regDate"
							name="regDate" value="${ productVO.regDate }" placeholder="등록일자"
							readonly>
					</div>
				</div>

				<hr />

			</div>

		</div>
		<div class="container">

			<div class="form-horizontal">

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
					<div class="col-sm-2">
						<select class="form-control" name="paymentOption"
							id="paymentOption">
							<option value="1"
								${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  }>현금구매</option>
							<option value="2"
								${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  }>신용구매</option>
						</select>
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName"
							name="receiverName" placeholder="구매자이름">
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone"
							name="receiverPhone" placeholder="구매자연락처">
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyAddr"
							name="divyAddr" placeholder="구매자주소">
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyRequest"
							name="divyRequest" placeholder="구매요청사항">
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyDate"
							name="divyDate"> <img src="../images/ct_icon_date.gif"
							width="15" height="15" id="show_calendar" />
					</div>
				</div>

				<hr />

				<div class="form-group">
					<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
					<div class="col-sm-4">
						<input type="button" value="-"> <b id="result">${ amount }</b>
						<input type="hidden" id="amount" name="amount" value="${ amount }">
						<input type="hidden" id="productAmount" name="productAmount"
							value="${ productVO.amount }"> <input type="hidden"
							name="prod_no" value="${ productVO.prodNo }"> <input
							type="button" value="+"> <b id="limit"></b>
					</div>
				</div>

				<hr />

				<div class="row">
					<div class="col-md-12 text-center ">
						<button type="button" class="btn btn-primary">구매완료</button>
						<button type="button" class="btn btn-primary">이전</button>
					</div>
				</div>

				<br />

			</div>

		</div>
		<!--  화면구성 div Start /////////////////////////////////////-->
	</form>

</body>

</html>