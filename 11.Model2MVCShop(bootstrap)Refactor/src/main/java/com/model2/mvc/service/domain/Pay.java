package com.model2.mvc.service.domain;

public class Pay {
	
	private String imp_uid;				// ��������_Ư���ϴ�_������Ʈ_��ȣ
	private String merchant_uid;		// ������_����_�ֹ���ȣ
	private String status;				// ready : ������¹߱�, paid : �����Ϸ�, success : �Ϲݰ�������, vbankIssued : ������¹߱޼���, forgery : �����Ȱ����õ�
	private String imp_success;			// ���� ���� ����
	private String error_code;			// ����_�ڵ�
	private String error_msg;			// ����_�޽���
	private String paymethod;			// �����޼ҵ�
	private String pg;					// pg��
	private String payOption;			// �������
	private String totalPrice;			// �� �����ݾ�
	
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
