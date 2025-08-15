public class AccountUtil {
	@future(callout=true)
    public static void sendAccountAsync(String name,String phone){
        String accId=sendAccount(name,phone);
        System.debug(accId);
    }
    public static String sendAccount(String name,String phone){
        Account acc=new Account(Name=name,Phone=phone);
        insert acc;
        return acc.Id;	
    }
}