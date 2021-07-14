@isTest
public class UpdateEventStatusBatch_Test {
    public static testMethod void testUpdateStatusBatch() {

        List<Event__c> eList = new List<Event__c>();
        for(Integer i=0; i<=100; i++){
            Event__c evnt = new Event__c(
                Name__c = 'Test #' +1,
                Event_Status__c = 'Created',
                Event_Start_Date_Time__c = datetime.newInstance(2020, 7, 16, 08, 30, 0),
                Event_End_Date_Time__c = datetime.newInstance(2020, 7, 19, 20, 0, 0),
                Max_Seats__c = 10,
                Live__c = false
                );
                eList.add(evnt);
        }
        insert eList;
        
        try{
            Test.startTest();

            Id batchId = Database.executeBatch(new UpdateEventStatusBatch(), 150);

            Test.stopTest();
        }
        catch (Exception ex){

        }
        System.AssertEquals(database.countquery('SELECT COUNT()' + ' FROM Event__c Where Event_Status__c != \'Completed\''), 101);

    }
}
