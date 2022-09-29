package com.model2.mvc.service.domain;

public class Pay {
	
	private String imp_uid;
	private String merchant_uid;
	
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

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Pay [imp_uid=");
		builder.append(imp_uid);
		builder.append(", merchant_uid=");
		builder.append(merchant_uid);
		builder.append("]");
		return builder.toString();
	}

}
