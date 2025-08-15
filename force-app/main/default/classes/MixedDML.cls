public class MixedDML {
    
    public static void mixedDMLMethod(){
        Account acc=new Account(Name='Test');
        insert acc;
        insertUser();
    }
    @future
    public static void insertUser(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT Id FROM UserRole WHERE Name='CEO'];
        User usr = new User(alias = 'testGeek1', email='test1@geek.com',
        emailencodingkey='UTF-8', lastname='Geek',
        languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
        timezonesidkey='America/Los_Angeles',
        username='test@geek.com');
        insert usr;
    }
}