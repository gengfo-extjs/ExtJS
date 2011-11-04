/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.developers.blog.easymockexample;

import org.easymock.*;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

/**
 *
 * @author rafsob
 */


public class EasyMockTest {

    private IMultiplicationService multiplicatorServiceMock;
    private CalculationManager calculationManager;

    @Before
    public void setUp() throws Exception {
        multiplicatorServiceMock = EasyMock.createMock(IMultiplicationService.class);
        calculationManager = new CalculationManager();
        calculationManager.setMultiplicatorService(multiplicatorServiceMock);
    }

    @Test
    public void testCalculationManager() {
        Integer oneProductPrice = 12;
        Integer amount = 3;
        Integer reduction = 6;

        //inject behaviour of MultiplicatorService
        EasyMock.expect(multiplicatorServiceMock
                .multiply(oneProductPrice, amount))
                .andReturn(oneProductPrice * amount); 

        //setting up the mock
        EasyMock.replay(multiplicatorServiceMock);

        //object to be tested
        Integer result =
                calculationManager.calculatePrice(oneProductPrice, amount, reduction);
        Assert.assertEquals(result, oneProductPrice * amount - reduction);

        EasyMock.verify(multiplicatorServiceMock);

    }
}
