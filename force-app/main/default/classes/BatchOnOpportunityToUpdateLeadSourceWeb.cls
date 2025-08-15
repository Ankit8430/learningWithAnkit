public with sharing class BatchOnOpportunityToUpdateLeadSourceWeb implements Database.Batchable<sObject>,Database.Stateful{
    Integer records=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,LeadSource from Opportunity where LeadSource!='Web']);
    }
    public void execute(Database.BatchableContext bc,List<Opportunity>oppList){
        for(Opportunity opp:oppList){
            records+=1;
            opp.LeadSource='Web';
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Records =: '+records);
    }
}

// BatchOnOpportunityToUpdateLeadSourceWeb batch=new BatchOnOpportunityToUpdateLeadSourceWeb();
// Id batchId=Database.executeBatch(batch,200);