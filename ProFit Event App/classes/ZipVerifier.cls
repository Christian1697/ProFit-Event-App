public with sharing class ZipVerifier {
    @future (callout=true)
    public static void zipCodeCallOut(String locId) {
        Location_List__c loc = [Select Id, Verified_Location__c, State__c, Street__c, Postal_Code__c, City__c from Location_List__c where Id = :locId];

        Http httpzip = new Http();
        HttpRequest reqzip = new HttpRequest();
        String addzip = 'https://us-zipcode.api.smartystreets.com/lookup?auth-id=9ae797da-a4d5-dced-10b1-a1282dbc96ba&auth-token=ml3eFUdDpUu6GJoZyGKq&city=&state=&zipcode='+ +loc.Postal_Code__c;
        reqzip.setEndPoint(addzip);
        reqzip.setMethod('GET');
        HttpResponse respzip= new HttpResponse();
        respzip = httpzip.send(reqzip);

        System.debug(locId);
        System.debug(respzip.getBody());
        try {
            if(respzip.getStatusCode() == 200){
                List<Object> resultsZipList = (List<Object>)JSON.deserializeUntyped(respzip.getBody());
                    for(Object obj : resultsZipList){
                        Map<String, Object> results = (Map<String, Object>) obj;
                        List<Object> zipObject = (List<Object>) results.get('zipcodes');
                        if(zipObject!=null){
                            loc.Verified_Postal_Code__c = true;
                            update loc;
                            locationCall(locId);
                        }else{
                            loc.Verified_Postal_Code__c = false;
                            update loc;   
                        }
                    }
                
                }
        } 
        
        catch (Exception ex) {
            System.debug('Exception: ' + ex.getMessage());
        }
    }
    
    public static void locationCall(String locId){
        Location_List__c loc = [Select Id, Verified_Location__c, State__c, Street__c, Postal_Code__c, City__c from Location_List__c where Id = :locId];
        Http httpst = new Http();
        HttpRequest reqst = new HttpRequest();
         String addst = 'https://us-street.api.smartystreets.com/street-address?auth-id=a6e592ca-a272-612c-ce67-186bd3f52828&auth-token=XUBy5pp9AIY1otsRDR4H&'
         +'street=' + EncodingUtil.urlEncode(loc.Street__c, 'UTF-8') 
         +'&city='+ EncodingUtil.urlEncode(loc.City__c, 'UTF-8')
         +'&state='+EncodingUtil.urlEncode(loc.State__c, 'UTF-8');
         reqst.setEndPoint(addst);
         reqst.setMethod('GET');
        HttpResponse respst= new HttpResponse();
        respst = httpst.send(reqst); 
        try {
            if(respst.getStatusCode() == 200){
                String respstBody = respst.getBody();
                Integer zc;
                List<Object> resultsList = (List<Object>)JSON.deserializeUntyped(respst.getBody());
                for(Object obj : resultsList){
                    Map<String, Object> results = (Map<String, Object>) obj;
                    Map<String, Object> result = (Map<String, Object>)results.get('components');
                    zc = (Integer)integer.valueof(result.get('zipcode'));
                }
                    if(respstBody.length()>2 && zc==integer.valueof(loc.Postal_Code__c)){
                        
                        loc.Verified_Location__c = true;
                    }else{
                        
                        loc.Verified_Location__c = false;
                    }
                    update loc;
            }
        } 
        catch (Exception ex) {
            System.debug('Exception -- ' + ex.getMessage());
        }
    }
}