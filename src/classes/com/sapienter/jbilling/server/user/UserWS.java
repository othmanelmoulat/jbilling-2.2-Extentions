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

/*
 * Created on Dec 18, 2003
 *
 */
package com.sapienter.jbilling.server.user;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.sapienter.jbilling.server.entity.AchDTO;
import com.sapienter.jbilling.server.entity.CreditCardDTO;
import com.sapienter.jbilling.server.user.db.CustomerDTO;
import com.sapienter.jbilling.server.util.Constants;

/**
 * @author Emil
 */
public class UserWS implements Serializable {
    private int id;
    private Integer currencyId;
    private String password;
    private int deleted;
    private Date createDatetime;
    private Date lastStatusChange;
    private Date lastLogin;
    private String userName;
    private int failedAttempts;
    private Integer languageId;

    private CreditCardDTO creditCard = null;
    private AchDTO ach = null;
    private ContactWS contact = null;
    private String role = null;
    private String language = null;
    private String status = null;
    private Integer mainRoleId = null;
    private Integer statusId = null;
    private Integer subscriberStatusId = null;
    private Integer partnerId = null;
    private Integer parentId = null;
    private Boolean isParent = null;
    private Boolean invoiceChild = null;
    private Integer mainOrderId = null;
    private String[] blacklistMatches = null;
    private Boolean userIdBlacklisted = null;
    private Integer[] childIds = null;
    private String owingBalance = null;
    private Integer balanceType = null;
    private String dynamicBalance = null;
    private String autoRecharge = null;
    private String creditLimit = null;
    private BigDecimal autoRechargeAsDecimal;
    private BigDecimal owingBalanceAsDecimal;
    private BigDecimal creditLimitAsDecimal;
    private BigDecimal dynamicBalanceAsDecimal;

    public Integer getPartnerId() {
        return partnerId;
    }
    public void setPartnerId(Integer partnerId) {
        this.partnerId = partnerId;
    }
    // to comply with the Java Bean spec.
    public UserWS() {
    }
    
    public UserWS(UserDTOEx dto) {
        id = dto.getId();
        currencyId = dto.getCurrencyId();
        password = dto.getPassword();
        deleted = dto.getDeleted();
        createDatetime = dto.getCreateDatetime();
        lastStatusChange = dto.getLastStatusChange();
        lastLogin = dto.getLastLogin();
        userName = dto.getUserName();
        failedAttempts = dto.getFailedAttempts();
        languageId = dto.getLanguageId();

        creditCard = dto.getCreditCard() == null ? null : dto.getCreditCard().getOldDTO();
        ach = dto.getAch() == null ? null : dto.getAch().getOldDTO();
        role = dto.getMainRoleStr();
        mainRoleId = dto.getMainRoleId();
        language = dto.getLanguageStr();
        status = dto.getStatusStr();
        role = dto.getMainRoleStr();
        statusId = dto.getStatusId();
        subscriberStatusId = dto.getSubscriptionStatusId();
        if (dto.getCustomer() != null) {
            partnerId = (dto.getCustomer().getPartner() == null) ? null : dto.getCustomer().getPartner().getId();
            parentId = (dto.getCustomer().getParent() == null) ? null : dto.getCustomer().getParent().getBaseUser().getId();
            mainOrderId = dto.getCustomer().getCurrentOrderId();
            isParent = dto.getCustomer().getIsParent() == null ? false : dto.getCustomer().getIsParent().equals(new Integer(1));
            invoiceChild = dto.getCustomer().getInvoiceChild() == null ? false : dto.getCustomer().getInvoiceChild().equals(new Integer(1));
            childIds = new Integer[dto.getCustomer().getChildren().size()];
            int index = 0;
            for (CustomerDTO customer : dto.getCustomer().getChildren()) {
                childIds[index] = customer.getBaseUser().getId();
                index++;
            }
            balanceType = dto.getCustomer().getBalanceType();

            setDynamicBalance(dto.getCustomer().getDynamicBalance());
            setCreditLimit(dto.getCustomer().getCreditLimit());
            setAutoRecharge(dto.getCustomer().getAutoRecharge());
        }
        blacklistMatches = dto.getBlacklistMatches() != null ? dto.getBlacklistMatches().toArray(new String[0]) : null;
        userIdBlacklisted = dto.getUserIdBlacklisted();

        setOwingBalance(dto.getBalance());
    }
    
