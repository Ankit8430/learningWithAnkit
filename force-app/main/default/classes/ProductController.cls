public class ProductController {
	@AuraEnabled
    public static Decimal calculateTotalPrice(Decimal unitPrice,Integer quantity,Decimal discount){
 		Decimal discountFactor = 1 - (discount / 100);
        Decimal totalPrice = unitPrice * quantity * discountFactor;
        return totalPrice;
    }
    @AuraEnabled
    public static void updateProduct(Id ids,Decimal totalPrice){
        Product2 prod=[Select Id,Total_Price__c from Product2 where Id=:ids Limit 1];
        prod.Total_Price__c=totalPrice;
        update prod;
    }
}