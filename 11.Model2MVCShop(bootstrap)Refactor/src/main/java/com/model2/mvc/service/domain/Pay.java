package com.model2.mvc.service.domain;

public class Pay {
	
	private String imp_uid;				// 결제건을_특정하는_아임포트_번호
	private String merchant_uid;		// 가맹점_고유_주문번호
	private String status;				// ready : 가상계좌발급, paid : 결제완료, success : 일반결제성공, vbankIssued : 가상계좌발급성공, forgery : 위조된결제시도
	private String imp_success;			// 결제 성공 여부
	private String error_code;			// 에러_코드
	private String error_msg;			// 에러_메시지
	private String paymethod;			// 결제메소드
	private String pg;					// pg사
	private String payOption;			// 결제방식
	private String totalPrice;			// 총 결제금액
	
	public Pay() {
	}

	public Pay(String imp_uid, String merchant_uid) {
		this.imp_uid = imp_uid;
		this.merchant_uid = merchant_uid;
	}

	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}

	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImp_success() {
		return imp_success;
	}

	public void setImp_success(String imp_success) {
		this.imp_success = imp_success;
	}

	public String getError_code() {
		return error_code;
	}

	public void setError_code(String error_code) {
		this.error_code = error_code;
	}

	public String getError_msg() {
		return error_msg;
	}

	public void setError_msg(String error_msg) {
		this.error_msg = error_msg;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public String getPg() {
		return pg;
	}

	public void setPg(String pg) {
		this.pg = pg;
	}

	public String getPayOption() {
		return payOption;
	}

	public void setPayOption(String payOption) {
		this.payOption = payOption;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Pay [imp_uid=");
		builder.append(imp_uid);
		builder.append(", merchant_uid=");
		builder.append(merchant_uid);
		builder.append(", status=");
		builder.append(status);
		builder.append(", imp_success=");
		builder.append(imp_success);
		builder.append(", error_code=");
		builder.append(error_code);
		builder.append(", error_msg=");
		builder.append(error_msg);
		builder.append(", paymethod=");
		builder.append(paymethod);
		builder.append(", pg=");
		builder.append(pg);
		builder.append(", payOption=");
		builder.append(payOption);
		builder.append(", totalPrice=");
		builder.append(totalPrice);
		builder.append("]");
		return builder.toString();
	}

}
