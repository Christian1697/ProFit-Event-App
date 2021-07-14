@isTest
public with sharing class ZipVerifier_Test {
    public static testMethod void testZip(){

        Location_List__c loc = new Location_List__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States'
        );
        insert loc;



        try{
            Test.setMock(HttpCalloutMock.class, new ZipMock());
            Test.startTest();

            ZipVerifier.zipCodeCallOut(''+loc.Id+'');
            
            Test.stopTest();
        }catch(Exception ex){

        }
        Location_List__c retrievedZipVerified = [Select Verified_Postal_Code__c from Location_List__c where Id =: loc.Id];
        System.assertEquals(true, retrievedZipVerified.Verified_Postal_Code__c);

    }
    public static testMethod void testLoc(){
        Location_List__c loc = new Location_List__c(
            Name = '3301 South Greenfield Rd',
            Street__c = '3301 South Greenfield Rd',
            City__c = 'Gilbert',
            State__c = 'AZ',
            Postal_Code__c = '85297',
            Country__c = 'United States'
        );
        insert loc;

        try{
            Test.setMock(HttpCalloutMock.class, new LocationMock());
            Test.startTest();

            ZipVerifier.locationCall(''+loc.Id+'');
            
            Test.stopTest();
        }catch(Exception ex){

        }
        Location_List__c retrievedLocVerified = [Select Verified_Location__c from Location_List__c where Id =: loc.Id];
        System.assertEquals(true,retrievedLocVerified.Verified_Location__c);
    }

}