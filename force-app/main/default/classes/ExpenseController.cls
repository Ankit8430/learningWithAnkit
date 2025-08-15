public with sharing class ExpenseController {
    @AuraEnabled
    public static List<Expense__c> getExpenses(String selectedMonth,Date formDate, Date toDate){
        Date startDate;
        Date endDate;
        if(formDate!=null && toDate!=null){
            startDate=formDate;
            endDate=toDate;
        }else{
            // Use selected month
            Integer monthIndex = getMonthIndex(selectedMonth); 
            Integer year = Date.today().year(); 
            startDate = Date.newInstance(year, monthIndex + 1, 1);
            endDate = startDate.addMonths(1).addDays(-1);
        }
        return[
            SELECT Id, Name, Category__c, Amount__c, Date__c
            FROM Expense__c
            WHERE Date__c >= :startDate AND Date__c <= :endDate

        ];
    }
    private static Integer getMonthIndex(String monthName){
        List<String> months = new List<String>{
            'January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'
        };
        return months.indexOf(monthName);
    }
    @AuraEnabled
    public static Decimal getCurrentMonthSpend(String currentMonth){
        Integer monthIndex = getMonthIndex(currentMonth); 
        Integer year = Date.today().year(); 
        Date startDate = Date.newInstance(year, monthIndex + 1, 1);
        Date endDate = startDate.addMonths(1).addDays(-1);

        AggregateResult result=[SELECT SUM(Amount__c) total  FROM Expense__c WHERE Date__c >= :startDate AND Date__c <= :endDate];
        Decimal totalAmount = (Decimal)result.get('total');
        return totalAmount != null ? totalAmount : 0;
    }
    @AuraEnabled
    public static Decimal getCurrentYearSpend(){
        AggregateResult result=[SELECT SUM(Amount__c) total  FROM Expense__c WHERE Date__c =THIS_YEAR];
        Decimal totalAmount = (Decimal)result.get('total');
        return totalAmount != null ? totalAmount : 0;
    }
    @AuraEnabled
    public static Map<String, Decimal> getCurrentMaxExpenditure(){
        AggregateResult result=[SELECT CALENDAR_MONTH(Date__c) Month, SUM(Amount__c) total FROM Expense__c WHERE Date__c = THIS_YEAR 
                        GROUP BY CALENDAR_MONTH(Date__c) ORDER BY SUM(Amount__c) DESC LIMIT 1];
        
        // Month number to name mapping
        List<String> months = new List<String>{
            'January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'
        };

        Integer monthNumber = (Integer)result.get('Month');
        Decimal totalAmount = (Decimal)result.get('total');

        Map<String, Decimal> currentMaxExpenditureMap = new Map<String, Decimal>();
        currentMaxExpenditureMap.put(months[monthNumber - 1], totalAmount);

        return currentMaxExpenditureMap;

    }
}