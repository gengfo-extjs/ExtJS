
package com.baobaotao.xfire.client;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

@WebService(name = "BbtForumServicePortType", targetNamespace = "http://www.baobaotao.com")
@SOAPBinding(use = SOAPBinding.Use.LITERAL, parameterStyle = SOAPBinding.ParameterStyle.WRAPPED)
public interface BbtForumServicePortType {


    @WebMethod(operationName = "getRefinedTopicCount", action = "")
    @WebResult(name = "out", targetNamespace = "http://www.baobaotao.com")
    public int getRefinedTopicCount(
        @WebParam(name = "in0", targetNamespace = "http://www.baobaotao.com")
        int in0);

}
