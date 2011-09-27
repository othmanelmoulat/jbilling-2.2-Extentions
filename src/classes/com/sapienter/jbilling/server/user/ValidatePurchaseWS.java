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

package com.sapienter.jbilling.server.user;

import com.sapienter.jbilling.common.Constants;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Result object for validatePurchase API method.
 */
public class ValidatePurchaseWS implements Serializable {

    private Boolean success;
    private String[] message;
    private Boolean authorized;
    private String quantity;
    private BigDecimal quantityAsDecimal;

    public ValidatePurchaseWS() {
        success = true;
        message = null;
        authorized = true;
        quantity = "0.0";
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public String[] getMessage() {
        return message;
    }

    public void setMessage(String[] message) {
        this.message = message;
    }

    public Boolean getAuthorized() {
        return authorized;
    }

    public void setAuthorized(Boolean authorized) {
        this.authorized = authorized;
    }

    public String getQuantity() {
        return quantity;
    }

    public BigDecimal getQuantityAsDecimal() {
        if(quantityAsDecimal != null)
            return quantityAsDecimal;
        return (quantity == null ? null : new BigDecimal(quantity));
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public void setQuantity(Double quantity) {
        this.setQuantity(new BigDecimal(quantity));
    }

    /**
     * <strong>Note:</strong> Subsequent call to getQuantity returns value rounded to 2 decimals.
     * Use getQuantityAsDecimal if precision is important, i.e. for calculations
     * @param quantity
     */
    public void setQuantity(BigDecimal quantity) {
        this.quantityAsDecimal = quantity;
        if (quantity != null)
            this.quantity = quantity.setScale(Constants.BIGDECIMAL_SCALE_STR, Constants.BIGDECIMAL_ROUND).toString();
    }
}
