public  class LocationVerifier {
    
    @future(callout=true)
    public static void verifyZipcode(String recordId){
        Location_List__c locRec = [Select Id, Name, Verified_Location__c, Street__c, City__c, Postal_Code__c, State__c From Location_List__c Where Id=: recordId];
        Http httpZip = new Http();
        HttpRequest hReqZip = new HttpRequest();
        hReqZip.setEndpoint('https://us-street.api.smartystreets.com/street-address?auth-id=9ae797da-a4d5-dced-10b1-a1282dbc96ba&auth-token=ml3eFUdDpUu6GJoZyGKq' + '$zipcode=' + EncodingUtil.urlEncode(locRec.Postal_Code__c, 'UTF-8'));
        hReqZip.setMethod('GET');
        HttpResponse httpResZip = new HttpResponse();
        httpResZip = httpZip.send(hReqZip);

        try{
            if(httpResZip.getStatusCode() == 200){
                List<Object> resultZipList = (List<Object>)JSON.deserializeUntyped(hReqZip.getBody());
                for(Object obj : resultZipList){
                    Map<String, Object> results = (Map<String, Object>) obj;
                    List<Object> zipObject = (List<Object>) results.get('zipcodes');
                    if(zipObject!=null){
                        verifyAddress(recordId);
                    }
                }
            }
        }
        catch(Exception ex) {
            System.debug('Exception --' + ex.getMessage());
        }
    }

    public static void verifyAddress( String recordId ){
        Location_List__c locRec = [Select Id, Name, Verified_Postal_Code__c, Street__c, City__c, Postal_Code__c, State__c From Location_List__c Where Id=: recordId];
        Http httpAdd = new Http();
        HttpRequest hReqAdd = new HttpRequest();
        hReqAdd.setEndpoint('https://us-street.api.smartystreets.com/street-address?auth-id=9ae797da-a4d5-dced-10b1-a1282dbc96ba&auth-token=ml3eFUdDpUu6GJoZyGKq' 
        + '&street=' + EncodingUtil.urlEncode(locRec.Street__c, 'UTF-8')
        + '&city=' + EncodingUtil.urlEncode(locRec.City__c, 'UTF-8')
        + '$state=' + EncodingUtil.urlEncode(locRec.State__c, 'UTF-8'));
        hReqAdd.setMethod('GET');
        HttpResponse httpResAdd = new HttpResponse();
        httpResAdd = httpAdd.send(hReqAdd);

        try{
            if(httpResAdd.getStatusCode() == 200){
                String httpResAddBody = httpResAdd.getBody();
                if(httpResAddBody.length()>2){
                    locRec.Verified_Postal_Code__c = true;
                    locRec.Verified_Postal_Code__c = true;
                }else{
                    locRec.Verified_Postal_Code__c = false;
                    locRec.Verified_Postal_Code__c = false;
                }
            }

        }
        catch(System.CalloutException ex){
            System.debug('Exception message: ' + ex.getStackTraceString());
        }
    }
}
