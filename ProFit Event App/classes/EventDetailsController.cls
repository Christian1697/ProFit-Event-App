public with sharing class EventDetailsController {
@AuraEnabled
  public static List<Event_Speaker__c> getSpeakers(String eventId) {
    List<Event_Speaker__c> speakerList = [
        SELECT  Id, 
                Name,
                Speaker__c,
                Speaker__r.Name,
                Speaker__r.Phone__c,
                Speaker__r.Email__c,
                Speaker__r.Company__c
        FROM Event_Speaker__c 
        WHERE Event_List__c = :eventId
    ];
    return speakerList;
  }

  @AuraEnabled
  public static Event__c getLocationDetails(String eventId) {
    Event__c eventRecord = [
        SELECT  Id, 
                Name__c,
                Location_List__c,
                Location_List__r.Name,
                Location_List__r.City__c,
                Location_List__r.Country__c,
                Location_List__r.Landmark__c,
                Location_List__r.Postal_Code__c,
                Location_List__r.State__c,
                Location_List__r.Street__c
        FROM Event__c 
        WHERE Id = :eventId
    ];
    return eventRecord;
  }

  @AuraEnabled
  public static List<Event_Attendee__c> getAttendees(String eventId) {
    List<Event_Attendee__c> eventAttendeeList = [
        SELECT  Id, 
                Name,
                Attendee__c,
                Attendee__r.Name,
                Attendee__r.Email__c,
                Attendee__r.Company__c,
                Attendee__r.Location_List__c,
                Attendee__r.Location_List__r.Name
        FROM Event_Attendee__c 
        WHERE Event_List__c = :eventId
    ];
    return eventAttendeeList;
  }
}
