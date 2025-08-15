public without sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return AccountController1.getAccounts();
    }
}