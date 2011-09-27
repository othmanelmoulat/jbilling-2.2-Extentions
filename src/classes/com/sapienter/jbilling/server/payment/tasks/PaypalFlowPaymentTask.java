/*
    jBilling - The Enterprise Open Source Billing System
    Copyright (C) 2003-2008 Enterprise jBilling Software Ltd. and Emiliano Conde

    This file is part of jbilling.

    jbilling is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    jbilling is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with jbilling.  If not, see <http://www.gnu.org/licenses/>.
*/

package com.sapienter.jbilling.server.payment.tasks;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Iterator;

import org.apache.log4j.Logger;

import paypal.payflow.ACHTender;
import paypal.payflow.BankAcct;
import paypal.payflow.BaseTransaction;
import paypal.payflow.BillTo;
import paypal.payflow.CardTender;
import paypal.payflow.ClientInfo;
import paypal.payflow.Context;
import paypal.payflow.CreditCard;
import paypal.payflow.CreditTransaction;
import paypal.payflow.Currency;
import paypal.payflow.FraudResponse;
import paypal.payflow.Invoice;
import paypal.payflow.PayflowConnectionData;
import paypal.payflow.PayflowConstants;
import paypal.payflow.PayflowUtility;
import paypal.payflow.Response;
import paypal.payflow.SDKProperties;
import paypal.payflow.SaleTransaction;
import paypal.payflow.TransactionResponse;
import paypal.payflow.UserInfo;

import com.sapienter.jbilling.server.invoice.InvoiceBL;
import com.sapienter.jbilling.server.invoice.db.InvoiceDTO;
import com.sapienter.jbilling.server.invoice.db.InvoiceLineDTO;
import com.sapienter.jbilling.server.payment.PaymentDTOEx;
import com.sapienter.jbilling.server.payment.db.PaymentAuthorizationDTO;
import com.sapienter.jbilling.server.payment.db.PaymentResultDAS;
import com.sapienter.jbilling.server.pluggableTask.PaymentTask;
import com.sapienter.jbilling.server.pluggableTask.PaymentTaskWithTimeout;
import com.sapienter.jbilling.server.pluggableTask.admin.PluggableTaskDTO;
import com.sapienter.jbilling.server.pluggableTask.admin.PluggableTaskException;
import com.sapienter.jbilling.server.user.ContactBL;
import com.sapienter.jbilling.server.user.ContactDTOEx;
import com.sapienter.jbilling.server.user.UserBL;
import com.sapienter.jbilling.server.user.db.AchDTO;
import com.sapienter.jbilling.server.user.db.CreditCardDTO;
import com.sapienter.jbilling.server.user.db.UserDTO;
import com.sapienter.jbilling.server.util.Constants;

