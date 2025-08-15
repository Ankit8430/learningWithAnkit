public class DeleteCaseBatch implements Database.Batchable<sObject>,Database.Stateful {
    integer totalRecords=0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            Select Id from Case where CreatedDate=LAST_N_DAYS:10 and Status='Closed'
        ]);
    }
    public void execute(Database.BatchableContext bc, List<Case> caseList){
        totalRecords+=caseList.size();
        Database.DeleteResult[] dlList=Database.delete(caseList,false);
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Total Records =:'+totalRecords);
    }
}