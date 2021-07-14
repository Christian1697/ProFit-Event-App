public with sharing class DuplicateEventSpeakerTrigger {
    public static void eventSpeakerDuplicate(List<Event_Speaker__c> newSpeaker){
        try{

            Set<Id> eventId = new Set<Id>();
            Set<Id> speakerId = new Set<Id>();

            for(Event_Speaker__c eSpeaker : newSpeaker){
                eventId.add(eSpeaker.Event_List__c);
                speakerId.add(eSpeaker.Speaker__c);
            }

            Map<Id, Event__c> startEvent = new Map<Id, DateTime>();
            Map<Id, DateTime> endEvent = new Map<Id, DateTime>();

            List<Event__c> eventList = [
                SELECT Id, Name, Event_Start_Date_Time__c, Event_End_Date_Time__c 
                FROM Event__c 
                WHERE Id IN: eventId];

            for(Event__c evt : eventList){
                startEvent.put(evt.Id, evt.Event__r.Event_Start_Date_Time__c);
                endEvent.put(evt.Id, evt.Event_End_Date_Time__c);
            }

            List<Event_Speaker__c> speakerList = [
                SELECT Id, Event_List__c, Speaker__c, Event_List__r.Event_Start_Date_Time__c, Event_List__r.Event_End_Date_Time__c
                FROM Event_Speaker__c 
                WHERE Speaker__c IN: speakerID];

            for(Event_Speaker__c eSpeaker : newSpeaker) {
                DateTime startTime = startEvent.get(eSpeaker.Event_List__c);
                DateTime endTime = endEvent.get(eSpeaker.Event_List__c);

                for(Event_Speaker__c eS : speakerList)
                {
                    if((eS.Event_List__r.Event_Start_Date_Time__c < endTime && eS.Event_List__r.Event_End_Date_Time__c > endTime)
                     ||(eS.Event_List__r.Event_Start_Date_Time__c < startTime && eS.Event_List__r.Event_End_Date_Time__c > startTime)
                     ||(eS.Event_List__r.Event_Start_Date_Time__c >= startTime && eS.Event_List__r.Event_End_Date_Time__c <= endTime))
                        {
                            eSpeaker.Speaker__c.addError('The Speaker is already registered to another event at the time.');
                        }
                }
            }
            // for(Event_Speaker__c eSpeaker : newSpeaker){
                
            //     Event__c eDate = [Select Event_Start_Date_Time__c, Event_End_Date_Time__c from Event__c where Id =: eSpeaker.Event_List__c];
            //     System.debug(eDate.Event_Start_Date_Time__c);
            //     System.debug(eDate.Event_End_Date_Time__c);

            //     List<Event_Speaker__c> eventSpeaker = [SELECT Id, Event_List__c, Speaker__c FROM Event_Speaker__c 
            //     WHERE (Speaker__c =: eSpeaker.Speaker__c)
            //     AND ((Event_List__r.Event_Start_Date_Time__c <: eDate.Event_End_Date_Time__c AND Event_List__r.Event_End_Date_Time__c >: eDate.Event_End_Date_Time__c)
            //     OR (Event_List__r.Event_Start_Date_Time__c <: eDate.Event_Start_Date_Time__c AND Event_List__r.Event_End_Date_Time__c >: eDate.Event_Start_Date_Time__c))];
                
            //     if(eventSpeaker.size()>0){
            //         eSpeaker.Speaker__c.addError('This speaker is registered to another event already');
            //     }
            // }
        }catch (Exception ex){
            System.debug('Exception: '+ex.getMessage());
        }
    }
}