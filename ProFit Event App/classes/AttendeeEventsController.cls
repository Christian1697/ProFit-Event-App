public with sharing class AttendeeEventsController {
    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> futureEvents(String attendeeId) {
        List<Event_Attendee__c> eventLists = 
        [SELECT 
        Id, 
        Name, 
        Event_List__c, 
        Event_List__r.Name__c, 
        Event_List__r.Location_List__r.Name,
        Event_List__r.Event_Start_Date_Time__c, 
        Event_List__r.Event_End_Date_Time__c 
        FROM Event_Attendee__c 
        WHERE Attendee__c = :attendeeId 
        AND Event_List__r.Event_Start_Date_Time__c >= today ];
        return eventLists;

    }

    @AuraEnabled(cacheable=true)
    public static List<Event_Attendee__c> pastEvents(String attendeeId) {
        List<Event_Attendee__c> eventLists = 
        [SELECT 
        Id, 
        Name, 
        Event_List__c, 
        Event_List__r.Name__c, 
        Event_List__r.Location_List__r.Name,
        Event_List__r.Event_Start_Date_Time__c, 
        Event_List__r.Event_End_Date_Time__c 
        FROM Event_Attendee__c 
        WHERE Attendee__c = :attendeeId 
        AND Event_List__r.Event_Start_Date_Time__c < today ];
        return eventLists;
    }
}