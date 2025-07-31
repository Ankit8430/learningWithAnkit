public with sharing class DatabaseMethodClass {

    public static void insertDatabaseMethod(){
        List<Account>accList=new List<Account>();
        for(Integer i=0;i<100;i++){
            accList.add(new Account(Name='Test'+i));
        }
        Database.SaveResult[] srList=Database.insert(accList,false);
        for(Database.SaveResult sr:srList){
            if(!sr.isSuccess()){
                System.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
            }
        }
    }

    public static void updateDatabaseMethod(){
        List<Account>accList=[Select Id,Name,Phone from Account where Name Like 'Test%'];

        for(Account acc:accList){
            acc.Phone='1234567890';
        }
        Database.SaveResult[] srList=Database.update(accList,false);
        for(Database.SaveResult sr:srList){
            if(!sr.isSuccess()){
                system.debug(LoggingLevel.ERROR,sr.getErrors()[0].getMessage());
            }
        }
    }

    public static void deleteDatabaseMethod(){
        List<Account>accList=[Select Id from Account];

        Database.DeleteResult[] dlList=Database.delete(accList,false);
        for(Database.DeleteResult dl:dlList){
            if(!dl.isSuccess()){
                System.debug(LoggingLevel.ERROR,dl.getErrors()[0].getMessage());
            }
        }
    }
}
//DatabaseMethodClass.insertDatabaseMethod();
// DatabaseMethodClass.updateDatabaseMethod();
// DatabaseMethodClass.deleteDatabaseMethod();