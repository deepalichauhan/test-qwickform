package com.sabpaisa.qforms.services;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface ApiBotService {

	public ArrayList<String> getTempTableDataForSubscription(String tableName,String qcTxnId,String status) throws ParseException;
	public ArrayList<String> getTempTableHeaderNames(String tableName);
	public List<Map<String, Object>> getTempTableDataForSubscription1(String tableName,String qcTxnId, String status) throws ParseException;
}

