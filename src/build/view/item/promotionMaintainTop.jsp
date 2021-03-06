<%--
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
--%>

<%@ page language="java" import="com.sapienter.jbilling.client.util.Constants"%>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/taglib.tld" prefix="jbilling" %>


<logic:notPresent parameter="confirm">
	<p class="title"> <bean:message key="promotion.edit.title"/> </p>
	<p class="instr"> <bean:message key="promotion.edit.instr"/></p>

   <logic:notPresent parameter="create">
   <html:link page="/item/promotionMaintain.jsp?confirm=do">
   	  <bean:message key="all.prompt.delete" />
   	</html:link>
   </logic:notPresent>
</logic:notPresent>

<logic:present parameter="confirm">
	<logic:equal parameter="confirm" value="do">
		  <p>
		      <bean:message key="promotion.delete.confirm"/> <br/>
              <html:link page="/promotionMaintain.do?action=delete&mode=promotion">
              	   <bean:message key="all.prompt.yes"/>
              </html:link><br/>
              <html:link page="/item/promotionMaintain.jsp?confirm=no">
              	   <bean:message key="all.prompt.no"/>
              </html:link><br/>
   	    </p>
	</logic:equal>
	
	<logic:equal parameter="confirm" value="yes">
          <p><bean:message key="promotion.delete.done"/></p>
	</logic:equal>	
	<logic:equal parameter="confirm" value="no">
          <p><bean:message key="promotion.delete.notDone"/></p>
	</logic:equal>	
</logic:present>
