public with sharing class NumberOfContactOnAccount {
    @future
    public static void countContact(List<Id>accIds){
        List<Account>accList=[Select Id,Number_Of_Contacts__c,(Select Id from Contacts) from Account where Id=:accIds];
        for(Account acc:accList){
            acc.Number_Of_Contacts__c=acc.Contacts.size();
        }
        Database.SaveResult[] srList=Database.update(accList,false);
        for(Database.SaveResult sr:srList){
            if(!sr.isSuccess()){
                System.debug(LoggingLevel.Error,sr.getErrors()[0].getMessage());
            }
        }
    }
}
// List<Account>accList=[Select ID from Account];
// List<Id>accIds=new List<Id>();
// for(Account acc:accList){
//     accIds.add(acc.Id);
// }
// NumberOfContactOnAccount.countContact(accIds);