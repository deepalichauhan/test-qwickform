package com.sabpaisa.qforms.servicesImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.FeedbackBean;
import com.sabpaisa.qforms.dao.FeedbackDetailsDao;
import com.sabpaisa.qforms.services.FeedbackDetailsService;

@Service
public class FeedbackDetailsServiceImpl implements FeedbackDetailsService{

	@Autowired
	FeedbackDetailsDao feedbackDetailsDao;
	
	@Override
	public void saveFeedbackDetailsDao(FeedbackBean feedbackBean) {
		feedbackDetailsDao.saveFeedbackDetailsDao(feedbackBean);
		
	}

}
