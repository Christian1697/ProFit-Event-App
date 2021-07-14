@isTest
public with sharing class AttendeeEventsController_Test {
    static Id createTestNewEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Event_Start_Date_Time__c = datetime.newInstance(2021, 6, 26, 19, 30, 0);
        evt.Event_End_Date_Time__c = datetime.newInstance(2021, 6, 28, 20, 30, 0);
        evt.Max_Seats__c = 5;
        evt.Live__c = true;
        insert evt;
        return evt.Id;
    }
    static Id createTestOldEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Event_Start_Date_Time__c = datetime.newInstance(2020, 6, 26, 19, 30, 0);
        evt.Event_End_Date_Time__c = datetime.newInstance(2020, 6, 28, 20, 30, 0);
        evt.Max_Seats__c = 5;
        evt.Live__c = true;
        insert evt;
        return evt.Id;
    }
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        insert att;
        return att.Id;
    }
    @isTest
    static void testFutureEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event_List__c = createTestNewEvent();
        eA.Attendee__c = createTestAttendee();
        eA.Name = 'Test Event Attendee';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeEventsController.futureEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test Event Attendee', name.Name);
    }
    @isTest
    static void testPastEvents(){
        Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event_List__c = createTestOldEvent();
        eA.Attendee__c = createTestAttendee();
        eA.Name = 'Test Event Attendee';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeEventsController.pastEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test Event Attendee', name.Name);
    }
}