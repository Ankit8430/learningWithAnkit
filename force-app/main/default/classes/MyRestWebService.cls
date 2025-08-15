@RestResource(urlMapping='/createAccountRecord')
global class MyRestWebService {
    @HttpPost
    global static void sendAccountRecords(){
        RestRequest request=RestContext.request;
        RestResponse response=RestContext.response;
        
       String responseJson='[';
        
        List<AccountWrapper> requestBody=(List<AccountWrapper>)JSON.deserialize(request.requestBody.toString(),List<AccountWrapper>.class);
        List<Account>accountList=new List<Account>();
        if(!requestBody.isEmpty() && requestBody.size()>0){
            for(AccountWrapper accObj:requestBody){
                accountList.add(new Account(
                               Name=accObj.name,
                               Rating=accObj.rating,
                               Type=accObj.type));
            }
            if(!accountList.isEmpty() && accountList.size()>0){
                insert accountList;
            }
            for(Account acc:accountList){
                responseJson+='{"record Id":"'+acc.Id+'",';
                responseJson+='"status":"'+'success"},';
            }
            responseJson+=']';
            
            response.responseBody=Blob.valueOf(responseJson);
            response.statusCode=200;
        }
        /*Single Record Insert
        if(requestBody!=null){
            Account acc=new Account();
            acc.Name=requestBody.name;
            acc.Rating=requestBody.rating;
            acc.Type=requestBody.type;
            if(acc!=null){
                insert acc;
            }
        }*/
    }
    global class AccountWrapper{
        global String name;
        global String rating;
        global String type;
    }
}