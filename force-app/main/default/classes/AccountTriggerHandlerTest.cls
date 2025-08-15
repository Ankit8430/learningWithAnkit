@isTest
public class AccountTriggerHandlerTest {
    @testSetup
    private static void testSetup(){
         List<Account>accList=new List<Account>();
        for(Integer i=0;i<=100;i++){
            accList.add(new Account(Name='Test'+i));
        }
        accList.add(new Account(Name='Test',Industry='Media'));
        if(!accList.isEmpty()){
            insert accList;
        }
    }
	@isTest
    private static void updateRatingTest(){
        Test.startTest();
        Test.stopTest();
    }
    @isTest
    private static void createOpportunityTest(){
        Test.startTest();
        Test.stopTest();
    }
    @isTEst
    private static void updateDescriptionTest(){
        List<Account>accList=[Select ID,Phone from Account where Name like 'Test%'];
        for(Account acc:accList){
            acc.Phone='1234567890';
        }
        Test.startTest();
        if(!accList.isEmpty()){
            update accList;
        }
        Test.StopTest();
    }
    @isTest
    private static void updatePhoneTest(){
                Test.startTest();
        List<Account>accList=[Select Id,Phone from Account where Name like 'Test%'];
        List<Opportunity>oppList=new List<Opportunity>();
        for(Account acc:accList){
            oppList.add(new Opportunity(Name='Test '+acc.Name,StageNAme='Prospecting'
                                        ,CloseDate=System.today(),AccountID=acc.Id));
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }

        for(Account acc:accList){
            acc.Phone='1234567891';
        }
        if(!accList.isEmpty()){
            update accList;
        }
        Test.stopTest();
    }
}