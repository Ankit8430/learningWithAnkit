public class DailyLeadProcessor implements schedulable{
    
    public void execute(schedulableContext sc) {
        List<lead> updateLeads = new List<lead>();
        List<lead> leadList = new List<lead>([select id, leadsource from lead where leadsource = null]);
        for(lead l : leadList) {
            l.leadsource = 'Dreamforce';
            updateLeads.add(l);
        }
        update updateLeads;
    }

}