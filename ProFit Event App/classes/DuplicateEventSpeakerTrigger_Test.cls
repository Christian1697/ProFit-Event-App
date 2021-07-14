@isTest
private class DuplicateEventSpeakerTrigger_Test {
    
    static Id createTestRecordID(){
      Event__c evt = new Event__c();
      evt.Name__c = 'Test Event';
      evt.Live__c = true;
      evt.Event_Start_Date_Time__c = datetime.newInstance(2021, 6, 26, 19, 30, 0);
      evt.Event_End_Date_Time__c = datetime.newInstance(2021, 6, 28, 20, 30, 0);
      insert evt;
      return evt.Id;
    }
    static Id createTestSpeaker(){
      Speaker__c spk = new Speaker__c();
      spk.Name = 'Test Speaker';
      insert spk;
      return spk.Id;
  }

    @IsTest
    static void checkEventSpeaker(){
      Test.startTest();
      Event_Speaker__c eS = new Event_Speaker__c();
      eS.Name = 'Test Event-Speaker';
      eS.Event_List__c = createTestRecordID();
      eS.Speaker__c = createTestSpeaker();
        
      insert eS;
      Test.stopTest();
      Event_Speaker__c retrievedES = [Select Name from Event_Speaker__c where Name =: eS.Name];
      System.assertEquals('Test Event-Speaker',retrievedES.Name);
          
      }
}