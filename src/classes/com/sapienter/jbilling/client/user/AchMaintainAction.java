/*
    jBilling - The Enterprise Open Source Billing System
    Copyright (C) 2003-2009 Enterprise jBilling Software Ltd. and Emiliano Conde

    This file is part of jbilling.

    jbilling is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    jbilling is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with jbilling.  If not, see <http://www.gnu.org/licenses/>.
 */

package com.sapienter.jbilling.client.user;

import java.rmi.RemoteException;

import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;

import com.sapienter.jbilling.client.user.PaymentMethodCrudContext.AchContext;
import com.sapienter.jbilling.client.util.Constants;
import com.sapienter.jbilling.server.user.UserDTOEx;
import com.sapienter.jbilling.server.user.db.AchDTO;

public class AchMaintainAction extends
		AbstractPaymentMethodMaintainAction<AchContext> {
	private static final String FORM_ACH = "ach";

	private static final String FIELD_ABA_CODE = "aba_code";
	private static final String FIELD_ACCOUNT_NUMBER = "account_number";
	private static final String FIELD_ACCOUNT_TYPE = "account_type";
	private static final String FIELD_BANK_NAME = "bank_name";
	private static final String FIELD_ACCOUNT_NAME = "account_name";
	private static final String FIELD_USE_ACH = "chbx_use_this";

	private static final String FORWARD_DONE = "ach_done";
	private static final String FORWARD_EDIT = "ach_edit";
	private static final String FORWARD_DELETED = "ach_deleted";

	private static final String MESSAGE_UPDATE_OK = "ach.update.done";

	public AchMaintainAction() {
		super(FORM_ACH, "ACH", FIELD_ACCOUNT_NUMBER, FORWARD_EDIT);
	}

	@Override
	protected AchContext doEditFormToDTO() throws RemoteException {
		
		AchDTO dto = new AchDTO();
		dto.setAbaRouting((String) myForm.get(FIELD_ABA_CODE));
		dto.setBankAccount((String) myForm.get(FIELD_ACCOUNT_NUMBER));
		dto.setAccountType((Integer) myForm.get(FIELD_ACCOUNT_TYPE));
		dto.setAccountName((String) myForm.get(FIELD_ACCOUNT_NAME));
		dto.setBankName((String) myForm.get(FIELD_BANK_NAME));

		// Check that the user has not left masked data around (as the
		// Account Name is not checked, the mask would end on the DB)
		if (isFieldMasked(dto.getAbaRouting()) ||
				isFieldMasked(dto.getAccountName()) ||
				isFieldMasked(dto.getBankAccount())) {
			ActionError isMasked = new ActionError(//
					"ach.error.dataMasked", //
					"ach.data" //
			);
			errors.add(ActionErrors.GLOBAL_ERROR, isMasked);
		
		}
		// verify that this entity actually accepts this kind of
		// payment method
		else if (!getPaymentSession().isMethodAccepted(entityId,
				Constants.PAYMENT_METHOD_ACH)) {
			ActionError notAccepted = new ActionError(//
					"payment.error.notAccepted", //
					"payment.method" //
			);
			errors.add(ActionErrors.GLOBAL_ERROR, notAccepted);
		}

		AchContext result = new AchContext(dto);
		result.setIsAutomaticPayment((Boolean) myForm.get(FIELD_USE_ACH));

		return result;
	}

	@Override
	protected ForwardAndMessage doUpdate(AchContext dto) throws RemoteException {
		// Check if fields are masked, because the user hasn't updated them
		
		Integer userId = getSessionUserId();
			getUserSession().updateACH(userId, executorId, dto.getDto());
			getUserSession().setAuthPaymentType(userId,
					Constants.AUTO_PAYMENT_TYPE_ACH, dto.isAutomaticPayment());

		return new ForwardAndMessage(FORWARD_DONE, MESSAGE_UPDATE_OK);
	}

	@Override
	protected ForwardAndMessage doSetup() throws RemoteException {
		Integer userId = getSessionUserId();

		// now only one ach data per user
		AchDTO dto = getUserSession().getACH(userId);
		Integer type = getUserSession().getAuthPaymentType(userId);

		boolean use = Constants.AUTO_PAYMENT_TYPE_ACH.equals(type);
		if (dto != null) { // it could be that the user has no ACH setup yet
			myForm.set(FIELD_ABA_CODE, maskFieldIfNeeded(dto.getAbaRouting()));
			myForm.set(FIELD_ACCOUNT_NUMBER, maskFieldIfNeeded(dto.getBankAccount()));
			myForm.set(FIELD_ACCOUNT_TYPE, dto.getAccountType());
			myForm.set(FIELD_BANK_NAME, dto.getBankName());
			myForm.set(FIELD_ACCOUNT_NAME, maskNameIfNeeded(dto.getAccountName()));
			myForm.set(FIELD_USE_ACH, use);
		} else {
			setupNotFound();
		}
		return new ForwardAndMessage(FORWARD_EDIT);
	}

	@Override
	protected ForwardAndMessage doDelete() throws RemoteException {
		Integer userId = getSessionUserId();
		getUserSession().removeACH(userId, executorId);
		return new ForwardAndMessage(FORWARD_DELETED);
	}

	private Integer getSessionUserId() {
		return (Integer) session.getAttribute(Constants.SESSION_USER_ID);
	}
	
	private UserDTOEx getUserDto() {
		return (UserDTOEx) session.getAttribute(Constants.SESSION_USER_DTO);
	}
	
	private String maskFieldIfNeeded(String field) throws RemoteException {
		String result = field;
		if (isMaskNeeded()) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < (field.length() - 4); i ++) {
				sb.append('*');
			}
			sb.append(field.substring(field.length() - 4));
			result = sb.toString();
		}
		return result;
	}
	
	private String maskNameIfNeeded(String name) throws RemoteException {
		String result = name;
		if (isMaskNeeded()) {
			boolean addSpace = false;
			StringBuffer sb = new StringBuffer();
			for (String word : name.split(" ")) {
				if (!addSpace) {
					addSpace = true;
				} else {
					sb.append(" ");
				}
				sb.append(word.charAt(0));
				for (int i = 0; i < (word.length() - 1); i++) {
					sb.append("*");
				}
			}
			result = sb.toString();
		}
		return result;
	}
	
	private boolean isFieldMasked(String field) throws RemoteException {
		return isMaskNeeded() && field.contains("*");
	}

	private boolean isMaskNeeded() throws RemoteException {
		// if the user is not allowed to see cc info
		// or the entity does not want anybody to see cc numbers

		boolean maskNeeded = getUserDto().isGranted(
				Constants.P_USER_EDIT_VIEW_CC);
		if (!maskNeeded) {
			final Integer HIDE_CC_NUMBERS = com.sapienter.jbilling.server.util.Constants.PREFERENCE_HIDE_CC_NUMBERS;
			String maskAll = getUserSession().getEntityPreference(//
					entityId, HIDE_CC_NUMBERS);
			maskNeeded = "1".equals(maskAll);
		}

		return maskNeeded;
	}

	// public ActionForward execute(ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response)
	// throws IOException, ServletException {
	//        
	// Logger log = Logger.getLogger(CreditCardMaintainAction.class);
	// try {
	// JNDILookup EJBFactory = JNDILookup.getFactory(false);
	// UserSessionHome userHome =
	// (UserSessionHome) EJBFactory.lookUpHome(
	// UserSessionHome.class,
	// UserSessionHome.JNDI_NAME);
	//        
	// UserSession userSession = userHome.create();
	// GenericMaintainAction gma = new GenericMaintainAction(mapping,
	// form, request, response, servlet, userSession,
	// "ach");
	//                    
	// return gma.process();
	// } catch (Exception e) {
	// log.error("Exception ", e);
	// }
	//        
	// return mapping.findForward("error");
	// }

}
