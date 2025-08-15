@isTest
public class AccountProcessorTest {
	@isTest
    public static void countContactsTest(){
       Account acc=new Account(Name='Test');
       insert acc;
       List<Contact>conList=new List<Contact>();
       Contact con1=new Contact(LastName='Test1',AccountId=acc.ID);
       Contact con2=new Contact(LastName='Test2',AccountId=acc.ID);
       Contact con3=new Contact(LastName='Test3',AccountId=acc.ID);
       conList.add(con1);
       conList.add(con2);
       conList.add(con3);
       insert  conList;
       List<Id>accIds=new List<ID>();
       accIds.add(acc.ID);
       Test.startTest();
        AccountProcessor.countContacts(accIds);
        Test.stopTest();
       
    }
}