public class SpoonacularWrapper {
		public Integer missedIngredientCount{get;set;}
		public Integer usedIngredientCount{get;set;}
		public list<missedIngredients> missedIngredients{get;set;}
		public String imageType{get;set;}
		public list<usedIngredients> usedIngredients{get;set;}
		public String image{get;set;}
		public list<String> unusedIngredients{get;set;}
		public String title{get;set;}
		public Integer likes{get;set;}
		public Integer id{get;set;}
	public class usedIngredients{
		public String aisle{get;set;}
		public String name{get;set;}
		public String unitShort{get;set;}
		public String original{get;set;}
		public String unitLong{get;set;}
		public String originalName{get;set;}
		public String unit{get;set;}
		public list<String> meta{get;set;}
		public Integer amount{get;set;}
		public String image{get;set;}
		public Integer id{get;set;}
	}
	public class missedIngredients{
		public String image{get;set;}
		public String unitShort{get;set;}
		public String unitLong{get;set;}
		public String aisle{get;set;}
		public String unit{get;set;}
		public String name{get;set;}
		public Integer amount{get;set;}
		public String original{get;set;}
		public Integer id{get;set;}
		public String originalName{get;set;}
		public list<String> meta{get;set;}
	}
    public static List<SpoonacularWrapper> parse(String json){
        return (List<SpoonacularWrapper>)System.JSON.deserialize(json,List<SpoonacularWrapper>.class);
    }
}