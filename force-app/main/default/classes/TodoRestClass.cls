@RestResource(urlMapping='/Todos/*')
    global with sharing class TodoRestClass {
        
        @HttpGet
        global static Todo__c getTodo() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String todoID = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Todo__c result =  [SELECT Id, 
                                  Name,
                                  ExternalID__c 
                        FROM Todo__c
                        WHERE ExternalID__c = :todoID ];
        return result;
    }
        
        @HttpPost
        global static String createTodo(String name, String category, String priority, String id) {
            Todo__c thisTodo = new Todo__c(
                Name=name,
            	Category__c = category,
                Priority__c = priority,
            	Status__c = 'draft',
            	ExternalID__c = id);
            insert thisTodo;
            String todoid = thisTodo.Id;
            Todo__c thatTodo = [SELECT Id, InternalID__c FROM Todo__c WHERE Id=:todoid];
            String internalid = thatTodo.InternalID__c;
            return internalid;
        }   
        
        @HttpDelete
        global static void deleteTodo() {
            RestRequest request = RestContext.request;
            String todoID = request.requestURI.substring(
                request.requestURI.lastIndexOf('/')+1);
            Todo__c thisTodo = [SELECT Id, ExternalID__c FROM Todo__c WHERE ExternalID__c = :todoID];
            delete thisTodo;
        }   
        
        @HttpPut
        global static String upsertTodo(String name, String id) {
            Todo__c thisTodo = new Todo__c(   
                	Id=id,
                // ExternalID__c=id,
                    Name=name);
            // Match acc by Id, if present.
            // Otherwise, create new acc.
            upsert thisTodo;
            // Return the acc ID.
            return thisTodo.ExternalID__c;
        }
        
        @HttpPatch
        global static String updateTodoFields() {
            RestRequest request = RestContext.request;
            String todoID = request.requestURI.substring(
                request.requestURI.lastIndexOf('/')+1);
            Todo__c thisTodo = [SELECT Id, ExternalID__c FROM Todo__c WHERE ExternalID__c = :todoID];
            // Deserialize the JSON string into name-value pairs
            Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
            // Iterate through each parameter field and value
            for(String fieldName : params.keySet()) {
                // Set the field and value on the Account sObject
                thisTodo.put(fieldName, params.get(fieldName));
            }
            update thisTodo;
            return thisTodo.ExternalID__c;
        }    
    }