    public String toString() {
        return "id = [" + id + "] credit card = [" + creditCard + "] ach = [" +
        		ach + "] contact = [" + contact + "] type = [" + role + 
        		"] language = [" + languageId + language + "]  status = [" + 
        		status + "] statusId = [" + statusId + "] subscriberStatusId = [" + 
        		subscriberStatusId + "] roleId = [" + mainRoleId + "] " +  
        		" parentId = [" + parentId + "] " + super.toString();
    }
    /**
     * @return
     */
    public ContactWS getContact() {
        return contact;
    }

    /**
     * @param contact
     */
    public void setContact(ContactWS contact) {
        this.contact = contact;
    }

    /**
     * @return
     */
    public CreditCardDTO getCreditCard() {
        return creditCard;
    }

    /**
     * @param creditCard
     */
    public void setCreditCard(CreditCardDTO creditCard) {
        this.creditCard = creditCard;
    }
    
    public AchDTO getAch() {
    	return ach;
    }
    
    public void setAch(AchDTO ach) {
    	this.ach = ach;
    }

    /**
     * @return
     */
    public String getLanguage() {
        return language;
    }

    /**
     * @param language
     */
    public void setLanguage(String language) {
        this.language = language;
    }

    /**
     * @return
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return
     */
    public String getRole() {
        return role;
    }

    /**
     * @param type
     */
    public void setRole(String type) {
        this.role = type;
    }

    /**
     * @return
     */
    public Integer getMainRoleId() {
        return mainRoleId;
    }

    /**
     * @param mainRoleId
     */
    public void setMainRoleId(Integer mainRoleId) {
        this.mainRoleId = mainRoleId;
    }

    /**
     * @return
     */
    public Integer getStatusId() {
        return statusId;
    }