public class PaypalFlowPaymentTask extends PaymentTaskWithTimeout
            implements PaymentTask {

    // pluggable task parameters names

	public static final String PARAMETER_HOST = "host";
	public static final String PARAMETER_PORT = "port";
	public static final String PARAMETER_PARTNER = "partner";
	public static final String PARAMETER_VENDOR = "vendor";
	public static final String PARAMETER_USER 	= "user";
	public static final String PARAMETER_PASSWORD = "password";
    public static final String PARAMETER_AVS = "avs";
    public static final String PARAMETER_LEVEL2 = "level2"; 
	public static final String PARAMETER_CVV = "cvv";
	public static final String PARAMETER_LOGGING = "logging";
	public static final String PARAMETER_VERBOSITY = "verbosity";
	public static final String PARAMETER_LOGFILE = "log";
	
	private String host;
	private int port;
	private String partner;
	private String vendor;
	private String user;
	private String password; 
	private boolean doAvs = false;
	private boolean doLevel2 = false;
	private boolean cvv = true;
	private boolean logging = false;
	private String verbosity = "MEDIUM";
    private String logFile = "/opt/logsdir/payflow_pro.log";

    
 	private static final DateFormat expirationFormat = new SimpleDateFormat("MMyy");
	
    private static Logger logger = Logger.getLogger(PaypalFlowPaymentTask.class);
    
    /* (non-Javadoc)
     * @see com.sapienter.jbilling.server.pluggableTask.PaymentTask#process(com.sapienter.betty.server.payment.PaymentDTOEx)
     */
    public boolean process(PaymentDTOEx payment) 
            throws PluggableTaskException{
        boolean retValue = false;

        // Paypal is not available for payouts to partners
        if (payment.getPayoutId() != null) {
            throw new PluggableTaskException("Payouts can not be processed by this payment plugin.");
        }else{
        	// Set the necessary properties for PayFlowPro
        	SDKProperties.setHostAddress(this.host);
            SDKProperties.setHostPort(this.port);
            SDKProperties.setTimeOut(getTimeoutSeconds());

            // Check to see if we are running with logging on      
            if (logging){
                SDKProperties.setLogFileName(logFile);
                SDKProperties.setLoggingLevel(PayflowConstants.SEVERITY_DEBUG);
                SDKProperties.setMaxLogFileSize(100000);        	
            }

            // Process the credit card as the option of choice first
            // Need to verify if a customer prefers ACH what we do here
        	if (payment.getCreditCard() != null) {
        		// Check to see if we are processing a refund
        		if (payment.getIsRefund() == 0 && payment.getAmount().doubleValue() > 0.0) {
	            	retValue = processCreditCardSale(payment);
	            }else{
	            	retValue = processCreditCardRefund(payment);
	            }
            }else if (payment.getAch() != null) {
            	// Process an ACH sale. Determine if we need to process refunds as well
            	retValue = processACHSale(payment);        
            //} else if (payment.getPaymentMethod().getId() == 8){
        		// Logic that will be used to process recurring paypal transaction
            	// Check to see if we are processing a refund
        		//if (payment.getIsRefund() == 0 && payment.getAmount() > 0.0) {
	            //	retValue = processPaypalSale(payment);
	            //}else{
	            //	retValue = processPaypalRefund(payment);
	            //}            	
            }else{
                logger.error("The payment plugin requires a credit card or ach for processing.");
                throw new PluggableTaskException("The payment plugin requires a credit card or ach for processing.");
            }        	
        }

        return retValue;
    }

    /* (non-Javadoc)
     * @see com.sapienter.jbilling.server.pluggableTask.PaymentTask#failure(com.sapienter.betty.interfaces.UserEntityLocal, int)
     */
    public void failure(Integer userId, Integer retry) {
    	
    }
    
    
    /**
     * We are not using two phase credit card processing
     * 
     */
    public boolean preAuth(PaymentDTOEx payment) 
            throws PluggableTaskException {
 
        throw new PluggableTaskException("Task not configured to process pre-authorization.");
    }
    
    /**
     * We are not using two phase credit card processing
     * 
     */
    public boolean confirmPreAuth(PaymentAuthorizationDTO auth, 
            PaymentDTOEx payment) throws PluggableTaskException {

        throw new PluggableTaskException("Task not configured to process confirm pre-authorization.");
    }
    
    /**
     */
    private boolean processCreditCardSale(PaymentDTOEx payment) 
            throws PluggableTaskException {

        // Create the User data object with the required user details.
        UserInfo userInfo = new UserInfo(this.user, this.vendor, this.partner, this.password);

        // Create the Payflow Connection data object with the required connection details.
        PayflowConnectionData connection = new PayflowConnectionData();

        // Create a new Invoice data object with the Amount, Billing Address etc. details.
        Invoice inv = createInvoice(payment);

		CreditCardDTO cardDTO = payment.getCreditCard();
        // Create a new Payment Device - Credit Card data object.
        // The input parameters are Credit Card No. and Expiry Date for the Credit Card.
        CreditCard cc = new CreditCard(payment.getCreditCard().getNumber(), expirationFormat.format(cardDTO.getExpiry()));
		
        if (cardDTO.getSecurityCode() != null && cvv == true){
			cc.setCvv2((cardDTO.getSecurityCode()));
		}
	    if (payment.getPaymentPeriod() == null){
	    	// Set the recurring flag to make sure credit card trans always go through.
			// We are assuming this is because this payment was generated by the billing process
		    inv.setRecurring("Y");	        	
	    }			
		
        cc.setName(cardDTO.getName());
        // Create a new Tender - Card Tender data object.
        CardTender card = new CardTender(cc);

        // Create a new Sale Transaction.
        SaleTransaction trans = new SaleTransaction(
        		userInfo, connection, inv, card, PayflowUtility.getRequestId());

    	return doTransaction(trans, payment);
    }

    /**
     * Processes a credit card refund
     * 
     * @param payment
     * @return true/false 
     * @throws PluggableTaskException
     */
    public boolean processCreditCardRefund(PaymentDTOEx payment) 
            throws PluggableTaskException {

    	// Create the User data object with the required user details.
        UserInfo userInfo = new UserInfo(this.user, this.vendor, this.partner, this.password);

        // Create the Payflow Connection data object with the required connection details.
        PayflowConnectionData connection = new PayflowConnectionData();

        // Create a new Invoice data object with the Amount, Billing Address etc. details.
        Invoice inv = createInvoice(payment);

		CreditCardDTO cardDTO = payment.getCreditCard();
        // Create a new Payment Device - Credit Card data object.
        // The input parameters are Credit Card No. and Expiry Date for the Credit Card.
        CreditCard cc = new CreditCard(payment.getCreditCard().getNumber(), expirationFormat.format(cardDTO.getExpiry()));
		
        if (cardDTO.getSecurityCode() != null){
			cc.setCvv2((cardDTO.getSecurityCode()));
		}
		
        // Create a new Tender - Card Tender data object.
        CardTender card = new CardTender(cc);

        // Ignore expiration date for all refunds.
        inv.setRecurring("Y");

        // Create a new Credit card refund Transaction.
        CreditTransaction trans = new CreditTransaction(userInfo, connection, inv, card,
                PayflowUtility.getRequestId());

    	return doTransaction(trans, payment);
    }

    /**
     */
    public boolean processACHSale(PaymentDTOEx payment) 
            throws PluggableTaskException {

    	// Create the User data object with the required user details.
        UserInfo userInfo = new UserInfo(this.user, this.vendor, this.partner, this.password);

    	// Create the Payflow Connection data object with the required connection details.
        PayflowConnectionData connection = new PayflowConnectionData();

        // Create a new Invoice data object with the Amount, Billing Address etc. details.
        Invoice inv = createInvoice(payment);

        AchDTO achDTO = payment.getAch();
        // Create a new Payment Device - Bank Account data object.
        // The input parameters are Account No. and ABA.
        BankAcct ba = new BankAcct(achDTO.getBankAccount(), achDTO.getAbaRouting());
        // The Account Type can be "C" for Checking and "S" for Saving.
        if (achDTO.getAccountType() == 1){
            ba.setAcctType("C");        	
        }else{
            ba.setAcctType("S");        	        	
        }
        ba.setName(achDTO.getAccountName());
        
        // Set the description
        inv.setDesc("CT");
        
        // Create a new Tender - ACH Tender data object.
        ACHTender ach = new ACHTender(ba);

        // Create a new ach - Sale Transaction.
        SaleTransaction trans = new SaleTransaction(
                userInfo, connection, inv, ach, PayflowUtility.getRequestId());

        return doTransaction(trans, payment);
    }
    
	/**
	 * Evaluate the result ID and set the correct result code for jBilling
	 * 
	 * @param resultCode the Paypal result code
	 * @return the jBilling result id
	 */
    private int getPaymentResultId(int resultCode){
		if (resultCode < 0 || resultCode >= 100){
			return Constants.RESULT_UNAVAILABLE;
		}
		return (resultCode == 0) ? Constants.RESULT_OK : Constants.RESULT_FAIL; 

	}
	
	/**
	 * Format the amount to be the expected format for Paypal
	 * 
	 * @param amount the amount
	 * @return the string representation of the amount
	 */
	private String formatAmount(float amount){
		BigDecimal result = new BigDecimal(amount).setScale(2, RoundingMode.HALF_EVEN);
		return result.toPlainString();
	}
	
	private boolean doTransaction(BaseTransaction trans, PaymentDTOEx payment) throws PluggableTaskException{

        // Set the transactions verbosity level
		trans.setVerbosity(verbosity);
		
        Response resp = trans.submitTransaction();

        // Display the transaction response parameters.
        if (resp != null) {
            // Get the Transaction Response parameters.
            TransactionResponse trxnResponse = resp.getTransactionResponse();

            // Create a new Client Information data object.
            ClientInfo clinfo = new ClientInfo();

            // Set the ClientInfo object of the transaction object.
            trans.setClientInfo(clinfo);

            if (trxnResponse != null) {
            	
            	PaymentAuthorizationDTO paymentAuthorization = new PaymentAuthorizationDTO();
    			int resultCode = trxnResponse.getResult(); //not null by spec
    			String pnRef = trxnResponse.getPnref();
    			String cvvMatch = trxnResponse.getCvv2Match();
    			String message = trxnResponse.getRespMsg();
    			String authCode = trxnResponse.getAuthCode();
    			String procAvs = trxnResponse.getProcAvs();
    			String avsAddr = trxnResponse.getAvsAddr();
    			String avsZip = trxnResponse.getAvsZip();
    			String iAvs = trxnResponse.getIavs();
    			
    			String avsResponse = "";
    			if (procAvs != null){
    				avsResponse += "Proc=" + procAvs;
    			}     			
    			if (avsAddr != null){
    				avsResponse += " Addr=" + avsAddr;
    			}
    			if (avsZip != null){
    				avsResponse += " Zip=" + avsZip;
    			}
    			if (iAvs != null){
    				avsResponse += " IAvs=" + iAvs;
    			}
    			paymentAuthorization.setProcessor("PayPal");
    			paymentAuthorization.setCode1(Integer.toString(resultCode));
    			paymentAuthorization.setCode2(cvvMatch);
    			//paymentAuthorization.setCardCode(message);
    			paymentAuthorization.setApprovalCode(authCode);
    			paymentAuthorization.setTransactionId(pnRef);
    			paymentAuthorization.setResponseMessage(message);    			
    			paymentAuthorization.setAvs(avsResponse);
    			
    			
    			// Store the authorization result and set the result code
    	        payment.setPaymentResult(new PaymentResultDAS().find(getPaymentResultId(resultCode)));
    	        storeProcessedAuthorization(payment, paymentAuthorization);
    	        
    			if (logging){
                	logger.info("RESULT = " + trxnResponse.getResult());
                	logger.info("PNREF = " + trxnResponse.getPnref());
                	logger.info("RESPMSG = " + trxnResponse.getRespMsg());
                	logger.info("AUTHCODE = " + trxnResponse.getAuthCode());
                	logger.info("AVSADDR = " + trxnResponse.getAvsAddr());
                	logger.info("AVSZIP = " + trxnResponse.getAvsZip());
                	logger.info("IAVS = " + trxnResponse.getIavs());
                	logger.info("CVV2MATCH = " + trxnResponse.getCvv2Match());
                	logger.info("DUPLICATE = " + trxnResponse.getDuplicate());    				
                	logger.info("PROCAVS = " + trxnResponse.getProcAvs());
                	logger.info("ADDLMSGS = " + trxnResponse.getAddlMsgs());
    			}
            }

            // Get the Fraud Response parameters.
            FraudResponse fraudResp = resp.getFraudResponse();
            if (fraudResp != null) {
            	logger.info("PREFPSMSG = " + fraudResp.getPreFpsMsg());
            	logger.info("POSTFPSMSG = " + fraudResp.getPostFpsMsg());
            }

            // Display the response.
            logger.info(PayflowUtility.getStatus(resp));

            // Get the Transaction Context and check for any contained SDK specific errors (optional code).
            Context transCtx = resp.getContext();
            if (transCtx != null && transCtx.getErrorCount() > 0) {
            	logger.error("Transaction Errors = " + transCtx.toString());
            }
        }
        
		return false;
	}
	
	/**
	 * Creates the Paypal invoice object
	 * 
	 * @param payment the jbilling payment object
	 * @param user the jbilling user objcet
	 * @return the Paypal invoice object
	 */
	private Invoice createInvoice(PaymentDTOEx payment){
		Invoice inv = new Invoice();

		Float paymentAmt = payment.getAmount().floatValue();
		
    	if (paymentAmt < 0) {
    		paymentAmt = (paymentAmt*-1);
    	}

		// Set Amount of the invoice
        Currency amt = new Currency(new Double(formatAmount(paymentAmt)));
        inv.setAmt(amt);       
        inv.setCustRef(Integer.toString(payment.getId()));

        try {
	                
	        // Set the invoice id's attached to the payment 
        	// and process card level2 if necessary
	        if (payment.getInvoiceIds() != null){
	        	
	        	Iterator it = payment.getInvoiceIds().iterator();
	        	
	            if (it != null && it.hasNext()){
	            	Integer invoiceId = (Integer)it.next();            	
	            	inv.setInvNum(invoiceId.toString());        	
	                inv.setPoNum(invoiceId.toString());  
	                
	                // Add Corporate/Purchase Card level 2 fields
	    	        if (doLevel2){
 						InvoiceBL invoiceBL = new InvoiceBL(invoiceId);
						
 						InvoiceDTO invoiceDTO = invoiceBL.getDTOEx(null, false);
 						
						Currency taxAmt = new Currency(new Double(0.0));
						inv.setTaxAmt(taxAmt);
						inv.setTaxExempt("N");    	            			   	            			
					
						Collection<InvoiceLineDTO> invoiceLines = invoiceDTO.getInvoiceLines();
						
						// Loop through and add the sales tax totals
						for (InvoiceLineDTO invoiceLine : invoiceLines){

							if (invoiceLine.getItem().getId() == 50000){
								if (invoiceLine.getQuantity().doubleValue() == 0.0){
									inv.setTaxExempt("Y");    	            			   	            			
								}
								
								NumberFormat nf = NumberFormat.getInstance();
								nf.setMinimumFractionDigits(2);
								nf.setMaximumFractionDigits(2);
								String taxAmtString = nf.format(invoiceLine.getAmount().doubleValue());
								 
								taxAmt = new Currency(new Double(taxAmtString));
								
								inv.setTaxAmt(taxAmt);
								break;
							}
						}
	    	        }
	           }
	        }
		} catch (Throwable t){
            logger.warn("Unable to add invoice data related. Continuing on to process payment. " +
            		"[userId: " + payment.getUserId().intValue() + "]", t);
			
		}
         
        // Get the user of the payment
        UserDTO user = null;
        try {
            if (payment.getUserId() != null) {
                UserBL userBL = new UserBL(payment.getUserId());
               	user = userBL.getEntity();          
           }
        }catch (Throwable e) {
            logger.warn("Unable to get customer user information, Continuing on to process payment. " +
            		"[userId: " + payment.getUserId().intValue() + "]", e);
        }
        
		if (user != null){
	        inv.setComment1(user.getUserName());        		
		}
        inv.setComment2(payment.getUserId().toString());        	
		
    	if (payment.getCreditCard() != null) {
	       
	        // Set the billing Address details if doing AVS
	        if (doAvs){
	    		ContactDTOEx contact;
	    		ContactBL loader = new ContactBL();
	    		loader.set(payment.getUserId());
	    		contact = loader.getDTO();
	    		
	            // Set the Billing Address details.
	        	BillTo bill = new BillTo();
	            bill.setStreet(contact.getAddress1());
	           // bill.setBillToStreet2(contact.getAddress2());
	            bill.setZip(contact.getPostalCode());
	            inv.setBillTo(bill); 
	        }
    	}
        return inv;
 	}
	
    /**
     */
    private boolean processPaypalSale(PaymentDTOEx payment) 
            throws PluggableTaskException {
/*
        // Create the User data object with the required user details.
        UserInfo userInfo = new UserInfo(this.user, this.vendor, this.partner, this.password);

        // Create the Payflow Connection data object with the required connection details.
        PayflowConnectionData connection = new PayflowConnectionData();

        // Create a new Invoice data object with the Amount, Billing Address etc. details.
        Invoice inv = createInvoice(payment);

		CreditCardDTO cardDTO = payment.getCreditCard();
        // Create a new Payment Device - Credit Card data object.
        // The input parameters are Credit Card No. and Expiry Date for the Credit Card.
        CreditCard cc = new CreditCard(payment.getCreditCard().getNumber(), expirationFormat.format(cardDTO.getExpiry()));
		
        if (cardDTO.getSecurityCode() != null){
			cc.setCvv2(Integer.toString(cardDTO.getSecurityCode()));
		}else{
	        if (payment.getPaymentPeriod() == null){
				// Set the recurring flag to make sure credit card trans always go through.
				// We are assuming this is because this payment was generated by the billing process
		        inv.setRecurring("Y");	        	
	        }			
		}
        cc.setName(cardDTO.getName());
        // Create a new Tender - Card Tender data object.
        ReferenceTransaction card = new ReferenceTransaction();

        // Create a new Sale Transaction.
        ReferenceTransaction trans = new ReferenceTransaction(
        		userInfo, connection, inv, card, PayflowUtility.getRequestId());

    	return doTransaction(trans, payment);
  */
    	return true;
    }

    /**
     * Processes a credit card refund
     * 
     * @param payment
     * @return true/false 
     * @throws PluggableTaskException
     */
    public boolean processPaypalRefund(PaymentDTOEx payment) 
            throws PluggableTaskException {
/*
    	// Create the User data object with the required user details.
        UserInfo userInfo = new UserInfo(this.user, this.vendor, this.partner, this.password);

        // Create the Payflow Connection data object with the required connection details.
        PayflowConnectionData connection = new PayflowConnectionData();

        // Create a new Invoice data object with the Amount, Billing Address etc. details.
        Invoice inv = createInvoice(payment);

		CreditCardDTO cardDTO = payment.getCreditCard();
        // Create a new Payment Device - Credit Card data object.
        // The input parameters are Credit Card No. and Expiry Date for the Credit Card.
        CreditCard cc = new CreditCard(payment.getCreditCard().getNumber(), expirationFormat.format(cardDTO.getExpiry()));
		
        if (cardDTO.getSecurityCode() != null){
			cc.setCvv2(Integer.toString(cardDTO.getSecurityCode()));
		}
		
        // Create a new Tender - Card Tender data object.
        CardTender card = new CardTender(cc);

        // Create a new Credit card refund Transaction.
        CreditTransaction trans = new CreditTransaction(userInfo, connection, inv, card,
                PayflowUtility.getRequestId());

    	return doTransaction(trans, payment);
  	*/
    	return true;
    }	
	
	@Override
	public void initializeParamters(PluggableTaskDTO task) throws PluggableTaskException {
		super.initializeParamters(task);
		host = ensureGetParameter(PARAMETER_HOST);
		String portText = getOptionalParameter(PARAMETER_PORT, "443");
		try {
			port = Integer.parseInt(portText);  
		} catch (NumberFormatException e){
			logger.error("Invalid argument value [" + portText + "] for parameter " + PARAMETER_PORT + ". ");
			throw new PluggableTaskException("" 
					+ "Integer expected for parameter: " + PARAMETER_PORT  
					+ ", actual: " + portText);
		}
		partner = ensureGetParameter(PARAMETER_PARTNER);
		vendor = ensureGetParameter(PARAMETER_VENDOR);
		user = ensureGetParameter(PARAMETER_USER);
		password = ensureGetParameter(PARAMETER_PASSWORD);
		doAvs = getBooleanParameter(PARAMETER_AVS);		
		doLevel2 = getBooleanParameter(PARAMETER_LEVEL2);		
		logging = getBooleanParameter(PARAMETER_LOGGING);
		verbosity = getOptionalParameter(PARAMETER_VERBOSITY, "MEDIUM");		
		logFile = getOptionalParameter(PARAMETER_LOGFILE, "/opt/logsdir/payflow_pro.log");		
		cvv = Boolean.parseBoolean(getOptionalParameter(PARAMETER_CVV, "true"));		
	}
}
