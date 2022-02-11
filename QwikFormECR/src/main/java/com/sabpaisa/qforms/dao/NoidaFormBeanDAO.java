package com.sabpaisa.qforms.dao;

import java.util.ArrayList;

import com.sabpaisa.qforms.beans.NoidaFormBean;

public interface NoidaFormBeanDAO {

	public ArrayList<NoidaFormBean> getDetailsOfDataSumaryAnd(Integer clientId);
}
