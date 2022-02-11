package com.sabpaisa.qforms.WebXmlFile;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.requestprocessing.Encryptor;

@Controller
@RequestMapping
public class ResponseServlet extends HttpServlet {

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();

	String qcAuthKey = properties.getProperty("qcProAuthKey");
	String qcAuthIV = properties.getProperty("qcProAuthIV");

	
	@RequestMapping(value="",method = {RequestMethod.GET,RequestMethod.POST})
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
		String query=request.getParameter("query");
		String authKey=qcAuthKey;
		String authIV=qcAuthIV;
		
		
		String decText = null;
		try {
			decText = Encryptor.decrypt(authKey, authIV, query);
		} catch (InvalidKeyException | NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Map<String, String> querypair = new LinkedHashMap<String, String>();
		querypair=Encryptor.splitQuery(decText);
		
		request.setAttribute("SabPaisaTxId", querypair.get("SabPaisaTxId"));
		request.setAttribute("clientTxnId", querypair.get("clientTxnId"));
		request.setAttribute("PGTxnNo", querypair.get("PgTxnNo"));
		request.setAttribute("issuerRefNo", querypair.get("issuerRefNo"));
		request.setAttribute("spRespCode", querypair.get("spRespCode"));
		request.setAttribute("pgRespCode", querypair.get("pgRespCode"));
		request.setAttribute("Amount", querypair.get("Amount"));
		request.setAttribute("authIdCode", querypair.get("authIdCode"));
		request.setAttribute("payMode", querypair.get("payMode"));
		request.setAttribute("firstName", querypair.get("firstName"));
		request.setAttribute("lastName", querypair.get("lastName"));
		request.setAttribute("mobileNo", querypair.get("mobileNo"));
		request.setAttribute("email", querypair.get("email"));
		request.getRequestDispatcher("/ClientResponse.jsp").forward(request, response);
	}

}
