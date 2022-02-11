package com.sabpaisa.qforms.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sabpaisa.qforms.exception.BusinessException;
import com.sabpaisa.qforms.services.RefundApiService;
import com.sabpaisa.qforms.util.RefundCodeConstant;

@CrossOrigin
@Controller
@RequestMapping
public class RefundApiController {
	@Autowired
	private RefundApiService refundApiService;
	
	private static Logger log = LogManager.getLogger(RefundApiController.class.getName());
	
	@RequestMapping(value = "/refundApiFromReports", method = RequestMethod.GET)
	public @ResponseBody String  refundApiRequest(@RequestParam(required = true) String txnId,
			@RequestParam(required=true) String spTxnId, 
			@RequestParam(required=true) String transAmount, 
			@RequestParam(required=true) String transPaymode, 
			@RequestParam(required=true) String transStatus,
			@RequestParam(required=true) String clientId,
			@RequestParam(required=true) String message) throws BusinessException {
		log.info("Start of refundApiRequest(), info txnId >> " + txnId +
				", spTxnId >>  "+spTxnId+", transAmount >>  "+transAmount+
				", clientId >> "+clientId+", message "+message);
		String response="";
		String status="";
		Integer cid =null;
		try {
			/*if(null != clientId.toString() || "" !=clientId.toString()) {
				cid = Integer.getInteger(clientId);				
			}*/
			cid=Integer.parseInt(clientId);
			log.info("cid is >> "+cid);
			response= refundApiService.refundApiRequest(cid,txnId, spTxnId, transAmount, transPaymode, transStatus,message);
			log.info("refundApiService update Response is >> "+response);
			
		}  catch (BusinessException e) {			
			//e.printStackTrace();
			return "{\"status\":\"" + RefundCodeConstant.FAILURE + "\", \"response\": \"" + e.getMessage() + "\"}";
			//throw new BusinessException(CodeConstant.CLIENT_NOT_FOUND);
		}
		if(response.equalsIgnoreCase(RefundCodeConstant.REFUND_FAIL)){
			return "{\"status\":\"" + RefundCodeConstant.FAILURE + "\", \"response\": \"" + response + "\"}";	
		}else{
		return "{\"status\":\"" + RefundCodeConstant.SUCCESS + "\", \"response\": \"" + response + "\"}";
		}
	
	}

}
