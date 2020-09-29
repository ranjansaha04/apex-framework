public class RestCalloutRequest{
    public HttpRequest httpRequest{get;private set;}
    public Http httpInstance {get;private set;}
    public HttpResponse httpResponse {get;private set;}
    
    //HttpRequest attributes    
    private String endpoint;
    private String method;
    private Map<String,String> headers;
    private String body;
    private Blob blobBody;
    private Dom.Document document;
    private String certDevName;
    private Boolean isCompressed;
    private Integer timeout;
    
    public RestCalloutRequest(){
        this.httpRequest = new HttpRequest(); 
        this.httpResponse = new HttpResponse();
        this.httpInstance = new Http(); 
        this.headers = new Map<String,String>();
    }
    
    public RestCalloutRequest setEndPoint (String endpoint){
        this.endpoint = endpoint;
        return this;
    }
    
    public RestCalloutRequest setMethod (String method){
        this.method = method;
        return this;
    }
    
    public RestCalloutRequest addHeader(String key, String value){
        this.headers.put(key,value);
        return this;
    }
    
    public RestCalloutRequest addHeaders(Map<String,String> headersMap){
        for( String header : headersMap.keySet()) {                        
            this.headers.put(header,headersMap.get(header));
        }
        return this;
    }
    
    public RestCalloutRequest setBody(String bodyStr){
        this.body = bodyStr;
        return this;
    }
    
    public RestCalloutRequest setBlobBody(Blob bodyBlob){
        this.blobBody = bodyBlob;
        return this;
    }
    
    public RestCalloutRequest setDocument(Dom.Document document){
        this.document = document;
        return this;
    }
    
    public RestCalloutRequest setCertificate(String certDevNameStr){
        this.certDevName = certDevNameStr;
        return this;
    }
    
    public RestCalloutRequest compress(Boolean isCompressed){
        this.isCompressed = isCompressed;
        return this;
    }
    
    public RestCalloutRequest setTimeOut(Integer timeout){
        this.timeout = timeout;
        return this;
    }
    
    public RestCalloutRequest buildRequest() {
        
        if(String.isBlank(this.endpoint)) throw new RestCalloutRequestException('Endpoint not found!');
        if(String.isBlank(this.method)) throw new RestCalloutRequestException('Method not found!');    
        if(this.timeout > 120000) throw new RestCalloutRequestException('Timeout maximum exceeded!');
        
        this.httpRequest.setEndpoint(this.endpoint);      
        this.httpRequest.setMethod(this.method);  
        //set http headers  
        if(!this.headers.isEmpty()){
            for(String header : headers.keySet()){                        
                this.httpRequest.setHeader(header,headers.get(header));
            }
        }  
        if(String.isNotBlank(this.body)){
            this.httpRequest.setBody(this.body);
        }
        if(this.timeout!=null){
            this.httpRequest.setTimeout(this.timeout);
        }
        if(String.isNotBlank(this.certDevName)){
            this.httpRequest.setClientCertificateName(this.certDevName);
        }
        if(this.isCompressed!=null){
            this.httpRequest.setCompressed(this.isCompressed);
        }
        if(this.blobBody!=null){
            this.httpRequest.setBodyAsBlob(this.blobBody);
        }
        if(this.document!=null){
            this.httpRequest.setBodyDocument(this.document);
        }
        return this;
    }
        
    public HttpResponse sendRequest() {
        try{
            this.httpResponse = this.httpInstance.send(this.httpRequest);
        }
        catch(Exception ex){
            throw new RestCalloutRequestException(ex.getMessage()); 
        }
        return this.httpResponse;
    }
    public class RestCalloutRequestException extends Exception {}
}