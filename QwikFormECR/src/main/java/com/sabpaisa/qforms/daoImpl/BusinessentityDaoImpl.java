package com.sabpaisa.qforms.daoImpl;

public class BusinessentityDaoImpl {
	
	/*@Autowired
	SessionFactory factory;
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	private static final Logger log = LogManager.getLogger("CollegeDaoImpl.class");
	
	
	
	public List<BeanPayerType> getClientBasedProductList(Integer clientId) {
		Session session = factory.openSession();
		List<BeanPayerType> productListBean = new ArrayList<BeanPayerType>();
		try {
			//productListBean = (List<ClientProductBean>) session.createCriteria(ClientProductBean.class).add(Restrictions.eq("productBean.id", clientId)).list();
			productListBean = (List<BeanPayerType>) session.createCriteria(BeanPayerType.class).add(Restrictions.eq("clientId", clientId.toString())).list();
			log.info("Size of productListBean is = " + productListBean.size());
		} catch (java.lang.NullPointerException ex) {
			return null;
		} finally {
			session.close();
		}

		return productListBean;
	}
	
	@SuppressWarnings("unchecked")
	public List<BankDetailsBean> getBankList() {
		Session session = factory.openSession();
		List<BankDetailsBean> bankListBean = new ArrayList<BankDetailsBean>();
		try {
			bankListBean = (List<BankDetailsBean>) session.createCriteria(BankDetailsBean.class).list();
			log.info("Size of bankListBean is = " + bankListBean.size());
		} catch (java.lang.NullPointerException ex) {
			return null;
		} finally {
			session.close();
		}

		return bankListBean;
	}*/
}
