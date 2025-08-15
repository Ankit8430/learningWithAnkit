@isTest
public with sharing class BatchOnOpportunityToUpdateLeadSourceTest {
    @isTest
    private static void testMethod1(){
        List<Opportunity>oppList=new List<Opportunity>();
        for(Integer i=0;i<200;i++){
            oppList.add(new Opportunity(Name='Test'+i,StageName='Closed Won',CloseDate=System.today()));
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
        Test.startTest();
        BatchOnOpportunityToUpdateLeadSourceWeb batch=new BatchOnOpportunityToUpdateLeadSourceWeb();
        Id batchId=Database.executeBatch(batch,200);
        Test.stopTest();
    }
}