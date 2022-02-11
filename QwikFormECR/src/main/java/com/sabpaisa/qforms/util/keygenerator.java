/*package com.sabpaisa.QForms.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;

public class keygenerator {

	Logger log = Logger.getLogger(keygenerator.class);
	
	public static void main(String[] args) throws ParseException {
		// TODO Auto-generated method stub
		keygenerator id = new keygenerator();
		id.createTransxId();
		System.out.println("ID is " + id.createTransxId());
		id.anotherLinkKey();
		System.out.println("ID is " + id.anotherLinkKey());
	}

	public String createTransxId() throws ParseException {

		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyhhmmssSS");
		String format = sdf.format(dt);
		// System.out.println("date " + format);
		Long nanoTime = System.nanoTime();
		log.info("nano sec lngth :: " + nanoTime.toString().length());
		String tranxId = null;
		String initialVal = null;
		String lastVal = null;
		try {
			UUID uidPre = UUID.randomUUID();
			UUID uidSuff = UUID.randomUUID();
			String valuePre = String.valueOf(uidPre.getMostSignificantBits());
			String valueSuff = String.valueOf(uidSuff.getMostSignificantBits());

			initialVal = valuePre.substring(4, 9);
			lastVal = valueSuff.substring(9, 14);

			// tranxId = initialVal.concat(format.concat(lastVal));
			tranxId = format;
			List<String> txnList = dao.getOldTxnList(tranxId);

			log.info("old txn List Size is ::" + txnList.size());
			if (txnList.isEmpty()) {
				log.info("if txId ::" + tranxId);
				log.info("txn Id length is ::" + tranxId.length());
				return tranxId;

			} else {
				BigInteger txnIdBigInt = new BigInteger(tranxId);

				txnIdBigInt = txnIdBigInt.add(BigInteger.ONE);

				log.info("else txId ::" + txnIdBigInt);
				log.info("txn Id length is ::" + txnIdBigInt.toString().length());

				return txnIdBigInt.toString();
			}

		} catch (Exception e) {
			UUID uidPre = UUID.randomUUID();
			UUID uidSuff = UUID.randomUUID();
			String valuePre = String.valueOf(uidPre.getMostSignificantBits());
			String valueSuff = String.valueOf(uidSuff.getMostSignificantBits());
			initialVal = valuePre.substring(9, 14);
			lastVal = valueSuff.substring(4, 9);
			tranxId = initialVal.concat(format.concat(lastVal));

			List<String> txnList = dao.getOldTxnList(tranxId);
			if (txnList.isEmpty()) {
				log.info("catch if txId ::" + tranxId);
				log.info("txn Id length is ::" + tranxId.length());

				return tranxId;

			} else {

				BigInteger txnIdBigInt = new BigInteger(tranxId);

				txnIdBigInt = txnIdBigInt.add(BigInteger.ONE);

				log.info("catch else txId ::" + txnIdBigInt);
				log.info("txn Id length is ::" + txnIdBigInt.toString().length());

				return txnIdBigInt.toString();
			}
		}

	}

	public String anotherLinkKey() {
		String key = null;
		try {

			SecureRandom prng = SecureRandom.getInstance("SHA1PRNG");
			String randomNum = new Integer(prng.nextInt()).toString();
			MessageDigest sha = MessageDigest.getInstance("SHA-1");
			byte[] result = sha.digest(randomNum.getBytes());
			System.out.println("Random number: " + randomNum);
			System.out.println("Message digest: " + hexEncode(result));
			key = "LP" + randomNum;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return key;

	}

	static private String hexEncode(byte[] aInput) {
		StringBuilder result = new StringBuilder();
		char[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
		for (int idx = 0; idx < aInput.length; ++idx) {
			byte b = aInput[idx];
			result.append(digits[(b & 0xf0) >> 4]);
			result.append(digits[b & 0x0f]);
		}
		return result.toString();
	}
	
	public String linkPaisaTransxId() throws ParseException {

		Date dt = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyhhmmssSS");
		String format = sdf.format(dt);
		// System.out.println("date " + format);
		Long nanoTime = System.nanoTime();
		log.info("nano sec lngth :: " + nanoTime.toString().length());
		String tranxId = null;
		String initialVal = null;
		String lastVal = null;
		try {
			UUID uidPre = UUID.randomUUID();
			UUID uidSuff = UUID.randomUUID();
			String valuePre = String.valueOf(uidPre.getMostSignificantBits());
			String valueSuff = String.valueOf(uidSuff.getMostSignificantBits());

			initialVal = valuePre.substring(4, 9);
			lastVal = valueSuff.substring(9, 14);

			// tranxId = initialVal.concat(format.concat(lastVal));
			tranxId = format;
			List<String> txnList = dao.getOldTxnList(tranxId);

			log.info("old txn List Size is ::" + txnList.size());
			if (txnList.isEmpty()) {
				log.info("if txId ::" + tranxId);
				log.info("txn Id length is ::" + tranxId.length());
				String s = "000000";
				s = String.valueOf(Integer.parseInt(s) + 1);
				tranxId="LP"+tranxId;
				return tranxId;

			} else {
				BigInteger txnIdBigInt = new BigInteger(tranxId);

				txnIdBigInt = txnIdBigInt.add(BigInteger.ONE);

				log.info("else txId ::" + txnIdBigInt);
				log.info("txn Id length is ::" + txnIdBigInt.toString().length());
				tranxId="LP"+tranxId;
				return txnIdBigInt.toString();
			}

		} catch (Exception e) {
			UUID uidPre = UUID.randomUUID();
			UUID uidSuff = UUID.randomUUID();
			String valuePre = String.valueOf(uidPre.getMostSignificantBits());
			String valueSuff = String.valueOf(uidSuff.getMostSignificantBits());
			initialVal = valuePre.substring(9, 14);
			lastVal = valueSuff.substring(4, 9);
			tranxId = initialVal.concat(format.concat(lastVal));

			List<String> txnList = dao.getOldTxnList(tranxId);
			if (txnList.isEmpty()) {
				log.info("catch if txId ::" + tranxId);
				log.info("txn Id length is ::" + tranxId.length());
				tranxId="LP"+tranxId;
				return tranxId;

			} else {

				BigInteger txnIdBigInt = new BigInteger(tranxId);

				txnIdBigInt = txnIdBigInt.add(BigInteger.ONE);

				log.info("catch else txId ::" + txnIdBigInt);
				log.info("txn Id length is ::" + txnIdBigInt.toString().length());
				tranxId="LP"+tranxId;
				return txnIdBigInt.toString();
			}
		}

	}

	
}
*/