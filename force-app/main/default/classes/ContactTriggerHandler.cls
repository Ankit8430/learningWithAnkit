public class ContactTriggerHandler {
    public static void updateNumberOfContact(List<Contact>newContacts,List<Contact>oldContacts){
        Map<Id,Integer>accountContactMap=new Map<Id,Integer>();
        if(newContacts!=null){
            for(Contact con:newContacts){
                if(con.AccountId!=null){
                    if(!accountContactMap.containsKey(con.AccountId)){
                        accountContactMap.put(con.AccountId,0);
                    }
                    accountContactMap.put(con.AccountId,accountContactMap.get(con.AccountId)+1);
                }
            }
        }
        if(oldContacts!=null){
            for(Contact con:oldContacts){
                if(con.AccountId!=null){
                    if(!accountContactMap.containsKey(con.AccountId)){
                        accountContactMap.put(con.AccountId,0);
                    }
                    accountContactMap.put(con.AccountId,accountContactMap.get(con.AccountId)-1);
                }
            }
        }
        List<Account>updateAccounts=new List<Account>();
        Map<Id,Account>exitingAccounts=new Map<Id,Account>([
           Select ID,Number_of_Contacts__c from Account where Id IN:accountContactMap.keySet() 
        ]);
        for(Id accountId :accountContactMap.keySet()){
            Integer newNumberContacts=accountContactMap.get(accountId);
            Account acc=exitingAccounts.get(accountId);
            if(acc!=null){
                acc.Number_Of_Contacts__c=(acc.Number_Of_Contacts__c!=null?acc.Number_Of_Contacts__c:0)+newNumberContacts;
                updateAccounts.add(acc);
            }
        }
        if(!updateAccounts.isEmpty()){
            update updateAccounts;
        }
    }
}