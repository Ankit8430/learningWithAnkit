public class RemindOpporunityOwner implements Database.Batchable<sObject>,Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc){
        Date targetDate = Date.today().addDays(-7);
        DateTime startOfDay = DateTime.newInstance(targetDate, Time.newInstance(0, 0, 0, 0));
        DateTime endOfDay = startOfDay.addDays(1);
        return Database.getQueryLocator([
            Select Id,Owner.Email,Owner.Name,Name,LAstModifiedDAte from Opportunity where LAstModifiedDAte <:endOfDay
        ]);
    }
    public void execute (Database.BatchableContext bc,List<Opportunity>oppList){
        List<Messaging.Email> emailList= new List<Messaging.Email>();
        for(Opportunity opp:oppList){
            if(opp.Owner.Email!=null){
                Messaging.SingleEmailMessage emailMsg=new Messaging.SingleEmailMessage();
                String[] toAddress=new String[] {opp.Owner.Email};
                emailMsg.setToAddresses(toAddress);
                String emailSub='Reminder: Opportunity Update Needed';
                emailMsg.setSubject(emailSub);
                String content='Hi '+opp.Owner.Name+' <br/><br/>'+
                               'Please update the status of your open Opportunity '+opp.Name+
                   			   '—no changes have been logged in the past 7 days.';
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
            }
        }
        Messaging.sendEmail(emailList);
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Email has been send successfully');
    }
}