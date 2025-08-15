trigger ContactTrigger on Contact (after insert,after update,after delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactTriggerHandler.updateNumberOfContact(Trigger.new,null);
        }
        if(Trigger.isUpdate){
            ContactTriggerHandler.updateNumberOfContact(Trigger.new,Trigger.old);
        }
        if(Trigger.isDelete){
            ContactTriggerHandler.updateNumberOfContact(null,Trigger.old);
        }
    }
}