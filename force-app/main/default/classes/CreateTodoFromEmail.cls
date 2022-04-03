global class CreateTodoFromEmail implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                         Messaging.InboundEnvelope env){
                                                             
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    
    List <Todo__c> newTodo = new List <Todo__c> ();                                                         
                                                
    newTodo.add(new Todo__c(
                Name = email.plainTextBody,
                Category__c = 'Later',
                Priority__c = 'low',
                Status__c = 'draft'
    ));
                                                             
    insert newTodo;                                                             
                                                             
    result.success = true;
    return result;                                                    
    
    }
}