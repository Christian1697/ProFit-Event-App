@isTest

public with sharing class EventAttendeeHandler_Test {
    @testSetup
    public static void setupData(){
        
        Event_Organizer__c  eOrg = new Event_Organizer__c (
            Name = 'Christian Castor',
            Phone__c = '123123456',
            Email__c = 'ian.dominic.castor@gmail.com'
        );
        insert eOrg;
        
        Event__c event = new Event__c(
            Name__c = 'Test',
            Event_Organizer__c  = eOrg.Id,
            Event_Type__c = 'Virtual',
            Frequency__c  = 'Daily',
            Max_Seats__c  = 10,
            Recurring__c = true,
            Live__c = true,
            Event_Start_Date_Time__c = System.now(),
            Event_End_Date_Time__c  = System.now().addDays(3)
        );
        insert event;
        
        Attendee__c att = new Attendee__c(
            Name = 'Ian Castor',
            Email__c = 'dominicdcastor@gmail.com',
            Phone__c = '312312321'
        );
        insert att;
        
        Event_Attendee__c evtAtt = new Event_Attendee__c(
            Event_List__c = event.Id, 
            Attendee__c = att.Id
        );
        insert evtAtt;
    }

    @IsTest
    static void sendEmailTest(){
        test.startTest();
        try{
            integer i = 10/0;
        }catch(System.Exception ex){

        }
        Test.stopTest();
    }
   
}