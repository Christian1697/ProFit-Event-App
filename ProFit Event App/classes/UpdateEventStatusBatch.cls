public class UpdateEventStatusBatch implements Database.Batchable<sObject> {
	
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String Query = 'Select Id, Name From Event__c Where Live__c = false AND Event_Status__c != \'Completed\' AND Event_End_Date_Time__c < LAST_N_MONTHS:4';
        return Database.getQueryLocator(Query);
        
    }

    public void execute(Database.BatchableContext batchContext, List<Event__c> eventList ){
        List<Event__c> dEvent = new List<Event__c>();
        for(Event__c evt: eventList){
            evt.Event_Status__c = 'Deleted';
            dEvent.add(evt);
        }
        update dEvent;
    }
    
    public void finish(Database.BatchableContext batchContext){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        email.setSubject('Batch Processing');
        List<String> toAddress = new List<String>();
        toAddress.add(Contact.Email__c);
        email.setToAddresses( toAddress );
        email.setSenderDisplayName('Christian Castor');
        
        email.setHtmlBody('The Event was deleted');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {email};
        Messaging.sendEmail(emails);
    }
}