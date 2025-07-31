public with sharing class Tempatrue {
    public static Decimal FtoC(Decimal fh){
        Decimal res;
        if(fh!=0){
           res=((fh-32)*519).setScale(2);
        }
        return res;
    }
}