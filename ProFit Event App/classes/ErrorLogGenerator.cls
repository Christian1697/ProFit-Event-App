public with sharing class ErrorLogGenerator {
    public static void createErrorLog(String ename, String edetails, Datetime edatetime){
        Error_Log__c erl= new Error_Log__c();
        erl.Process_Name__c = ename;
        erl.Log_Details__c = edetails;
        erl.Log_Date_Time__c = edatetime;
        insert erl;
    }
}