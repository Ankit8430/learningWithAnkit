public with sharing class BatchOnOpportunityToUpdateScheduled implements Schedulable{
    public void execute(SchedulableContext sc){
        BatchOnOpportunityToUpdateLeadSourceWeb batch=new BatchOnOpportunityToUpdateLeadSourceWeb();
        Id batchId=Database.executeBatch(batch,200);
    }
}