trigger ItemTrigger on Item__c (after insert) {
    if(trigger.isInsert){
        ItemTriggerHelper.insertRelatedItems(trigger.new);
    }
}