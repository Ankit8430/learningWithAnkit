public with sharing class ApplyBeforeNullCheckListSetOrMap {
    public static void methodList(){
        List<Account>accList=[Select Id,Name from Account];
        if(!accList.isEmpty()){
            for(Account acc:accList){
                System.debug('Id =: '+acc.Id);
                System.debug('Name =: '+acc.Name);
            }
        }
    }
    public static void methodSet(){
        List<Account>accList=[Select Id from Account];
        Set<Id>accIds=new Set<Id>();
        if(!accList.isEmpty()){
            for(Account acc:accList){
                accIds.add(acc.Id);
            }
        }
        if(!accIds.isEmpty()){
            for(Id ids:accIds){
                System.debug('Id =: '+ids);
            }
        }
    }
    public static void methodMap(){
        List<account>accList=[select id,name from account];
        Set<Id>accIds=new Set<Id>();
        Map<Id,Account>accMap=new Map<Id,Account>(accList);

        if(!accList.isEmpty()){
            for(Account acc:accList){
                accIds.add(acc.Id);
            }
        }

        if(!accIds.isEmpty()){
            for(Id ids:accIds){
                if(accMap.containsKey(ids)){
                    System.debug('Id =: '+ids);
                    system.debug('Account =: '+accMap.get(ids));
                }
            }
        }
    }
}

