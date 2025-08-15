public with sharing class ProductFlowController {
	@InvocableMethod(label='Calculate Total Price')
    public static List<decimal> calculateTotalPrice(List<ProductInput> inputs){
        List<decimal>result=new List<Decimal>();
        for(ProductInput input:inputs){
            Decimal discountFactor = 1 - (input.discount / 100);
            Decimal totalPrice = input.unitPrice * input.quantity * discountFactor;

            result.add(totalPrice.setScale(2));
        }
        return result;
    }
    public class ProductInput{
        @InvocableVariable(label='Unit Price')
        public Decimal unitPrice;
        
        @InvocableVariable(label='Quantity')
        public Integer quantity;
        
        @InvocableVariable(label='Discount')
        public Decimal discount;
    }
}