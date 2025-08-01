public with sharing class SOQCLASS {
    public static void createOpportunityOnAccount(){
        List<Account>accList=[Select Id,Name from Account where CreatedDate=THIS_YEAR];
        List<Opportunity>oppList=new List<Opportunity>();
        for(Account acc:accList){
            oppList.add(new Opportunity(Name='Opp '+acc.Name,StageName='Prospecting',CloseDate=system.today(),AccountId=acc.Id));
        }
        if(!oppList.isEmpty()){
            Database.SaveResult[] srList=Database.insert(oppList,false);
            for(Database.SaveResult sr:srList){
                if(!sr.isSuccess()){
                    System.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
                }
            }
        }
    }
    public static void updateAccountPhoneNumber(){
        List<Account>accList=[Select Id,Name,Phone from Account where CreatedDAte=THIS_YEAR];
        for(Account acc:acCList){
            acc.Phone='1234567890';
        }
        Database.SaveREsult[] srList=Database.update(accList,false);
        for(Database.SaveResult sr:srList){
            if(!sr.isSuccess()){
                system.debug(LoggingLevel.Error,sr.getErrors()[0].getMessage());
            }
        }
    }
    public static void updateOpportunityDescription(){
        List<Opportunity>oppList=[Select Id,StageName,Description from Opportunity where CreatedDAte=THIS_WEEK and StageName!=null];
        for(Opportunity opp:oppList){
            opp.Description='Opportunity is '+opp.StageName;
        }
        Database.SaveREsult[] srList=Database.update(oppList,false);
        for(Database.SaveREsult sr:srList){
            if(!sr.isSuccess()){
                System.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
            }
        }
    }
    public static void updateTotalContactOnAccount(){
        List<Account>accList=[Select Id,Number_Of_Contacts__c ,(Select Id from Contacts) from Account];
        for(Account acc:accList){
            acc.Number_Of_Contacts__c =acc.Contacts.size();
        }
        Database.SaveResult[] srList=Database.update(accList,false);
        for(Database.SaveResult sr:srList){
            if(!sr.isSuccess()){
                system.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
            }
        }
    }
    public static void updatePhoneOnAccountFromContact(){
        List<Contact>conList=[Select Id,AccountId,Phone from Contact];
        List<Account>accList=new List<Account>();
        for(Contact con:conList){
            accList.add(new Account(Id=con.AccountId,Phone=con.Phone));
        }
        Database.SaveResult[] srList=Database.update(accList,false);
        for(Database.SaveResult sr:srList){
            if(!sr.isSuccess()){
                System.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
            }
        }
    }
    public static void updatePhoneOnContactFromAccountSimpleWay(){
        List<Account>accList=[Select Id,Phone,(Select Id,Phone from Contacts) from Account];
        List<Contact>conList=new List<contact>();
        for(Account acc:accList){
            for(Contact con:acc.Contacts){
                con.Phone=acc.Phone;
                conList.add(con);
            }
        }
        Database.SaveResult[] srList=Database.update(conList,false);
        for(Database.SaveREsult sr:srList){
            if(!sr.isSuccess()){
                System.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
            }
        }
    }
    public static void updatePhoneOnContactFromAccountMapWay(){
        List<Contact>updateContacts=new List<contact>();
        List<Account>accList=[Select Id,Phone from Account Where Phone!=null];
        Map<Id,Account>accMap=new Map<Id,Account>(accList);

        List<Contact>conList=[Select Id,AccountId,Phone from Contact where AccountId IN: accMap.KeySet()];

        for(Contact con:conList){
            con.Phone=accMap.get(con.AccountId).Phone;
            updateContacts.add(con);
        }
        
        Database.SaveResult[] srList=Database.update(updateContacts,false);
        for(Database.SaveREsult sr:srList){
            if(!sr.isSuccess()){
                System.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
            }
        }
    }
}

// SOQCLASS.createOpportunityOnAccount();
// SOQCLASS.updateAccountPhoneNumber();
// SOQCLASS.updateOpportunityDescription();
// SOQCLASS.updateTotalContactOnAccount();
// SOQCLASS.updatePhoneOnAccountFromContact();
// SOQCLASS.updatePhoneOnContactFromAccountSimpleWay();
// SOQCLASS.updatePhoneOnContactFromAccountMapWay();