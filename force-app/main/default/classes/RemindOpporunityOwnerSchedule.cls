public class RemindOpporunityOwnerSchedule implements Schedulable{
    public void execute(SchedulableContext sc){
        RemindOpporunityOwner roo=new RemindOpporunityOwner();
        Id jobId=Database.executeBatch(roo,200);
        System.debug('Job ID =: '+jobId);
    }
}