public with sharing class refreshApexController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        return [Select Id,FirstName,LastName,Email from Contact Limit 10];
    }
}