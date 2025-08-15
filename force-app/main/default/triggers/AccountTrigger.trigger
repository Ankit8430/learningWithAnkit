trigger AccountTrigger on Account (before insert,after insert,before update,after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            //AccountTriggerHandler.updatRating(Trigger.new);
        }
        if(Trigger.isUpdate){
           // AccountTriggerHandler.updateDescription(Trigger.new,Trigger.oldMap);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //AccountTriggerHandler.createOpportunity(Trigger.new);
        }
        if(Trigger.isUpdate){
            //AccountTriggerHandler.updatePhone(Trigger.new,Trigger.oldMap);
        }
    }
}