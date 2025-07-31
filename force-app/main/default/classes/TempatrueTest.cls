@isTest
public with sharing class TempatrueTest {
   @isTest 
   private static void warmTempTest(){
        Decimal res=Tempatrue.FtoC(70);
        System.debug(res);
   }
}