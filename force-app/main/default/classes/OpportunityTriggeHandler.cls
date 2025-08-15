public class OpportunityTriggeHandler {
    public static void updateAnnualRevenue(List<Opportunity>newOpps,List<Opportunity>oldOpps){
        Map<Id,Decimal>accountRevenueMap=new Map<Id,Decimal>();
        if(newOpps!=null){
            for(Opportunity opp:newOpps){
                if(opp.Amount!=null && opp.AccountId!=null){
                    if(!accountRevenueMap.containsKey(opp.AccountId)){
                        accountRevenueMap.put(opp.AccountId,0);
                    }
                    accountRevenueMap.put(opp.AccountId,accountRevenueMap.get(opp.AccountId)+opp.Amount);
                }
            }
        }
        if(oldOpps!=null){
            for(Opportunity opp:oldOpps){
                if(opp.Amount!=null && opp.AccountId!=null){
                    if(!accountRevenueMap.containsKey(opp.AccountId)){
                        accountRevenueMap.put(opp.AccountId,0);
                    }
                    accountRevenueMap.put(opp.AccountId,accountRevenueMap.get(opp.AccountId)-opp.Amount);
                }
            }
        }    
        List<Account>updateAccounts=new List<Account>();
        Map<Id,Account>exitingAccount=new Map<Id,Account>([Select Id,AnnualRevenue from Account where Id IN: accountRevenueMap.keySet()]);
        for(Id accountId:accountRevenueMap.keySet()){
            Decimal newAnnualRevenue=accountRevenueMap.get(accountId);
            Account acc=exitingAccount.get(accountId);
            if(acc!=null){
                acc.AnnualRevenue=(acc.AnnualRevenue!=null?acc.AnnualRevenue:0)+newAnnualRevenue;
                updateAccounts.add(acc);
            }
        }
        if(!updateAccounts.isEmpty()){
            update updateAccounts;
        }
    }
}