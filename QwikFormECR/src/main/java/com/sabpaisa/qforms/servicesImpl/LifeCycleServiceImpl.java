package com.sabpaisa.qforms.servicesImpl;

import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.FormActionsBean;
import com.sabpaisa.qforms.beans.FormLifeCycleBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.FormStateHistoryBean;
import com.sabpaisa.qforms.dao.LifeCycleDAO;
import com.sabpaisa.qforms.services.LifeCycleService;

@Service
public class LifeCycleServiceImpl implements LifeCycleService {

	@Autowired
	LifeCycleDAO lifeCycleDAO;
	
	@Override
	public ArrayList<BeanFieldLookup> getFieldLookups() {
		
		return lifeCycleDAO.getFieldLookups();
	}

	@Override
	public ArrayList<FormActionsBean> getFormActions() {
		
		return lifeCycleDAO.getFormActions();
	}

	@Override
	public FormActionsBean getFormAction(String action_name) {
		
		return lifeCycleDAO.getFormAction(action_name);
	}

	@Override
	public FormLifeCycleBean getFormCycle(Integer stageNo, Integer formId) {

		return lifeCycleDAO.getFormCycle(stageNo, formId);
	}

	@Override
	public FormStateBean getLatestState(Integer formInstanceId) {

		return lifeCycleDAO.getLatestState(formInstanceId);
	}

	@Override
	public FormStateBean getFormState(Integer stateId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FormStateBean saveFormState(FormStateBean saveData) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FormStateHistoryBean archiveFormState(FormStateHistoryBean saveData) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean checkTableExit(String tempTableName) throws SQLException {
		// TODO Auto-generated method stub
		return lifeCycleDAO.checkTableExit(tempTableName);
	}

}
