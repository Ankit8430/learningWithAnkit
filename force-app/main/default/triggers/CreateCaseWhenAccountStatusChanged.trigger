trigger CreateCaseWhenAccountStatusChanged on Account (after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        CreateCaseWhenAccountStatusHandler.createCase(Trigger.new,Trigger.oldMap);
    }
}