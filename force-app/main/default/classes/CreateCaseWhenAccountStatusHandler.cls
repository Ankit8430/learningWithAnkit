public class CreateCaseWhenAccountStatusHandler {
    public static void createCase(List<Account> accList, Map<Id,Account>accMap){
        Set<Id>accountId=new Set<Id>();
        for(Account acc:accList){
            if(acc.Status__c!=null && acc.Status__c=='Inactive' && accMap.get(acc.Id).Status__c=='Active'){
                accountId.add(acc.Id);
            }
        }
        if(!accountId.isEmpty()){
            List<Case> caseList=new List<case>();
            for(Id ids:accountId){
                Case cas=new Case();
                cas.AccountId=ids;
                cas.Status='New';
     			
                caseList.add(cas);
            }
            if(!caseList.isEmpty()){
                insert caseList;
            }
        }
    }
}