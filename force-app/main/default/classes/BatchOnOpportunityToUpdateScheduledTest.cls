@isTest
public with sharing class BatchOnOpportunityToUpdateScheduledTest {
    @isTest
    private static void testMethod1(){
        List<Opportunity>oppList=new List<Opportunity>();
        for(Integer i=0;i<200;i++){
            oppList.add(new Opportunity(Name='Test'+i,closeDate=System.today(),stageNAme='Closed Won'));
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }

        String sch='0 0 0 ? * * *';
        Test.startTest();
        String jobId=System.schedule('BatchOnOpportunityToUpdateScheduledTest',sch,new BatchOnOpportunityToUpdateScheduled());
        Test.stopTest();
    }
}