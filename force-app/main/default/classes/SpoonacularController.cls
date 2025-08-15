public class SpoonacularController {
    public static void getRecipe(){
        Spoonacular__mdt spoon=[Select Id,Endpoint_API__c,API_Key__c from Spoonacular__mdt where DeveloperName='Spoonacular_Data'];
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        String endpoint=spoon.Endpoint_API__c+'?ingredients=apple';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type','application/json');
        request.setHeader('x-api-key',spoon.API_Key__c);
        HttpResponse response=http.send(request);
        
        if(response.getStatusCode()==200){
            System.debug('=== data ==>'+response.getBody());
            List<SpoonacularWrapper.missedIngredients> spoonacularList=(List<SpoonacularWrapper.missedIngredients>)JSON.deserialize(response.getBody(),List<SpoonacularWrapper.missedIngredients>.class);
        	System.debug('=== spoonacularList ==>'+spoonacularList);
        }
    }
}