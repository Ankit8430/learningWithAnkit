public class LeadProcessor implements Database.Batchable<sObject>,Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,LeadSource from Lead]);
    }
    public void execute(Database.BatchableContext bc,List<Lead>leadList){
        for(Lead lea:leadList){
            lea.LeadSource='Dreamforce';
        }
        update leadList;
    }
    public void finish(Database.BatchableContext bc){
        
    }
}