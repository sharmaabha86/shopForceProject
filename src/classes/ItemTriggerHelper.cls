public class ItemTriggerHelper{
    public static void insertRelatedItems(List<Item__c> items){
        List<Item__c> ListOfRelatedItems = new List<Item__c>();
        //get custom setting values: Related_Items__c
        List<Related_Items__c> relatedItems = Related_Items__c.getAll().values();
        for(Item__c item: items){
            for(Related_Items__c relatedItem: relatedItems){
                if(item.Name == relatedItem.Name){
                 	Item__c newitem = new Item__c();
                    newitem.Name = relatedItem.Related_Item__c;
                    newitem.Quantity__c = relatedItem.Quantity__c;
                    newitem.List__c = item.List__c;
                    ListOfRelatedItems.add(newItem);
                }
            }
        }
        
        if(ListOfRelatedItems.size() > 0 && ListOfRelatedItems!=null){
         	insert ListOfRelatedItems;   
        }
    }
}