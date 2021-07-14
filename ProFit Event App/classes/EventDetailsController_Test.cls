@isTest
public with sharing class EventDetailsController_Test {
    static Id createTestEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event 5';
        evt.Event_Start_Date_Time__c = datetime.newInstance(2021, 6, 26, 19, 30, 0);
        evt.Event_End_Date_Time__c = datetime.newInstance(2021, 6, 28, 20, 30, 0);
        evt.Max_Seats__c = 5;
        evt.Live__c = true;
        insert evt;
        return evt.Id;
    }
    static Id createTestSpeaker(){
        Speaker__c spk = new Speaker__c();
        spk.Name = 'Test Speaker 5';
        insert spk;
        return spk.Id;
    }
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee 5';
        insert att;
        return att.Id;
    }
    @IsTest
    static void testSpeaker(){
        
        Test.startTest();
        String recId;
        Event_Speaker__c eSpeaker = new Event_Speaker__c();
        eSpeaker.Event_List__c = createTestEvent();
        eSpeaker.Speaker__c = createTestSpeaker();
        eSpeaker.Name = 'Test Name 5';
        Event_Speaker__c name;
        String str = '';
        insert eSpeaker;
        List<Event_Speaker__c> retrievedSpeaker = EventDetailsController.getSpeakers(eSpeaker.Event_List__c);
        name = retrievedSpeaker.get(0);
        Test.stopTest();
        System.assertEquals('Test Name 5',name.Name);
    }
    @IsTest
    static void testLocation(){
        Test.startTest();
        String recId = createTestEvent();
        Event__c evts = EventDetailsController.getLocationDetails(recId);
        Test.stopTest();
        System.assertEquals('Test Event 5',evts.Name__c);
    }
    @isTest
    static void testAttendee(){
        Test.startTest();
        Event_Attendee__c eAttendee = new Event_Attendee__c();
        eAttendee.Attendee__c = createTestAttendee();
        eAttendee.Event_List__c = createTestEvent();
        eAttendee.Name = 'Test Attendee 5';
        insert eAttendee;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = EventDetailsController.getAttendees(eAttendee.Event_List__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test Attendee 5', name.Name);
    }
}