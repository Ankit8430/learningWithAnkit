public inherited sharing class AccountController1 {
    public static List<Account> getAccounts(){
        return [Select Id,Name from Account];
    }
}