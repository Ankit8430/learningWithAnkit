public with sharing class AccountControllerLWC {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [Select Id,Name,Type from Account limit 10];
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> filterAccountType(String type){
        return [Select Id,Name,Type from Account where Type=:type limit 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey){
        String key='%'+searchKey+'%';
        return [Select Id,Name,Type from Account 
        where Name LIKE :key LIMIT 10];
    }
}