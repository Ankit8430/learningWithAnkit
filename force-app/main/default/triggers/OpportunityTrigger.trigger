trigger OpportunityTrigger on Opportunity (after insert,after update,after delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //OpportunityTriggeHandler.updateAnnualRevenue(Trigger.new,null);
        }
        if(Trigger.isUpdate){
            //OpportunityTriggeHandler.updateAnnualRevenue(Trigger.new,Trigger.old);
        }
        if(Trigger.isDelete){
            //OpportunityTriggeHandler.updateAnnualRevenue(null,Trigger.old);
        }
    }
}