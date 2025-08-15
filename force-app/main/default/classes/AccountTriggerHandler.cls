public class AccountTriggerHandler {
    public static void updatRating(List<Account>accList){
        for(Account acc:accList){
            if(acc.Industry!=null && acc.Industry=='Media'){
                acc.Rating='Hot';
            }else{
                acc.Rating='Cold';
            }
        }
    }
    public static void createOpportunity(List<Account>accList){
        List<Opportunity>oppList=new List<Opportunity>();
        for(Account acc:accList){
            oppList.add(new Opportunity(Name='Test '+acc.Name,StageNAme='Prospecting'
                                        ,CloseDate=System.today(),AccountID=acc.Id));
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
    public static void updateDescription(List<Account>accList,Map<Id,Account>accMap){
        for(Account acc:accList){
            if(accMap!=null && acc.Phone!=accMap.get(acc.Id).Phone){
                acc.Description='Updated Phone From Old Phone '+accMap.get(acc.Id).Phone+' to New Phone '+acc.Phone;
            }
        }
    }
    public static void updatePhone(List<Account>accList,Map<Id,Account>accMap){
        Map<Id,Account>accMapPhone=new Map<Id,Account>();
        for(Account acc:accList){
            if(accMap!=null && acc.Phone!=accMap.get(acc.Id).Phone){
                accMapPhone.put(acc.Id,acc);
            }
        }
        List<Opportunity>oppList=[Select Id,Phone__c,AccountID from Opportunity where AccountId IN: accMapPhone.KeySet()];
        for(Opportunity opp:oppList){
            opp.Phone__c=accMapPhone.get(opp.AccountId).Phone;
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
}