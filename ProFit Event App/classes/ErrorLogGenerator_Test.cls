@isTest
public with sharing class ErrorLogGenerator_Test {
    @IsTest
    static void testError(){
        
        Test.startTest();
        DateTime edatetime = datetime.newInstance(2021, 6, 21, 19, 30, 0);
        String edetails = 'Error Test';
        String ename = 'Test Error Name';
        ErrorLogGenerator.createErrorLog(ename,edetails, edatetime);

        Test.stopTest();
        Error_Log__c eLog = [Select Id, Log_Date_Time__c, Log_Details__c, Process_Name__c from Error_Log__c];
        System.assertEquals('Test Error Name', eLog.Process_Name__c);
    }
}