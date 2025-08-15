public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String searchKeyword){
        
        if(String.isNotBlank(searchKeyword)){
            String searchWord='%' +searchKeyword+ '%';
            return [Select Id,FirstName,LastName,Title,
                AccountId,Account.Name,Email,Phone from Contact 
                where AccountId!=null and FirstName LIKE: searchWord limit 15];
        }else{
            return [Select Id,FirstName,LastName,Title,
                AccountId,Account.Name,Email,Phone from Contact 
                where AccountId!=null limit 15];
        }
    }
    @AuraEnabled
    public static void deleteRecord(String contactId){
        Contact con=[Select Id from Contact where Id=:contactId];
        delete con;
    }

    @AuraEnabled
    public static void bulkDeleted(List<Id> lstContactIds){
        List<Contact>conList=[Select Id from Contact where Id=:lstContactIds];
        delete conList;
    }
}