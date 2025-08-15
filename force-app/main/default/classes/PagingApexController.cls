public with sharing class PagingApexController {
    @AuraEnabled
    public static List<Account> getAccounts(Integer pageNumber,Integer pageSize,String searchKeyWord){
        
        Integer offSetValue=(pageNumber-1)*pageSize;
        if(String.isNotBlank(searchKeyword)){
            String searchWord='%'+searchKeyWord+'%';
            return [Select Id,Name,Phone,Type from Account where Name LIKE: searchWord Order By Name LIMIT :pageSize OFFSET :offSetValue];
        }else{
            return [Select Id,Name,Phone,Type from Account Order By Name LIMIT :pageSize OFFSET :offSetValue];
        }
    }

    @AuraEnabled
    public static Integer getTotalRecords(){
        return [Select COUNT() from Account];
    }
}