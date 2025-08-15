@isTest
public class DailyLeadProcessorTest{
    @isTest
    public static void testMethod1(){
        List<lead>leadList=new List<lead>();
        for(Integer i=0;i<200;i++){
            leadList.add(new lead(LastName='Test'+i,Company='Infosys'));
        }
        insert leadlist;
    Test.startTest();
    DailyLeadProcessor dlp=new DailyLeadProcessor();
    String jobId=System.schedule('DailyLeadProcessor','* * * ? * * *',dlp);
    Test.stopTest();
    }
}