trigger DuplicateSpeakerTrigger on Event_Speaker__c (before insert, before update) {
    if(trigger.isBefore && (trigger.isInsert||trigger.isUpdate)){
        DuplicateEventSpeakerTrigger.eventSpeakerDuplicate(trigger.new);
    }
}