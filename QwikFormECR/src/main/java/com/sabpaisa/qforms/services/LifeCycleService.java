package com.sabpaisa.qforms.services;

import java.sql.SQLException;
import java.util.ArrayList;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.FormActionsBean;
import com.sabpaisa.qforms.beans.FormLifeCycleBean;
import com.sabpaisa.qforms.beans.FormStateBean;
import com.sabpaisa.qforms.beans.FormStateHistoryBean;

public interface LifeCycleService {
	public ArrayList<BeanFieldLookup> getFieldLookups();
	public ArrayList<FormActionsBean> getFormActions();
	public FormActionsBean getFormAction(String action_name);
	public FormLifeCycleBean getFormCycle(Integer stageNo,Integer formId);
	public FormStateBean getLatestState(Integer formInstanceId);
	public FormStateBean getFormState(Integer stateId);
	public FormStateBean saveFormState(FormStateBean saveData);
	public FormStateHistoryBean archiveFormState(FormStateHistoryBean saveData);
	public Boolean checkTableExit(String tempTableName)throws SQLException;
}
