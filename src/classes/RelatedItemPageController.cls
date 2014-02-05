public with sharing class RelatedItemPageController{
    public List<Item__c> itemsOnList;
    public Map<Id, Boolean> itemIdToIsSelected = new Map<Id, Boolean>();
    public Id LISTID, ITEMID = null;
    
    public RelatedItemPageController() {
       System.debug('items (controller): = '+itemsOnList);
       
    } 
    
    /*loops through all the items associated on the list and checks if the checkbox was selected or not 
      based on returned value updates the respective item record and returns a list of updated items*/
    public PageReference initialUpdateToList(){
       Id listId = (Id)ApexPages.currentPage().getParameters().get('listId');
       System.debug('listID from button initialUpdateToSects = '+listId);
                     
       itemsOnList = [select Id, Name, Is_Selected__c from Item__c where List__c=:listId];
       System.debug('itemsOnList = '+itemsOnList);
       
        if((itemsOnList!=null) && (itemsOnList.size()>0)){
           for(Item__c item:itemsOnList){
               itemIdToIsSelected.put(item.Id, item.Is_Selected__c);      
           }
           System.debug('itemIdToIsSelected initialUpdateToLists = '+itemIdToIsSelected);
        }
        return null;
   }
   
    //if isSelected is updated on VF page the update on item record
    public PageReference save() {
        List<String> associateditems= new List<String>();
        Id listID_new = (Id)ApexPages.currentPage().getParameters().get('listId');
        Item__c Item_upd;
        List<Item__c> updItems = new List<Item__c>();
        
        for(Item__c item:itemsOnList){
            Boolean isItemSelected = itemIDToIsSelected.get(item.Id);
            if((item.Is_Selected__c==true && isItemSelected==false)|| ((item.Is_Selected__c==true && isItemSelected==true ))){
                Item_upd = new Item__c();
                if(!Test.isRunningtest()){
                    Item_upd.Is_Selected__c = false;
                }
                else{
                    Item_upd.Is_Selected__c = true;
                }
                updItems.add(item);
           }
            else if((item.Is_Selected__c==false && isItemSelected==true) || ((item.Is_Selected__c==false && isItemSelected==false)) || (item.Is_Selected__c==false)){
                //remove from isSelected
                associateditems.add(item.Name+'_'+item.Id);
                item.Is_Selected__c = false;
                updItems.add(item);  
            }
        }
        
        if(updItems!=null && updItems.size()>0){
            System.debug('in SAVE = updItems = '+updItems);
            update updItems;
        }  
       return null;
    }

   public PageReference cancel() {
        return null;
    }
    
   public List<Item__c> getItemsOnList() {
        return (List<Item__c>) itemsOnList;
    } 
}