    /**
     * @param statusId
     */
    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }
    public Integer getSubscriberStatusId() {
        return subscriberStatusId;
    }
    public void setSubscriberStatusId(Integer subscriberStatusId) {
        this.subscriberStatusId = subscriberStatusId;
    }
    public Integer getParentId() {
        return parentId;
    }
    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
    public Boolean getIsParent() {
        return isParent;
    }
    public void setIsParent(Boolean isParent) {
        this.isParent = isParent;
    }
    public Boolean getInvoiceChild() {
        return invoiceChild;
    }
    public void setInvoiceChild(Boolean invoiceChild) {
        this.invoiceChild = invoiceChild;
    }
    public Date getCreateDatetime() {
        return createDatetime;
    }
    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }
    public Integer getCurrencyId() {
        return currencyId;
    }
    public void setCurrencyId(Integer currencyId) {
        this.currencyId = currencyId;
    }
    public int getDeleted() {
        return deleted;
    }
    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }
    public int getFailedAttempts() {
        return failedAttempts;
    }
    public void setFailedAttempts(int failedAttempts) {
        this.failedAttempts = failedAttempts;
    }
    public int getUserId() {
        return id;
    }
    public void setUserId(int id) {
        this.id = id;
    }
    public Date getLastLogin() {
        return lastLogin;
    }
    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }
    public Date getLastStatusChange() {
        return lastStatusChange;
    }
    public void setLastStatusChange(Date lastStatusChange) {
        this.lastStatusChange = lastStatusChange;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public Integer getLanguageId() {
        return languageId;
    }
    public void setLanguageId(Integer languageId) {
        this.languageId = languageId;
    }
    public Integer getMainOrderId() {
        return mainOrderId;
    }
    public void setMainOrderId(Integer mainOrderId) {
        this.mainOrderId = mainOrderId;
    }

    public String[] getBlacklistMatches() {
        return blacklistMatches;
    }

    public void setBlacklistMatches(String[] blacklistMatches) {
        this.blacklistMatches = blacklistMatches;
    }

    public Boolean getUserIdBlacklisted() {
        return userIdBlacklisted;
    }

    public void setUserIdBlacklisted(Boolean userIdBlacklisted) {
        this.userIdBlacklisted = userIdBlacklisted;
    }

    public Integer[] getChildIds() {
        return childIds;
    }

    public void setChildIds(Integer[] childIds) {
        this.childIds = childIds;
    }

    public String getOwingBalance() {
        return owingBalance;
    }

    public BigDecimal getOwingBalanceAsDecimal() {
        if(owingBalanceAsDecimal != null)
            return owingBalanceAsDecimal;
        return (owingBalance == null ? null : new BigDecimal(owingBalance));
    }

    public void setOwingBalance(String owingBalance) {
        this.owingBalance = owingBalance;
    }

    /**
     * <strong>Note:</strong> Subsequent call to getOwingBalance returns value rounded to 2 decimals.
     * Use getOwingBalanceAsDecimal if precision is important, i.e. for calculations
     * @param quantity
     */
    public void setOwingBalance(BigDecimal owingBalance) {
        this.owingBalanceAsDecimal = owingBalance;
        if (owingBalance != null)
            this.owingBalance = owingBalance.setScale(Constants.BIGDECIMAL_SCALE_STR, Constants.BIGDECIMAL_ROUND).toString();
    }

    public Integer getBalanceType() {
        return balanceType;
    }

    public void setBalanceType(Integer balanceType) {
        this.balanceType = balanceType;
    }

    public String getCreditLimit() {
        return creditLimit;
    }

    public BigDecimal getCreditLimitAsDecimal() {
        if(creditLimitAsDecimal != null)
            return creditLimitAsDecimal;
        return (creditLimit == null ? null : new BigDecimal(creditLimit));
    }

    public void setCreditLimit(String creditLimit) {
        this.creditLimit = creditLimit;
    }

    /**
     * <strong>Note:</strong> Subsequent call to getCreditLimit returns value rounded to 2 decimals.
     * Use getCreditLimitAsDecimal if precision is important, i.e. for calculations
     * @param quantity
     */
    public void setCreditLimit(BigDecimal creditLimit) {
        this.creditLimitAsDecimal = creditLimit;
        if (creditLimit != null)
            this.creditLimit = creditLimit.setScale(Constants.BIGDECIMAL_SCALE_STR, Constants.BIGDECIMAL_ROUND).toString();
    }

    public String getDynamicBalance() {
        return dynamicBalance;
    }

    public BigDecimal getDynamicBalanceAsDecimal() {
        if(dynamicBalanceAsDecimal != null)
            return dynamicBalanceAsDecimal;
        return (dynamicBalance == null ? null : new BigDecimal(dynamicBalance));
    }
    
    public void setDynamicBalance(String dynamicBalance) {
        this.dynamicBalance = dynamicBalance;
    }

    /**
     * <strong>Note:</strong> Subsequent call to getBalance returns value rounded to 2 decimals.
     * Use getBalanceAsDecimal if precision is important, i.e. for calculations
     * @param quantity
     */
    public void setDynamicBalance(BigDecimal dynamicBalance) {
        this.dynamicBalanceAsDecimal = dynamicBalance;
        if (dynamicBalance != null)
            this.dynamicBalance = dynamicBalance.setScale(Constants.BIGDECIMAL_SCALE_STR, Constants.BIGDECIMAL_ROUND).toString();
    }

    public String getAutoRecharge() {
        return autoRecharge;
    }

    public BigDecimal getAutoRechargeAsDecimal() {
        if (autoRecharge == null) return null;
        return new BigDecimal(autoRecharge);
    }

    public void setAutoRecharge(String autoRecharge) {
        this.autoRecharge = autoRecharge;
    }

    /**
     * <strong>Note:</strong> Subsequent call to getAutoRecharge returns value rounded to 2 decimals.
     * Use getAutoRechargeAsDecimal if precision is important, i.e. for calculations
     * @param autoRecharge
     */
    public void setAutoRecharge(BigDecimal autoRecharge) {
        if (autoRecharge != null) {
            this.autoRecharge = autoRecharge.setScale(Constants.BIGDECIMAL_SCALE_STR, Constants.BIGDECIMAL_ROUND).toString();
            this.autoRechargeAsDecimal = autoRecharge.setScale(Constants.BIGDECIMAL_SCALE, Constants.BIGDECIMAL_ROUND);
        }
    }
}
