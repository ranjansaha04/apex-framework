/************************************************************************************
Apex Class Name     : MockHttpResponseGenerator
Version             : 1.0
Function            : HttpCalloutMock for testing webservices/callouts.
Author              : 
*************************************************************************************/
@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock {
    private String stringBody;
    private Integer statusCode;
    private Map<String,String> headerValuesByName;
    private MockHttpResponseGenerator (String body,Integer statusCode,Map<String,String> headerValuesByName){
        this.stringBody = body;
        this.statusCode = statusCode;
        this.headerValuesByName = headerValuesByName;
    }
    
    // Implement this interface method
    public HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        for(String headerName : headerValuesByName.keySet()){
            res.setHeader(headerName, headerValuesByName.get(headerName));
        }
        res.setBody(stringBody);
        res.setStatusCode(statusCode);
        return res;
    }
}