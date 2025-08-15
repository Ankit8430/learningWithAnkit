@RestResource(urlMapping='/createContactMapping')
global class MyRestWebService1 {
	@HttpPost
    global static void sendContactRecords(){
        RestRequest request=RestContext.request;
        RestResponse response=RestContext.response;
        
        List<ContactWrapper>requestBody=(List<ContactWrapper>)Json.deserialize(request.requestBody.toString(),List<ContactWrapper>.class);
    	List<Contact>contactList=new List<Contact>();
        if(!requestBody.isEmpty()){
            for(ContactWrapper conObj:requestBody){
                contactList.add(new Contact(
                    FirstName=conObj.firstName,
                    LastName=conObj.lastName,
                    AccountId=conObj.accountId
                ));
            }
            if(!contactList.isEmpty() && contactList.size()>0){
                insert contactList;
            }
        }
    }
    global class ContactWrapper{
        global string firstName;
        global string lastName;
        global Id accountId;
    }
}