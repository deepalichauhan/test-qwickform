package com.sabpaisa.qforms.services;

import com.sabpaisa.qforms.exception.BusinessException;

public interface RefundApiService {
	
	public String refundApiRequest(Integer clientId, String txnId, String spTxnId,
			String transAmount, String transPaymode, String transStatus, String message) throws BusinessException;

}
