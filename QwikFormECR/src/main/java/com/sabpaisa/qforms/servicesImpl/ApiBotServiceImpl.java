package com.sabpaisa.qforms.servicesImpl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.dao.ApiBotDao;
import com.sabpaisa.qforms.services.ApiBotService;

@Service
public class ApiBotServiceImpl implements ApiBotService{

	@Autowired
	private ApiBotDao apiBotDao;
	
	@Override
	public ArrayList<String> getTempTableDataForSubscription(String tableName,String qcTxnId,String status) throws ParseException {
		// TODO Auto-generated method stub
		return apiBotDao.getTempTableDataForSubscription(tableName,qcTxnId,status);
	}

	@Override
	public ArrayList<String> getTempTableHeaderNames(String tableName) {
		// TODO Auto-generated method stub
		return apiBotDao.getTempTableHeaderNames(tableName);
	}

	@Override
	public List<Map<String, Object>> getTempTableDataForSubscription1(String tableName, String qcTxnId, String status)
			throws ParseException {
		// TODO Auto-generated method stub
		return apiBotDao.getTempTableDataForSubscription1(tableName, qcTxnId, status);
	}

}

