public class SubTodoTriggerHandler {
    
    public static void handleBeforeInsert(List<Sub_Todo__c> newList){
        
    }
    
    public static void handleBeforeUpdate(List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap, List<Sub_Todo__c> oldList, Map<Id, Sub_Todo__c> oldMap){
        
        String name = '';
        Boolean status = false; 
        String id = '';
        for (Sub_Todo__c a: newList){
            name = a.Name;
            status = a.Status__c;
            if(a.ExternalID__c == null) {
            a.ExternalID__c = a.InternalID__c;
            }
            id = a.ExternalID__c;
            System.debug('SubTodo updated :'+a.Name +' ID = '+a.ExternalID__c);
        }
        if (id != '') {
            subTodoUpdateFutureMethod(name, status, id);
            System.debug('Future method called');
        } 
        
    }
    
    public static void handleBeforeDelete(List<Sub_Todo__c> oldList, Map<Id, Sub_Todo__c> oldMap){
        
        String id = '';
        for (Sub_Todo__c a: oldList){
            if(a.ExternalID__c == null) {
            id = a.InternalID__c;
            } else {
            id = a.ExternalID__c;
            }
            
            System.debug('SubTodo deleted : '+id);
        }
        if (id != '') {
            subTodoDeleteFutureMethod(id);
            System.debug('Future method called');
        }
        
    } 
    
    public static void handleAfterInsert(List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap){
        
        String name = '';
        String id = '';
        String todoId = '';
        String todoRealId ='';
        for (Sub_Todo__c a: newList){
            name = a.Name;
            todoRealId = a.Todo__c;
            id = a.InternalID__c;
            System.debug('SubTodo inserted :'+a.Name +' ID = '+a.InternalID__c+ ' for TODO '+a.Todo__c);
        }
        if (id != '') {
            Todo__c Todo = [SELECT Id, ExternalID__c 
                            FROM Todo__c
                            WHERE Id = :todoRealId ];
            todoId  = (String) Todo.ExternalID__c;
            subTodoCreateFutureMethod(name, todoId, id);
            System.debug('Future method called');
        } 
        
    } 
    
    public static void handleAfterUpdate(List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap, List<Sub_Todo__c> oldList, Map<Id, Sub_Todo__c> oldMap){
        
    } 
    
    public static void handleAfterDelete(List<Sub_Todo__c> oldList, Map<Id, Sub_Todo__c> oldMap){
        
    } 
    
    public static void handleAfterUndelete(List<Sub_Todo__c> newList, Map<Id, Sub_Todo__c> newMap){
        
    } 
    
    //-----------------------Future methods calls---------------------------------------------------------------//  
    @future(callout=true)
    public static void subTodoCreateFutureMethod(String name, String todoId, String id){
        HttpResponse results = SubTodoRestCalloutClass.createSubTodo(name, todoId, id);
        System.debug(results);
    }
    
    @future(callout=true)
    public static void subTodoDeleteFutureMethod(String id){
        HttpResponse results = SubTodoRestCalloutClass.DeleteSubTodoById(id);
        System.debug(results);
    }
    
    @future(callout=true)
    public static void subTodoUpdateFutureMethod(String name, Boolean status, String id){
        HttpResponse results = SubTodoRestCalloutClass.patchSubTodo(name, status, id);
        System.debug(results);
    }
    //-------------------------------------------------------------------------------------------------------------//
}