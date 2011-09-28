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
 * Copyright Sapienter Enterprise Software
 */
package com.sapienter.jbilling.server.item;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import junit.framework.TestCase;

import com.sapienter.jbilling.server.order.OrderLineWS;
import com.sapienter.jbilling.server.order.OrderWS;
import com.sapienter.jbilling.server.util.Constants;
import com.sapienter.jbilling.server.util.api.JbillingAPI;
import com.sapienter.jbilling.server.util.api.JbillingAPIFactory;

/**
 * @author Emil
 */
public class WSItemDeleteTest  extends TestCase {
      

   
    
    public void testDeleteItem() {
        
    	try {
    		JbillingAPI api = JbillingAPIFactory.getAPI();
	    	
    		System.out.println("Getting item");
	    	ItemDTOEx[] item = api.getItemByCategory(new Integer(2300));
	    	if(item== null || item.length == 0){
	    		System.out.println("category 2300 NULL or empty!");
	    		return;
	    	}
	    	//assertEquals(item[0].getDeleted(), new Integer(0));
	    	Integer id=item[0].getId();    	   	
	    	
	    	System.out.println("Deleting item "+item[0].getId());
	    	api.deleteItem(item[0]);
	    
	    	ItemDTOEx[] itemDeleted = api.getItemByCategory(new Integer(2300));
	    	assertNotSame(itemDeleted[0].getId(), id);
	    	//delete category
	    	System.out.println("Deleting category 2300 ");
	    	api.deleteItemType(new Integer(2300));
	    	
	    	ItemDTOEx[] items = api.getItemByCategory(new Integer(2300));
	    	this.assertNull("deleted category 2300", items);
	    	System.out.println("Done!");
	    
	    	

    	} catch (Exception e) {
    		e.printStackTrace();
    		fail("Exception caught:" + e);
    	}
	}

   
    public static void assertEquals(BigDecimal expected, BigDecimal actual) {
        assertEquals(null, expected, actual);
    }

    public static void assertEquals(String message, BigDecimal expected, BigDecimal actual) {
        assertEquals(message,
                     (Object) (expected == null ? null : expected.setScale(2, RoundingMode.HALF_UP)),
                     (Object) (actual == null ? null : actual.setScale(2, RoundingMode.HALF_UP)));
    }
}
