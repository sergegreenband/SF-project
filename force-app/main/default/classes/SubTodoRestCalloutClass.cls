public class SubTodoRestCalloutClass {
    static HttpRequest tokenRequest = new HttpRequest();
    static Credentials_api_2__c cred = Credentials_api_2__c.getInstance(UserInfo.getUserId());
        static  String CLIENT_ID = cred.login__c;
        static  String CLIENT_SECRET = cred.client_secret__c;
        static  String USERNAME = cred.username__c;
        static  String PASSWORD = cred.password__c;
    
    public static HttpResponse GetSubTodoById(String id) {
        try{
            tokenRequest.setMethod('POST');
            tokenRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token');
            tokenRequest.setBody('grant_type=password' + '&client_id='+CLIENT_ID + 
                                 '&client_secret='+CLIENT_SECRET + '&username='+USERNAME + '&password='+PASSWORD);
            
            Http http1 = new Http();
            HttpResponse responseToken = http1.send(tokenRequest);
            Map<String, Object> authMap = (Map<String, Object>) JSON.deserializeUntyped(responseToken.getBody());
            system.debug(' response Status :'+ responseToken.getStatus()+' response StatusCode :'+responseToken.getStatusCode());
            system.debug(' responseToken :'+ responseToken.getBody());
            
            String endpoint = authMap.get('instance_url') + '/services/apexrest/SubTodos/'+String.valueOf(id);
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + authMap.get('access_token')); 
            request.setHeader('accept','application/json');
            request.setEndpoint(endpoint);
            request.setMethod('GET');
            Http http = new Http();
            HTTPresponse res= http.send(request);
            Map<String, Object> authMap2 = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            String todoGetName = (String)authMap2.get('Name');
            String todoGetID = (String)authMap2.get('ExternailID__c');
            String todoGetStatus = (String)authMap2.get('Status__c');
            system.debug(' response Status :'+ res.getStatus()+' response StatusCode :'+res.getStatusCode());
            system.debug(' Response : '+ res.getBody());
            system.debug(' Received a Todo : ' +'\n' +
                         'ID = ' + todoGetID +'\n' +
                         'Name = ' + todoGetName +'\n' +
                         'Status = ' + todoGetStatus +'\n' 
                        );
            return res;
        } catch(exception e){
            System.debug('ERROR: '+ e.getMessage());
            return null;
        }
    }
    
    public static HttpResponse createSubTodo(String name, String todoId, String id) {
        try{
        
            tokenRequest.setMethod('POST');
            tokenRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token');
            tokenRequest.setBody('grant_type=password' + '&client_id='+CLIENT_ID + 
                                 '&client_secret='+CLIENT_SECRET + '&username='+USERNAME + '&password='+PASSWORD);
            
            Http http1 = new Http();
            HttpResponse responseToken = http1.send(tokenRequest);
            Map<String, Object> authMap = (Map<String, Object>) JSON.deserializeUntyped(responseToken.getBody());
            system.debug(' response Status :'+ responseToken.getStatus()+' response StatusCode :'+responseToken.getStatusCode());
            system.debug(' responseToken :'+ responseToken.getBody());
                
            String endpoint = authMap.get('instance_url') + '/services/apexrest/SubTodos/';
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + authMap.get('access_token')); 
            request.setHeader('accept','application/json');
            request.setEndpoint(endpoint);
            String jsonInput = '{' + '"name" : ' + '"'+name + '",' + '"todoId" : ' + '"'+todoId + '",' + '"id" : ' + '"'+id + '"' + '}';
            system.debug(jsonInput);
            request.setBody(jsonInput);//Send JSON body
            request.setMethod('POST');
            Http http = new Http();
            HTTPresponse res= http.send(request);
            system.debug(' response Status :'+ res.getStatus()+' response StatusCode :'+res.getStatusCode());
            system.debug(' Response : new SubTodo ID = '+ res.getBody());
            return res;
        } catch(exception e){
            System.debug('ERROR: '+ e.getMessage());
            return null;
        }
    }
    
     public static HttpResponse DeleteSubTodoById(String id) {
        try{
            tokenRequest.setMethod('POST');
            tokenRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token');
            tokenRequest.setBody('grant_type=password' + '&client_id='+CLIENT_ID + 
                                 '&client_secret='+CLIENT_SECRET + '&username='+USERNAME + '&password='+PASSWORD);
            
            Http http1 = new Http();
            HttpResponse responseToken = http1.send(tokenRequest);
            Map<String, Object> authMap = (Map<String, Object>) JSON.deserializeUntyped(responseToken.getBody());
            system.debug(' response Status :'+ responseToken.getStatus()+' response StatusCode :'+responseToken.getStatusCode());
            system.debug(' responseToken :'+ responseToken.getBody());

            String endpoint = authMap.get('instance_url') + '/services/apexrest/SubTodos/'+String.valueOf(id);
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + authMap.get('access_token')); 
            request.setHeader('accept','application/json');
            request.setEndpoint(endpoint);
            request.setMethod('DELETE');
            Http http = new Http();
            HTTPresponse res= http.send(request);
            system.debug(' response Status :'+ res.getStatus()+' response StatusCode :'+res.getStatusCode());
            system.debug(' Response : '+ res);

            return res;
        } catch(exception e){
            System.debug('ERROR: '+ e.getMessage());
            return null;
        }
    }
    
     public static HttpResponse putAccount(String name, String rating, String id) {
        try{
            tokenRequest.setMethod('POST');
            tokenRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token');
            tokenRequest.setBody('grant_type=password' + '&client_id='+CLIENT_ID + 
                                 '&client_secret='+CLIENT_SECRET + '&username='+USERNAME + '&password='+PASSWORD);
            
            Http http1 = new Http();
            HttpResponse responseToken = http1.send(tokenRequest);
            Map<String, Object> authMap = (Map<String, Object>) JSON.deserializeUntyped(responseToken.getBody());
            system.debug(' response Status :'+ responseToken.getStatus()+' response StatusCode :'+responseToken.getStatusCode());
            system.debug(' responseToken :'+ responseToken.getBody());
            
            
            String endpoint = authMap.get('instance_url') + '/services/apexrest/Accounts/';
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + authMap.get('access_token')); 
            request.setHeader('accept','application/json');
            request.setEndpoint(endpoint);
            String jsonInput = '';
            if (id!=null){
            jsonInput = '{' +'"id" : ' +id + ','+ '"name" : ' + '"'+name + '",' + '"rating" : ' + '"'+rating + '"' + '}';
            } else 
            jsonInput = '{' + '"name" : ' + '"'+name + '",' + '"rating" : ' + '"'+rating + '"' + '}';   
            system.debug(jsonInput);
			request.setBody(jsonInput);//Send JSON body
            request.setMethod('PUT');
            Http http = new Http();
            HTTPresponse res= http.send(request);         
            system.debug(' response Status :'+ res.getStatus()+' response StatusCode :'+res.getStatusCode());
            system.debug(' Upserted : '+ res.getBody());
            return res;
        } catch(exception e){
            System.debug('ERROR: '+ e.getMessage());
            return null;
        }
    }
    
    public static HttpResponse patchSubTodo(String name, Boolean status, String id) {
        try{
            tokenRequest.setMethod('POST');
            tokenRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token');
            tokenRequest.setBody('grant_type=password' + '&client_id='+CLIENT_ID + 
                                 '&client_secret='+CLIENT_SECRET + '&username='+USERNAME + '&password='+PASSWORD);
            
            Http http1 = new Http();
            HttpResponse responseToken = http1.send(tokenRequest);
            Map<String, Object> authMap = (Map<String, Object>) JSON.deserializeUntyped(responseToken.getBody());
            system.debug(' response Status :'+ responseToken.getStatus()+' response StatusCode :'+responseToken.getStatusCode());
            system.debug(' responseToken :'+ responseToken.getBody());
            
            String endpoint = authMap.get('instance_url') + '/services/apexrest/SubTodos/'+String.valueOf(id);
            HttpRequest request = new HttpRequest();
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Authorization', 'Bearer ' + authMap.get('access_token')); 
            request.setHeader('accept','application/json');
            request.setEndpoint(endpoint);
            String jsonInput = '{' + '"Name" : ' + '"'+name + '",' + '"Status__c" : ' + status + '}';
            system.debug(jsonInput);
			request.setBody(jsonInput);//Send JSON body
            request.setMethod('PATCH');
            Http http = new Http();
            HTTPresponse res= http.send(request);         
            system.debug(' response Status :'+ res.getStatus()+' response StatusCode :'+res.getStatusCode());
            system.debug(' SubTodo Updated : '+ res.getBody());
            return res;
        } catch(exception e){
            System.debug('ERROR: '+ e.getMessage());
            return null;
        }
    }
    
}