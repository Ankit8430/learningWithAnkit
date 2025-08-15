public with sharing class UpdateParentAccount implements Queueable{
    private List<Account>accList;
    private Id parentId;
    
    public UpdateParentAccount(List<Account>accList,Id parentId){
        this.accList=accList;
        this.parentId=parentId;
    }
    public void execute(QueueableContext qc){
        for(Account acc:accList){
            acc.ParentID=parentId;
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}