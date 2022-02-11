package com.sabpaisa.qforms.util.testing;

public class tempCalss {

	public static void main(String[] args) {
		
		String str="http://localhost:8089/home/arvind/development/codebase/installedTools/apache-tomcat-9.0.30/webapps/QwikFormsContent/QwikFormClientDocument/PCOI1/Payer_85/Test_Form_For_File_Uplod_565/2020-08-01/Praveen_Exit_ChecklisthphnSRS_1596255666214.docx";
		
//		String str="https://portal.sabpaisa.in/home/arvind/development/codebase/installedTools/apache-tomcat-9.0.30/webapps/QwikFormsContent/QwikFormClientDocument/PCOI1/Payer_85/Test_Form_For_File_Uplod_565/2020-08-01/Praveen_Exit_ChecklisthphnSRS_1596255666214.docx";

//		String str="https://qwikforms.in/home/arvind/development/codebase/installedTools/apache-tomcat-9.0.30/webapps/QwikFormsContent/QwikFormClientDocument/PCOI1/Payer_85/Test_Form_For_File_Uplod_565/2020-08-01/Praveen_Exit_ChecklisthphnSRS_1596255666214.docx";
		
		str=str.substring(str.indexOf("in")+2,str.length());
		
		System.out.println(str);
		
//		https://portal.sabpaisa.in/QwikForms
//		String fStr="QF675634573";
//		
//		int x=fStr.indexOf("67");
//		System.out.println("find x :::::: "+x);
//
//		String str = "12345";
//		String str2 = "";
//		str2 = str.substring(0, str.length() - 1);
//		String str3 = "";
//		str3 = str.substring(str.length() - 1, str.length());
//		System.out.println(str2);
//		System.out.println(str3);
//		try {
//			double d=0.0/0;
//			double e=0.0/0.0;
//			double f=0/0.0;
//			double g=1/0.0;
//			double h=1.0/0;
//			System.out.println(d);
//			System.out.println(e);
//			System.out.println(f);
//			System.out.println(g);
//			System.out.println(h);
//		} catch (Exception e) {
//			
//			e.printStackTrace();
//		}
	}

}
