
package com.baobaotao.xfire.client;

import java.net.MalformedURLException;
import java.util.Collection;
import java.util.HashMap;
import javax.xml.namespace.QName;
import org.codehaus.xfire.XFireRuntimeException;
import org.codehaus.xfire.aegis.AegisBindingProvider;
import org.codehaus.xfire.annotations.AnnotationServiceFactory;
import org.codehaus.xfire.annotations.jsr181.Jsr181WebAnnotations;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.jaxb2.JaxbTypeRegistry;
import org.codehaus.xfire.service.Endpoint;
import org.codehaus.xfire.service.Service;
import org.codehaus.xfire.soap.AbstractSoapBinding;
import org.codehaus.xfire.transport.TransportManager;

public class BbtForumServiceClient {

    private static XFireProxyFactory proxyFactory = new XFireProxyFactory();
    private HashMap endpoints = new HashMap();
    private Service service0;

    public BbtForumServiceClient() {
        create0();
        Endpoint BbtForumServiceHttpPortEP = service0 .addEndpoint(new QName("http://www.baobaotao.com", "BbtForumServiceHttpPort"), new QName("http://www.baobaotao.com", "BbtForumServiceHttpBinding"), "http://localhost:8080/baobaotao/service/BbtForumService");
        endpoints.put(new QName("http://www.baobaotao.com", "BbtForumServiceHttpPort"), BbtForumServiceHttpPortEP);
        Endpoint BbtForumServicePortTypeLocalEndpointEP = service0 .addEndpoint(new QName("http://www.baobaotao.com", "BbtForumServicePortTypeLocalEndpoint"), new QName("http://www.baobaotao.com", "BbtForumServicePortTypeLocalBinding"), "xfire.local://BbtForumService");
        endpoints.put(new QName("http://www.baobaotao.com", "BbtForumServicePortTypeLocalEndpoint"), BbtForumServicePortTypeLocalEndpointEP);
    }

    public Object getEndpoint(Endpoint endpoint) {
        try {
            return proxyFactory.create((endpoint).getBinding(), (endpoint).getUrl());
        } catch (MalformedURLException e) {
            throw new XFireRuntimeException("Invalid URL", e);
        }
    }

    public Object getEndpoint(QName name) {
        Endpoint endpoint = ((Endpoint) endpoints.get((name)));
        if ((endpoint) == null) {
            throw new IllegalStateException("No such endpoint!");
        }
        return getEndpoint((endpoint));
    }

    public Collection getEndpoints() {
        return endpoints.values();
    }

    private void create0() {
        TransportManager tm = (org.codehaus.xfire.XFireFactory.newInstance().getXFire().getTransportManager());
        HashMap props = new HashMap();
        props.put("annotations.allow.interface", true);
        AnnotationServiceFactory asf = new AnnotationServiceFactory(new Jsr181WebAnnotations(), tm, new AegisBindingProvider(new JaxbTypeRegistry()));
        asf.setBindingCreationEnabled(false);
        service0 = asf.create((com.baobaotao.xfire.client.BbtForumServicePortType.class), props);
        {
            AbstractSoapBinding soapBinding = asf.createSoap11Binding(service0, new QName("http://www.baobaotao.com", "BbtForumServicePortTypeLocalBinding"), "urn:xfire:transport:local");
        }
        {
            AbstractSoapBinding soapBinding = asf.createSoap11Binding(service0, new QName("http://www.baobaotao.com", "BbtForumServiceHttpBinding"), "http://schemas.xmlsoap.org/soap/http");
        }
    }

    public BbtForumServicePortType getBbtForumServiceHttpPort() {
        return ((BbtForumServicePortType)(this).getEndpoint(new QName("http://www.baobaotao.com", "BbtForumServiceHttpPort")));
    }

    public BbtForumServicePortType getBbtForumServiceHttpPort(String url) {
        BbtForumServicePortType var = getBbtForumServiceHttpPort();
        org.codehaus.xfire.client.Client.getInstance(var).setUrl(url);
        return var;
    }

    public BbtForumServicePortType getBbtForumServicePortTypeLocalEndpoint() {
        return ((BbtForumServicePortType)(this).getEndpoint(new QName("http://www.baobaotao.com", "BbtForumServicePortTypeLocalEndpoint")));
    }

    public BbtForumServicePortType getBbtForumServicePortTypeLocalEndpoint(String url) {
        BbtForumServicePortType var = getBbtForumServicePortTypeLocalEndpoint();
        org.codehaus.xfire.client.Client.getInstance(var).setUrl(url);
        return var;
    }
}
