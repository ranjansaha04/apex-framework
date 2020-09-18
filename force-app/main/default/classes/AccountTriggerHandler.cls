public class AccountTriggerHandler implements ITriggerHandler{
  // Allows unit tests (or other code) to disable this trigger for the transaction
  public static Boolean isTriggerDisabled = false;
  
  public Boolean isDisabled(){
        if(TriggerSetting__c.getInstance('Account')!=null && 
           TriggerSetting__c.getInstance('Account').isDisabled__c){
           return true;
        }else {
          return isTriggerDisabled;
        }        
    }
 
    public void beforeInsert(List<SObject> newItems) {

    }
 
    public void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {

    }
 
    public void beforeDelete(Map<Id, SObject> oldItems) {

    }
 
    public void afterInsert(Map<Id, SObject> newItems) {

    }
 
    public void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {

    }
 
    public void afterDelete(Map<Id, SObject> oldItems) {

    }
 
    public void afterUndelete(Map<Id, SObject> oldItems) {

    }
}