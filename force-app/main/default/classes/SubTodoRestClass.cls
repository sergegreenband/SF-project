@RestResource(urlMapping='/SubTodos/*')
global with sharing class SubTodoRestClass {
    
    @HttpGet
    global static Sub_Todo__c  getSubTodo() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String subtodoID = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Sub_Todo__c  result =  [SELECT Id, 
                                Name,
                                ExternalID__c 
                                FROM Sub_Todo__c 
                                WHERE ExternalID__c = :subtodoID ];
        return result;
    }
    
    @HttpPost
    global static String createSubTodo(String name, String todoId, String id) {
        Todo__c Todo =  [SELECT Id, ExternalID__c 
                         FROM Todo__c
                         WHERE ExternalID__c = :todoId ];
        String todoRealID  = (String) Todo.Id;
        Sub_Todo__c thisSubTodo = new Sub_Todo__c(
            Name=name,
            Todo__c = todoRealID,
            Status__c = false,
            ExternalID__c = id);
        insert thisSubTodo;
        return thisSubTodo.ExternalID__c;
    }   
    
    @HttpDelete
    global static void deleteSubTodo() {
        RestRequest request = RestContext.request;
        String subtodoID = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Sub_Todo__c thisSubTodo = [SELECT Id, ExternalID__c FROM Sub_Todo__c WHERE ExternalID__c = :subtodoID];
        delete thisSubTodo;
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
    global static String updateSubTodoFields() {
        RestRequest request = RestContext.request;
        String subtodoID = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Sub_Todo__c thisSubTodo = [SELECT Id, ExternalID__c FROM Sub_Todo__c WHERE ExternalID__c = :subtodoID];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        // Iterate through each parameter field and value
        for(String fieldName : params.keySet()) {
            // Set the field and value on the Account sObject
            thisSubTodo.put(fieldName, params.get(fieldName));
        }
        update thisSubTodo;
        return thisSubTodo.ExternalID__c;
    }    
}