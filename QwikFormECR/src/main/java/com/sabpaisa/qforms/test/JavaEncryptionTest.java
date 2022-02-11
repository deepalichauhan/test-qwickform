package com.sabpaisa.qforms.test;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sabpaisa.qforms.controller.SampleTransActionController;
import com.sabpaisa.requestprocessing.Encryptor;

public class JavaEncryptionTest {
	
	private static Logger log = LogManager.getLogger(JavaEncryptionTest.class.getName());
	
	static String qcAuthKey="zcjrujdGPEqqBYHG";
	static String qcAuthIV="DNmnGWhWeaj9wG6f";
	static String decText="";
	public static void main(String[] args) {
		
		String dataForEncreption ="";
		String ecreptedData ="";
		
		ecreptedData="";
		
		
		
		
		qcAuthIV = "8jsQzOYmtyclpyf6";
		qcAuthKey = "hyNOKgQa3bgzzID6";
		
		ecreptedData="6ivRAU1IgP5gMp+0B0QH2RhaPdrco/1MkZ0zzc9vATMeLS9I56pPPc4AUXtf+qriDKwrnPRiFIwUcZeTkNWOvlqwmF2EWm247/DSGRnNJLJgdkALWgrLlS1acHDU+gr3O2Cz3YOlA+SlFdmo2Rm5COdc22LIC6o3uDhGa2agbhTClI5x8USwaIawDgzWRldvrtLp8JPM/bwByksOCk87JAuB7JePUixeceu4ib6eTrCpH/tc5M39oo6tAw62Z8JblT+rjkMtqlY+tk+yv0qd++Z5shHRvQOv2NkEU3PKygh5tlfdkQsowS9FLkfTc7IaqayDdTp8UxlvstK9dDLi68hjKghOsM4S5JTXNwS3AolhUdfPqyHzWcNtt+ZLBDcK8UMLhGln4NXA0GH4MX6pVeTIL+78Di0220TPYPYuVZDwWmoj0wNYOcgts5W842wpvD/PlPJU+kExylE4fGYwEA==&clientCode=KGMU1&payeeProfile=null";
		
		//ecreptedData= "c2fYFnHnrNdRxs0NLEVP99n3yoqlTqpiESePndy3Rv/+jCQsbpvXi8jgxlRlyzVsF83qLiQECVDCFNZU9q0VK4KXgJCiaWzyfTl02N3PPPfAxuhGvsGcgLSgz+Cfg00hGsRCYIlegk5W9ANpyv6pMu8w+mIsqzMb98KXbWbArFfXJ12bdgBekg9nZyG01mLLspsfPSN8ZPBuopWI6yGc5Pv7MOuPE6p40q5WfHlUGy9sdqAPkMHCXbJcPLjTiftZEXL/bnFZnbDJpdGXaPPdaWGJ/xRc6U4jp0uGItqDni4QcqdOZXFwGb1h6tz4N7/ItTAPt1Myy9jUN46WYsAZNK/QG+rTWDlm8eJGVYOgGGLGKlERJvzsjcHnjkxAESDGGUsjhPkYvxTthvHnjlFbm7B7hsyz54QqlG5TKkcKqpc29RHc4/XO3Gm3n9ivKhGo+lZkTCDPl2WiAGA1tYWnoq51xQGBXzXZrEzxC1EbEPOQdgPkp3JH1palspagi2A4eGBHylm2Yt90mnRc9+LNvM2XToMJA6X5zF2FYTUsv3Ty2vIDFIuVS3VyLJNGe+53";
		
		ecreptedData = ecreptedData.replaceAll("%2B", "+");
		
		try {
			decText = Encryptor.decrypt( qcAuthKey, qcAuthIV, ecreptedData);
			log.info("decText:" + decText);
			
		} catch (InvalidAlgorithmParameterException | InvalidKeyException | NoSuchAlgorithmException
				| BadPaddingException | IllegalBlockSizeException | NoSuchPaddingException e) {
			e.printStackTrace();
		}catch (Exception e) {
			log.info("Exception Occoure while encreption:" + decText);
		}

	}

}
