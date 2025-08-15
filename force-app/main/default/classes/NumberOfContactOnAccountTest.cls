@isTest
public with sharing class NumberOfContactOnAccountTest {
    @isTest
    private static void countContactTest(){
        List<Account>accList=new List<Account>();
        List<ID>accIds=new List<Id>();
        List<Contact>conList=new List<Contact>();
        for(Integer i=0;i<10;i++){
            accList.add(new Account(Name='Test'+i));
        }
        if(!accList.isEmpty()){
            insert accList;
        }
        
        for(Account acc:accList){
            accIds.add(acc.Id);
            conList.add(new Contact(LastName=acc.Name+' contact',AccountId=acc.Id));
        }
        if(!conList.isEmpty()){
            insert conList;
        }
        Test.startTest();
        NumberOfContactOnAccount.countContact(accIds);
        Test.stopTest();
    }
}