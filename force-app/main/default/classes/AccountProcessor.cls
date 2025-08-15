public class AccountProcessor {
    @future
    public static void countContacts(List<Id>accountId){
        List<Account>updateAccounts=new List<Account>();
        for(Account acc:[Select Id,Number_Of_Contacts__c,(Select Id from Contacts) from Account where Id IN: accountId]){
            acc.Number_Of_Contacts__c=acc.Contacts.size();
            updateAccounts.add(acc);
        }
        update updateAccounts;
    }
}