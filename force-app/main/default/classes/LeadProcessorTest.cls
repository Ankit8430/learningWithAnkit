@isTest
public class LeadProcessorTest {
	@isTest
    public static void testMethod1(){
        List<lead>leadList=new List<lead>();
        for(Integer i=0;i<200;i++){
            leadList.add(new lead(LastName='Test'+i,Company='Infosys'));
        }
        insert leadlist;
        TEst.startTEst();
        LeadProcessor lp=new LeadProcessor();
        Id batchId=Database.executeBatch(lp,200);
        Test.stopTest();
    }
}