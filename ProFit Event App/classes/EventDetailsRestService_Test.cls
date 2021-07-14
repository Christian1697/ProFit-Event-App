@istest
public with sharing class EventDetailsRestService_Test {
    static Id createEventTestRecord(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Record REST Service';
        evt.Event_Start_Date_Time__c = datetime.newInstance(2021, 6, 26, 11, 00, 0);
        evt.Event_End_Date_Time__c = datetime.newInstance(2021, 6, 27, 12, 00, 0);
        evt.Event_Type__c ='Virtual';
        evt.Live__c = true;
        evt.Event_Status__c = 'Created';
        insert evt;
        return evt.Id;
    }
    @IsTest
    static void doGetTest(){
        Test.startTest();
            Id EventId =  createEventTestRecord();
            RestRequest req = new RestRequest();
            req.requestURI = 'abctechnologies2--capstonesb.my.salesforce.com/services/apexrest/api/Event__c/'+EventId;
            req.httpMethod = 'GET';
            RestContext.request = req;
            Event__c evt = EventDetailsRestService.doGetEvt();
            System.assertEquals(EventId, evt.Id);
        Test.stopTest();
    }
}