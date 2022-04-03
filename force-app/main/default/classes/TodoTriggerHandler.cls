public class TodoTriggerHandler {
    
    public static void handleBeforeInsert(List<Todo__c> newList){
        
    }
    
    public static void handleBeforeUpdate(List<Todo__c> newList, Map<Id, Todo__c> newMap, List<Todo__c> oldList, Map<Id, Todo__c> oldMap){
    
        String name = '';
        String category = ''; 
        String priority = '';
        String id = '';
        for (Todo__c a: newList){
            name = a.Name;
            category = a.Category__c; 
            priority = a.Priority__c;
            if(a.ExternalID__c == null) {
            a.ExternalID__c = a.InternalID__c;
            }
            id = a.ExternalID__c;
            System.debug('Todo updated :'+a.Name +' ID = '+a.InternalID__c);
        }
        if (id != '') {
            todoUpdateFutureMethod(name, category, priority, id);
            System.debug('Future method called');
        } 
    }
    
    public static void handleBeforeDelete(List<Todo__c> oldList, Map<Id, Todo__c> oldMap){
       
        String id = '';
        for (Todo__c a: oldList){
            id = a.ExternalID__c;
            System.debug('Todo deleted : '+a.ExternalID__c);
        }
        if (id != '') {
            todoDeleteFutureMethod(id);
            System.debug('Future method called');
        } 
    } 
    
    public static void handleAfterInsert(List<Todo__c> newList, Map<Id, Todo__c> newMap){
        String name = '';
        String category = ''; 
        String priority = '';
        String id = '';
        for (Todo__c a: newList){
            name = a.Name;
            category = a.Category__c; 
            priority = a.Priority__c;
            id = a.InternalID__c;
            System.debug('Todo inserted :'+a.Name +' ID = '+a.InternalID__c);
        }
        if (id != '') {
            todoCreateFutureMethod(name, category, priority, id);
            System.debug('Future method called');
        } 
    } 
    
    public static void handleAfterUpdate(List<Todo__c> newList, Map<Id, Todo__c> newMap, List<Todo__c> oldList, Map<Id, Todo__c> oldMap){
        
    } 
    
    public static void handleAfterDelete(List<Todo__c> oldList, Map<Id, Todo__c> oldMap){
        
    } 
    
    public static void handleAfterUndelete(List<Todo__c> newList, Map<Id, Todo__c> newMap){
        
    } 
    
    //-----------------------Future methods calls---------------------------------------------------------------//  
    @future(callout=true)
    public static void todoCreateFutureMethod(String name, String category, String priority, String id){
        HttpResponse results = TodoRestCalloutClass.createTodo(name, category, priority, id);
        System.debug(results);
    }
    
    @future(callout=true)
    public static void todoDeleteFutureMethod(String id){
        HttpResponse results = TodoRestCalloutClass.DeleteTodoById(id);
        System.debug(results);
    }
    
    @future(callout=true)
    public static void todoUpdateFutureMethod(String name, String category, String priority, String id){
        HttpResponse results = TodoRestCalloutClass.patchTodo(name, category, priority, id);
        System.debug(results);
    }
    //-------------------------------------------------------------------------------------------------------------//
}