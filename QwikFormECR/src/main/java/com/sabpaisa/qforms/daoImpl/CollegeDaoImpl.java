package com.sabpaisa.qforms.daoImpl;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import javax.validation.ConstraintViolationException;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BankDetailsBean;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.ClientMappingCodeOfSabPaisa;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.CompanyBean;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.beans.PayeerTargetMappingToClient;
import com.sabpaisa.qforms.beans.ServicesBean;
import com.sabpaisa.qforms.beans.StateBean;
import com.sabpaisa.qforms.beans.SubInstitute;
import com.sabpaisa.qforms.beans.SuperAdminBean;
import com.sabpaisa.qforms.beans.WhiteLableTempBean;
import com.sabpaisa.qforms.dao.CollegeDao;

@Repository
public class CollegeDaoImpl implements CollegeDao{

	@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("CollegeDaoImpl.class");
	
	@Override
    public CollegeBean viewInstDetail(Integer collegeId) {
		log.info("Start of viewInstDetail() method in CollgeDaoImpl");

		//log.info((Object)"before creating session: >>>>>>>>>>>>>"+collegeId.toString());
        Session session = factory.openSession();
        
        //log.info((Object)"after creating session");
        CollegeBean cBean=new CollegeBean();
		try {
			cBean = (CollegeBean)session.get(CollegeBean.class, (Serializable)collegeId);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
        //log.info((Object)"after fetching bean");
        
        session.close();
        log.info((Object)("End of this method after closing session value in cBean is:" + cBean.getCollegeCode() + cBean.getCollegeName()));
        return cBean;
    }

	@Override
    public String EditBankDetails(BankDetailsBean bankDetailsBean) {
        String valid;
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        BankDetailsBean bean = new BankDetailsBean();
        log.info((Object)("id val:" + bankDetailsBean.getBankId()));
        valid = "true";
        try {
            try {
                bean = (BankDetailsBean)session.get(BankDetailsBean.class, (Serializable)bankDetailsBean.getBankId());
                log.info(("Bank Id :" + bean.getBankId()));
                bean.setBankname(bankDetailsBean.getBankname());
                bean.setEmailId(bankDetailsBean.getEmailId());
                bean.setContactNumber(bankDetailsBean.getContactNumber());
                bean.setBankLink(bankDetailsBean.getBankLink());
                ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
                Validator validator = factory1.getValidator();
                validator.validate(bean, new Class[0]);
                session.merge(bean);
                tx.commit();
            }
            catch (ConstraintViolationException e) {
                e.printStackTrace();
                valid = "false";
            }
            catch (Exception ex) {
                ex.printStackTrace();
                session.close();
            }
        }
        finally {
            session.close();
        }
        return valid;
    }

	@Override
    public List<CollegeBean> getCollegeListOfBank() {
        Session session = factory.openSession();
        List collList = session.createCriteria(CollegeBean.class).setProjection((Projection)Projections.property((String)"collegeName")).list();
        log.info((Object)("size of the college is:" + collList.size()));
        session.close();
        return collList;
    }

	@Override
    public List<BankDetailsBean> getAllBankDetails(SuperAdminBean saBean) {
        Session session = factory.openSession();
        int id = saBean.getCompanyBean().getId();
        try {
            List<BankDetailsBean> bankList = session.createCriteria(BankDetailsBean.class).add((Criterion)Restrictions.eq((String)"companyBean.id", (Object)id)).list();
            log.info((Object)("size of the Bank is:" + bankList.size()));
            List<BankDetailsBean> list = bankList;
            return list;
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<CollegeBean> getAllClientDetails(SuperAdminBean sABean) {
		
		log.info("Start of getAllClientDetails() method in CollegeDaoImpl");
        Session session = factory.openSession();
        List<CollegeBean> collList = null;
        int id = sABean.getCompanyBean().getId();
        
        log.info((Object)("Super Admin ID ==>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + id));
        
        try {
           collList = session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"companyBean.id", (Object)id)).list();
           log.info("collList size is in this method :>>>>>>>>>>>>>> "+collList.size());
            return collList;
        }
        catch (NullPointerException ex) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)ex);
            return null;
        }
        catch (Exception e) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)e);
            return null;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<CollegeBean> getCollegeListOfBank(int bid) {
    	log.info("called getCollegeList "+bid);
        Session session = factory.openSession();
        List<CollegeBean> collegelist = new ArrayList<CollegeBean>();
        try {
            if (bid == 0) {
                collegelist = session.createCriteria(CollegeBean.class).list();
            } else {
            	log.info("else condition "+bid);
                BankDetailsBean bankDetailsBean = (BankDetailsBean)session.get(BankDetailsBean.class, (Serializable)Integer.valueOf(bid));
                log.info("bank detail bean is "+bankDetailsBean.getBankname() + "  "+bankDetailsBean.getListOfColleges().size());
                collegelist =(bankDetailsBean.getListOfColleges());
                log.info("college list is "+collegelist.size());
            }
            List<CollegeBean> arrayList = collegelist;
            return arrayList;
        }
        catch (NullPointerException ex) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)ex);
            return null;
        }
        catch (Exception e) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)e);
            return null;
        }
        finally {
            session.close();
        }
    }

	@Override
    public List<CollegeBean> getCollegeListOfBankForSabPaisa() {
        Session session = factory.openSession();
        ArrayList<CollegeBean> collegelist = new ArrayList();
        try {
            ArrayList<CollegeBean> arrayList = collegelist = (ArrayList<CollegeBean>) session.createCriteria(CollegeBean.class).list();
            return arrayList;
        }
        catch (NullPointerException ex) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)ex);
            return null;
        }
        catch (Exception e) {
            log.error((Object)"Exception in Getting College List ::", (Throwable)e);
            return null;
        }
        finally {
            session.close();
        }
    }

	@Override
    @SuppressWarnings("unchecked")
	public List<CollegeBean> getCollegeDetailsBasedOnCode(String collegeCode) {
        ArrayList<CollegeBean> CollegeBeanDetailsBean;
        Session session = factory.openSession();
        CollegeBeanDetailsBean = new ArrayList();
        try {
            try {
                CollegeBeanDetailsBean = (ArrayList<CollegeBean>) session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"collegeCode", (Object)collegeCode)).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return CollegeBeanDetailsBean;
    }

	@Override
	public CollegeBean getCollegeDetailsOnCode(String collegeCode) {
        ArrayList<CollegeBean> CollegeBeanDetailsBean = new ArrayList<CollegeBean>();
        Session session = factory.openSession();
        CollegeBean detailsBean=new CollegeBean(); 
        try {
            try {
                CollegeBeanDetailsBean = (ArrayList<CollegeBean>) session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"collegeCode", (Object)collegeCode)).list();
                detailsBean=CollegeBeanDetailsBean.get(0);
                if(null!=detailsBean) {
                	log.info("College bean as per given college code by SabPaisa : ========> "+detailsBean);
                }
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return detailsBean;
    }
	
	@Override
    public  List<CollegeBean> getCollegeDetailsBasedOnStateId(Integer stateId, Integer bankId, Integer serviceId) {
        ArrayList<CollegeBean> CollegeBeanDetailsBean;
        Session session = factory.openSession();
        CollegeBeanDetailsBean = new ArrayList();
        try {
            try {
                CollegeBeanDetailsBean = (ArrayList<CollegeBean>) session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"stateBean.stateId", (Object)stateId)).add((Criterion)Restrictions.eq((String)"serviceBean.serviceId", (Object)serviceId)).add((Criterion)Restrictions.eq((String)"bankDetailsOTM.bankId", (Object)bankId)).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return CollegeBeanDetailsBean;
    }

	@Override
    public  List<CollegeBean> getCollegeDetailsBasedOnStateIdForSabPaisa(Integer stateId) {
        ArrayList<CollegeBean> CollegeBeanDetailsBean;
        Session session = factory.openSession();
        CollegeBeanDetailsBean = new ArrayList();
        try {
            try {
                CollegeBeanDetailsBean = (ArrayList<CollegeBean>) session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"stateBean.stateId", (Object)stateId)).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return CollegeBeanDetailsBean;
    }

	@Override
    public  List<BeanFormDetails> getBeanFormDetailsOfParticularClient(Integer collegeId, String collegeName) {
        List savedFormList;
        Session session = factory.openSession();
        savedFormList = new ArrayList();
        log.info((Object)("College Id ::" + collegeId));
        try {
            Criteria criteria = session.createCriteria(BeanFormDetails.class);
            criteria.add((Criterion)Restrictions.eq((String)"formOwnerId", (Object)collegeId));
            criteria.add((Criterion)Restrictions.in((String)"status", "APPROVED","REPORT"));
            savedFormList = criteria.list();
            log.info((Object)("Approved Form List is ::" + savedFormList.size()));
        }
        finally {
            session.close();
        }
        return savedFormList;
    }

	@Override
    public  List<BeanFormDetails> getBeanFormDetailsOfParticularClientForLC(Integer collegeId, String collegeName) {
        List savedFormList;
        Session session = factory.openSession();
        savedFormList = new ArrayList();
        log.info((Object)("College Id ::" + collegeId));
        try {
            Criteria criteria = session.createCriteria(BeanFormDetails.class);
            criteria.add((Criterion)Restrictions.eq((String)"formOwnerId", (Object)collegeId));
            criteria.add((Criterion)Restrictions.eq((String)"status", (Object)"PENDING CONFIG"));
            savedFormList = criteria.list();
            log.info((Object)("Approved Form List is ::" + savedFormList.size()));
        }
        finally {
            session.close();
        }
        return savedFormList;
    }

	@Override
    public  SubInstitute getSubInstituteDetailsOfCollegeBasedOnCode(String code, String cid) {
        SubInstitute subInstitute;
        Session session = factory.openSession();
        subInstitute = new SubInstitute();
        try {
            try {
                subInstitute = (SubInstitute)session.createCriteria(SubInstitute.class).add((Criterion)Restrictions.eq((String)"instituteCode", (Object)code)).list().iterator().next();
            }
            catch (Exception ex) {
                SubInstitute subInstitute2 = subInstitute;
                session.close();
                return subInstitute2;
            }
        }
        finally {
            session.close();
        }
        return subInstitute;
    }

	@Override
    public  SubInstitute getSubInstituteDetailsOfCollegeBasedOnID(Integer id) {
        Session session = factory.openSession();
        SubInstitute subInstitute = new SubInstitute();
        try {
            SubInstitute subInstitute2 = subInstitute = (SubInstitute)session.createCriteria(SubInstitute.class).add((Criterion)Restrictions.eq((String)"instituteId", (Object)id)).list().iterator().next();
            return subInstitute2;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            SubInstitute subInstitute3 = subInstitute;
            return subInstitute3;
        }
        finally {
            session.close();
        }
    }

	@Override
    @SuppressWarnings("unchecked")
	public  List<SubInstitute> getSubInstituteList(String code, String cid) {
        Session session = factory.openSession();
        List instList = new ArrayList<SubInstitute>();
        SubInstitute subInstitute = new SubInstitute();
        try {
            Criteria cr = session.createCriteria(SubInstitute.class);
            cr.add((Criterion)Restrictions.eq((String)"instituteCode", (Object)code));
            cr.add((Criterion)Restrictions.eq((String)"parentInstituteCode", (Object)cid));
            List list = instList = cr.list();
            return list;
        }
        catch (Exception ex) {
            ArrayList<SubInstitute> arrayList = (ArrayList<SubInstitute>) instList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public  CollegeBean getInstDetailUsingCidAndBid(String bidString, String cidString) {
        Session session = factory.openSession();
        CollegeBean fcolBean = new CollegeBean();
        BankDetailsBean bankDetailsBean = (BankDetailsBean)session.get(BankDetailsBean.class, (Serializable)Integer.valueOf(Integer.parseInt(bidString)));
        for (CollegeBean colBean : bankDetailsBean.getListOfColleges()) {
            if (colBean.getCollegeId() != Integer.parseInt(cidString)) continue;
            fcolBean = colBean;
        }
        session.close();
        return fcolBean;
    }

	@Override
    public List<BeanPayerType> getBeanPayerListDetails(CollegeBean collegeBean) {
        List payerDropDownList = new ArrayList<BeanPayerType>();
        Session session = factory.openSession();
        try {
            List list = payerDropDownList = session.createCriteria(BeanPayerType.class).add((Criterion)Restrictions.eq((String)"cid", (Object)collegeBean.getCollegeId().toString())).add((Criterion)Restrictions.eq((String)"clientName", (Object)collegeBean.getCollegeName())).add((Criterion)Restrictions.eq((String)"bid", (Object)collegeBean.getBankDetailsOTM().getBankId().toString())).list();
            return list;
        }
        catch (NullPointerException ex) {
            ArrayList<BeanPayerType> arrayList = (ArrayList<BeanPayerType>) payerDropDownList;
            return arrayList;
        }
        finally {
            session.close();
        }
    }

	@Override
    public CollegeBean viewCollegeDetail(int loginId) {
		log.info("Open viewCollegeDetail() method is in CollegeDaoImpl");
        CollegeBean bean;
        Session session = factory.openSession();
        log.info("after creating session");
        bean = null;
        try {
            try {
                bean = (CollegeBean)session.get(CollegeBean.class, (Serializable)Integer.valueOf(loginId));
                log.info((Object)"after fetching bean");
            }
            catch (NullPointerException ex) {
                ex.printStackTrace();
                session.close();
                
            }
        }
        finally {
            session.close();
        }
        log.info("Close viewCollegeDetail() method is in CollegeDaoImpl");
        return bean;
    }

	@Override
	public CollegeBean viewCollegeDetail(String idForQC) {
    	log.info("id for qc while fetching college detail "+idForQC);
        CollegeBean bean;
        Session session = factory.openSession();
        log.info((Object)"after creating session");
        bean = null;
        try {
            try {
                bean = (CollegeBean)session.get(CollegeBean.class, (Serializable)idForQC);
                log.info((Object)"after fetching bean "+bean.getCollegeCode());
            }
            catch (NullPointerException ex) {
                ex.printStackTrace();
                session.close();
            }
        }
        finally {
            session.close();
        }
        return bean;
    }

	@Override
    public CollegeBean validateCollegeAndBank(Integer cid, Integer bid) {
		log.info("Satrt of validateCollegeAndBank() method in CollegeDaoImpl");
        CollegeBean collegeBean;
        Session session = factory.openSession();
        ArrayList list = new ArrayList();
        collegeBean = new CollegeBean();
        try {
            Criteria criteria = session.createCriteria(CollegeBean.class);
            criteria.add((Criterion)Restrictions.eq((String)"collegeId", (Object)cid));
            criteria.add((Criterion)Restrictions.eq((String)"bankDetailsOTM.bankId", (Object)bid));
            collegeBean = (CollegeBean)criteria.list().iterator().next();
        }
        finally {
            session.close();
        }
        return collegeBean;
    }

	@Override
    public  PayeerTargetMappingToClient getClientMappingDetails(String bid, String cid, String payeeProfile) {
        Session session = factory.openSession();
        PayeerTargetMappingToClient clientMappingData = new PayeerTargetMappingToClient();
        try {
            clientMappingData = (PayeerTargetMappingToClient)session.createCriteria(PayeerTargetMappingToClient.class).add((Criterion)Restrictions.eq((String)"bid", (Object)bid)).add((Criterion)Restrictions.eq((String)"cid", (Object)cid)).add((Criterion)Restrictions.eq((String)"profileType", (Object)payeeProfile)).list().iterator().next();
        }
        catch (Exception ex) {
            return clientMappingData;
        }finally {
        session.close();
        }
        return clientMappingData;
    }

	@Override
    public  PayeerTargetMappingToClient getClientMappingDetailsBasedOnPayee(String sbClientCode, String payeeProfile) {
        Session session = factory.openSession();
        PayeerTargetMappingToClient clientMappingData = new PayeerTargetMappingToClient();
        try {
            clientMappingData = (PayeerTargetMappingToClient)session.createCriteria(PayeerTargetMappingToClient.class).add((Criterion)Restrictions.eq((String)"clientCode", (Object)sbClientCode)).add((Criterion)Restrictions.eq((String)"profileType", (Object)payeeProfile)).list().iterator().next();
        }
        catch (Exception ex) {
            return clientMappingData;
        }finally {
        session.close();
        }
        return clientMappingData;
    }

	@Override
    public  ClientMappingCodeOfSabPaisa getClientMappingCode(String bid, String cid, String payeeProfile) {
		log.info("Open getClientMappingCode() method and bid : "+bid+" : cid : "+cid+" : payeeProfile : "+payeeProfile);
        Session session = factory.openSession();
        ClientMappingCodeOfSabPaisa clientMappingCode = new ClientMappingCodeOfSabPaisa();
        try {
            clientMappingCode = (ClientMappingCodeOfSabPaisa)session.createCriteria(ClientMappingCodeOfSabPaisa.class).add((Criterion)Restrictions.eq((String)"bid", (Object)bid)).add((Criterion)Restrictions.eq((String)"cid", (Object)cid)).add((Criterion)Restrictions.eq((String)"cMProfile", (Object)payeeProfile)).list().iterator().next();
        }
        catch (Exception ex) {
            return clientMappingCode;
        }finally {
        session.close();
        }
        log.info("End getClientMappingCode() method");
        return clientMappingCode;
    }

	@Override
    public  List<BankDetailsBean> getBankDetails(SuperAdminBean sABean) {
        int id = sABean.getCompanyBean().getId();
        Session session = factory.openSession();
        List bankDetailsBeans = new ArrayList<BankDetailsBean>();
        try {
            bankDetailsBeans = session.createCriteria(BankDetailsBean.class).add((Criterion)Restrictions.eq((String)"companyBean.id", (Object)id)).list();
        }
        catch (NullPointerException ex) {
            return bankDetailsBeans;
        }finally {
        session.close();
        }
        return bankDetailsBeans;
    }
	
	

	@Override
    public BankDetailsBean getBankDetailsBasedOnId(String bankId) {
		log.info("Start getBankDetailsBasedOnId() method in CollegeDaoImpl");
		
        BankDetailsBean bean;
        Session session = factory.openSession();
        bean = new BankDetailsBean();
        
        log.info("bankId :" + bankId);
        
        try {
            try {
                bean = (BankDetailsBean)session.createCriteria(BankDetailsBean.class).add((Criterion)Restrictions.eq("bankId", Integer.parseInt(bankId))).list().get(0);
                //log.info("value of BankDetailsBean is ::::::::::::::::: "+bean.toString());
            }
            catch (NullPointerException ex) {
                BankDetailsBean bankDetailsBean = bean;
                session.close();
                return bankDetailsBean;
            }
        }
        finally {
            session.close();
        }
        log.info("End getBankDetailsBasedOnId() method in CollegeDaoImpl");
        return bean;
    }
	
	@Override
	 public CollegeBean saveAndUpdateClientDetails(CollegeBean collegeBean) {
		 log.info("Start registerClientDetailsDao1() method in CollegeDaoImpl");
	        Session session = factory.openSession();
	        Transaction tx = session.beginTransaction();
	        try {
	            try {
	                ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
	                Validator validator = factory1.getValidator();
	                validator.validate(collegeBean, new Class[0]);
	                session.saveOrUpdate(collegeBean);
	                tx.commit();
	            }
	            catch (ConstraintViolationException e) {
	                e.printStackTrace();
	                session.close();
	                return null;
	            }
	            catch (Exception e) {
	                e.printStackTrace();
	                CollegeBean collegeBean2 = collegeBean;
	                session.close();
	                return collegeBean2;
	            }
	        }
	        finally {
	            session.close();
	        }
	        log.info("New CollegeBean for Sabpaisa 2.0 : >>>>> "+collegeBean);
	        return collegeBean;
	    }
	
	@Override
	public CollegeBean saveClientDetails(CollegeBean collegeBean) {
		log.info("Start registerClientDetailsDao() method in CollegeDaoImpl and CollegeId is >>> "+collegeBean.getCollegeId());
		Session session = factory.openSession();
		CollegeBean colBean=new CollegeBean();
		Transaction tx = session.beginTransaction();
		try {
			collegeBean.setCollegeId(collegeBean.getCollegeId());
			ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
	        Validator validator = (Validator) factory1.getValidator();
	        validator.validate(collegeBean);
			
	        colBean=(CollegeBean) session.merge(collegeBean);/*.saveOrUpdate(collegeBean);*/
			tx.commit();
			log.info("loginBEan {"+colBean.getLoginBean().getUserName().toString()+"}, collegeBeanId {"
							+colBean.getCollegeId().toString()+"}");
			//CollegeBean colBean = (CollegeBean) session.get(CollegeBean.class, collegeBean.getCollegeId());

		} catch(javax.validation.ConstraintViolationException e){
			e.printStackTrace();
			return null;
		}
		
		catch (Exception e) {
			
			e.printStackTrace();
			return colBean;

		} finally {
			log.info("End registerClientDetailsDao() method in CollegeDaoImpl");
			session.close();
		}
		log.info("loginBEan {"+colBean.getLoginBean().getUserName().toString()+"}, collegeBean {"
				+colBean.getCollegeId().toString()+"}");
		
		return colBean;
	}
	
   
	@Override
	public Integer getRowCount() {
		// Declarations

		// Open session from session factory
		Session session = factory.openSession();
		try {
			Criteria c = session.createCriteria(CollegeBean.class);
			c.addOrder(Order.desc("collegeId"));
			c.setMaxResults(1);
			CollegeBean temp = (CollegeBean) c.uniqueResult();
			return temp.getCollegeId() + 1;

		}catch(NullPointerException ex){
		
			return 0 + 1;
		
		}	
			finally {
		
			// close session
			session.close();
		}

	}
	
    @Override
    public  String saveBankDetailsDao(BankDetailsBean bankDetailsBean) {
        String valid;
        Session session = factory.openSession();
        valid = "true";
        try {
            try {
                Transaction tx = session.beginTransaction();
                session.save(bankDetailsBean);
                ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
                Validator validator = factory1.getValidator();
                validator.validate((Object)bankDetailsBean, new Class[0]);
                tx.commit();
            }
            catch (NullPointerException tx) {
                
            }
            catch (ConstraintViolationException e) {
                e.printStackTrace();
                valid = "false";
                
            }
        }
        finally {
            session.close();
        }
        return valid;
    }

	@Override
	public String saveMappingCodeOfSabPaisaDetails(ClientMappingCodeOfSabPaisa mappingCodeOfSabPaisa) {
		log.info("Open saveMappingCodeOfSabPaisaDetails() method : ========> "+mappingCodeOfSabPaisa.toString());
		Session session = factory.openSession();
		String value= "true";
		try {
			Transaction tx = session.beginTransaction();
			
			ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
	        Validator validator = (Validator) factory1.getValidator();
	        validator.validate(mappingCodeOfSabPaisa);
			session.save(mappingCodeOfSabPaisa);
			tx.commit();
			value="true";
		} catch (Exception ex) {
			log.info("clientMappingCodeOfSabpaisa is not stored in database.");
			ex.printStackTrace();
			value="false";
		} 
		
		finally {
			session.close();
		}
		log.info("return value by saveMappingCodeOfSabPaisaDetails() to main controller =========> "+value);
      return value;
	}
   

	@Override
    public  void updateClientMappingCodeOfSabPaisa(BeanPayerType beanPayerType, LoginBean loginUser) {
        Session session = factory.openSession();
        try {
            try {
                Transaction tx = session.beginTransaction();
                ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa = (ClientMappingCodeOfSabPaisa)session.createCriteria(ClientMappingCodeOfSabPaisa.class).add((Criterion)Restrictions.eq((String)"bid", (Object)loginUser.getCollgBean().getBankDetailsOTM().getBankId().toString())).add((Criterion)Restrictions.eq((String)"cid", (Object)loginUser.getCollgBean().getCollegeId().toString())).list().iterator().next();
                log.info(("testing values of retriving from db:" + clientMappingCodeOfSabPaisa.getBid() + clientMappingCodeOfSabPaisa.getCid()));
                clientMappingCodeOfSabPaisa.setCMProfile(beanPayerType.getPayer_type());
                session.merge(clientMappingCodeOfSabPaisa);
                tx.commit();
            }
            catch (NullPointerException tx) {
                session.close();
            }
        }
        finally {
            session.close();
        }
    }

	@Override
    public  void saveAndUpdateClientlogoDetails(CollegeBean collegeBean) {
        Session session = factory.openSession();
        try {
            try {
                Transaction tx = session.beginTransaction();
                CollegeBean client = (CollegeBean)session.createCriteria(CollegeBean.class).add((Criterion)Restrictions.eq((String)"collegeId", (Object)collegeBean.getCollegeId())).list().iterator().next();
                log.info((Object)("testing values of retriving from db:" + client.getCollegeCode()));
                client.setCollegeImage(collegeBean.getCollegeImage());
                session.merge((Object)client);
                tx.commit();
            }
            catch (NullPointerException tx) {
                session.close();
            }
        }
        finally {
            session.close();
        }
    }

	@Override
    public  List<ClientMappingCodeOfSabPaisa> getSabPaisaClientDetailsDAO(String id) {
        List clientMappingCodeOfSabPaisa;
        Session session = factory.openSession();
        clientMappingCodeOfSabPaisa = null;
        try {
            try {
                clientMappingCodeOfSabPaisa = session.createCriteria(ClientMappingCodeOfSabPaisa.class).add((Criterion)Restrictions.eq((String)"cid", (Object)id)).list();
                log.info((Object)(String.valueOf(clientMappingCodeOfSabPaisa.size()) + ":size of client details"));
            }
            catch (NullPointerException ex) {
                List list = clientMappingCodeOfSabPaisa;
                session.close();
                return list;
            }
        }
        finally {
            session.close();
        }
        return clientMappingCodeOfSabPaisa;
    }

	@Override
    public  ClientMappingCodeOfSabPaisa viewSabPaisaClientDetailsDAO(String id) {
        ClientMappingCodeOfSabPaisa clientMappingDetails;
        Session session = factory.openSession();
        clientMappingDetails = null;
        try {
            try {
                clientMappingDetails = (ClientMappingCodeOfSabPaisa)session.createCriteria(ClientMappingCodeOfSabPaisa.class).add((Criterion)Restrictions.eq((String)"cMCId", (Object)Integer.parseInt(id))).list().get(0);
            }
            catch (NullPointerException ex) {
                ClientMappingCodeOfSabPaisa clientMappingCodeOfSabPaisa = clientMappingDetails;
                session.close();
                return clientMappingCodeOfSabPaisa;
            }
        }
        finally {
            session.close();
        }
        return clientMappingDetails;
    }

	@Override
    public  ClientMappingCodeOfSabPaisa updateSabPaisaClientDetailsDAO(String cMId, String cMProfile, String cMCode, String cMClientUrl) {
        ClientMappingCodeOfSabPaisa clientMappingDetails;
        Session session = factory.openSession();
        clientMappingDetails = null;
        Transaction tx = session.beginTransaction();
        log.info("value of CMCID and othres are : >>>>>>>>>>>:"+cMId.toString()
        +" >>>>>>>>>>:"+cMProfile.toString()+" :>>>>>>>>>>>>>>>>>>>>:"+cMCode.toString()
        +":>>>>>>>>>>>>>>>>>>>>:"+cMClientUrl.toString());
        
        log.info((Object)(String.valueOf(cMId) + ":id :" + cMProfile + " : " + cMClientUrl));
        try {
            try {
                clientMappingDetails = (ClientMappingCodeOfSabPaisa)session.get(ClientMappingCodeOfSabPaisa.class, (Serializable)Integer.valueOf(Integer.parseInt(cMId)));
                ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
                Validator validator = factory1.getValidator();
                validator.validate((Object)cMClientUrl, new Class[0]);
                clientMappingDetails.setClientUrl(cMClientUrl);
                validator.validate((Object)cMCode, new Class[0]);
                clientMappingDetails.setCMCode(cMCode);
                validator.validate((Object)cMProfile, new Class[0]);
                clientMappingDetails.setCMProfile(cMProfile);
                session.merge((Object)clientMappingDetails);
                tx.commit();
            }
            catch (ConstraintViolationException e) {
                e.printStackTrace();
                session.close();
                return null;
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return clientMappingDetails;
    }

	@Override
    public CollegeBean getClientDetailsBasedOnId(int id) {
        CollegeBean bean;
        Session session = factory.openSession();
        bean = null;
        try {
            try {
                bean = (CollegeBean)session.get(CollegeBean.class, (Serializable)Integer.valueOf(id));
            }
            catch (Exception ex) {
                ex.printStackTrace();
                CollegeBean collegeBean = bean;
                session.close();
                return collegeBean;
            }
        }
        finally {
            session.close();
        }
        return bean;
    }

	@Override
    public Boolean saveSabPaisaClientMappingDetailsDao(CollegeBean collegeBean, ClientMappingCodeOfSabPaisa clientMappingBean) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        Object bean = null;
        try {
            try {
                clientMappingBean.setBid(collegeBean.getBankDetailsOTM().getBankId().toString());
                clientMappingBean.setCid(collegeBean.getCollegeId().toString());
                clientMappingBean.setCollegeBeanMappingToSabPaisaClient(collegeBean);
                ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
                Validator validator = factory1.getValidator();
                validator.validate((Object)clientMappingBean, new Class[0]);
                session.saveOrUpdate((Object)clientMappingBean);
                tx.commit();
            }
            catch (ConstraintViolationException e) {
                e.printStackTrace();
                Boolean bl = false;
                session.close();
                return bl;
            }
            catch (Exception ex) {
                ex.printStackTrace();
                Boolean bl = false;
                session.close();
                return bl;
            }
        }
        finally {
            session.close();
        }
        return true;
    }

	@Override
    public byte[] getImageInBytes(CollegeBean user) {
        if (user.getCollegeImage() == null) {
            return new byte[0];
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            FileInputStream is = new FileInputStream(user.getCollegeFile());
            byte[] buf = new byte[1024];
            int i = 0;
            while ((i = is.read(buf)) >= 0) {
                baos.write(buf, 0, i);
            }
            is.close();
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return baos.toByteArray();
    }

	@Override
    public  void updateClientlogoDetails(CollegeBean collegeBean) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        CollegeBean bean = null;
        log.info((Object)("id val:" + collegeBean.getCollegeId()));
        try {
            try {
                bean = (CollegeBean)session.get(CollegeBean.class, (Serializable)collegeBean.getCollegeId());
                bean.setCollegeImage(collegeBean.getCollegeImage());
                session.merge((Object)bean);
                tx.commit();
            }
            catch (Exception ex) {
                ex.printStackTrace();
                session.close();
            }
        }
        finally {
            session.close();
        }
    }

	@Override
    public  void updateBanklogoDetails(BankDetailsBean bankDetailsBean) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        BankDetailsBean bean = null;
        log.info((Object)("id val:" + bankDetailsBean.getBankId()));
        try {
            try {
                bean = (BankDetailsBean)session.get(BankDetailsBean.class, (Serializable)bankDetailsBean.getBankId());
                log.info((Object)("Bank Id :" + bean.getBankId()));
                bean.setBankImage(bankDetailsBean.getBankImage());
                session.merge((Object)bean);
                tx.commit();
            }
            catch (Exception ex) {
                ex.printStackTrace();
                session.close();
            }
        }
        finally {
            session.close();
        }
    }

	@Override
    public  List<StateBean> getStateList() {
        ArrayList<StateBean> StatesListBean;
        Session session = factory.openSession();
        StatesListBean = new ArrayList();
        try {
            try {
                StatesListBean = (ArrayList<StateBean>) session.createCriteria(StateBean.class).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return StatesListBean;
    }

	@Override
    public  List<ServicesBean> getServicesList() {
        ArrayList<ServicesBean> ServicesListBean;
        Session session = factory.openSession();
        ServicesListBean = new ArrayList();
        try {
            try {
                ServicesListBean = (ArrayList<ServicesBean>) session.createCriteria(ServicesBean.class).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return ServicesListBean;
    }

	@Override
    public  List<SuperAdminBean> getcompantList() {
        ArrayList<SuperAdminBean> companyListBean;
        Session session = factory.openSession();
        companyListBean = new ArrayList();
        try {
            try {
                companyListBean = (ArrayList<SuperAdminBean>) session.createCriteria(SuperAdminBean.class).list();
            }
            catch (NullPointerException ex) {
                session.close();
                return null;
            }
        }
        finally {
            session.close();
        }
        return companyListBean;
    }

	@Override
	@SuppressWarnings("unchecked")
	public StateBean getStateBean(Integer stateId) {
		Session session = factory.openSession();
		StateBean StateBean = new StateBean();
		try {
			StateBean = (StateBean) session.get(StateBean.class, stateId);

		} catch (java.lang.NullPointerException ex) {
			return null;
		} finally {
			session.close();
		}

		return StateBean;
	}
    

	@Override
    public void saveServicesBean(ServicesBean servicesBean) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        try {
            try {
            	log.info("service bean value while saving is "+servicesBean.getServiceName()+ "  "
            			+servicesBean.getServiceId());
                session.save((Object)servicesBean);
                tx.commit();
            }
            catch (NullPointerException ex) {
                ex.printStackTrace();
                session.close();
                session.close();
            }
        }
        finally {
            session.close();
        }
    }

	@Override
	public CompanyBean getCompany(Integer id) {
		Session session = factory.openSession();
		CompanyBean saBean = new CompanyBean();
		try {
			saBean = (CompanyBean) session.get(CompanyBean.class, id);

		} catch (java.lang.NullPointerException ex) {
			return saBean;
		} finally {
			session.close();
		}

		return saBean;
	}
    

	@Override
	public ServicesBean getServicesBean(Integer serviceId) {
		Session session = factory.openSession();
		ServicesBean servicesBean = new ServicesBean();
		try {
			servicesBean = (ServicesBean) session.get(ServicesBean.class, serviceId);

		} catch (java.lang.NullPointerException ex) {
			return servicesBean;
		} finally {
			session.close();
		}

		return servicesBean;
	}
   

	

	@Override
	public List<WhiteLableTempBean> getWhiteLableClientlist(Integer stateId, Integer bid, Integer serviceId) {
		Session session = factory.openSession();
		List<WhiteLableTempBean> whiteLablelist=new ArrayList<WhiteLableTempBean>();
		try {
			whiteLablelist = (List<WhiteLableTempBean>) session.createCriteria(WhiteLableTempBean.class)
					.add(Restrictions.eq("stateId", stateId))
					.add(Restrictions.eq("serviceId", serviceId))
					.add(Restrictions.eq("bankId", bid)).list();

		} catch (java.lang.NullPointerException ex) {
			ex.printStackTrace();
			return null;
		} finally {
			session.close();
		}

		return whiteLablelist;
	}

	
	
}

