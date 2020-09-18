public class TriggerDispatcher {

    public static void handleTrigger(SobjectType sObjectName){
        List<SObjectTriggerHandler__mdt> handlersList = [SELECT TriggerHandlerClass__c FROM SObjectTriggerHandler__mdt WHERE SobjectType__c=: sObjectName.getDescribe().getName() ];
        for(SObjectTriggerHandler__mdt mdt : handlersList){
            execute((ITriggerHandler)Type.forName(mdt.TriggerHandlerClass__c));
        }
    }

    private static void execute(ITriggerHandler handler) {
        if (handler.isDisabled() == false ) {
            switch on Trigger.operationType {
                when BEFORE_INSERT {
                    handler.beforeInsert(Trigger.new);
                }
                when BEFORE_UPDATE {
                    handler.beforeUpdate(Trigger.newMap,Trigger.oldMap);
                }
                when BEFORE_DELETE{
                    handler.beforeDelete(Trigger.oldMap);
                }
                when AFTER_INSERT{
                    handler.afterInsert(Trigger.newMap);
                }
                when AFTER_UPDATE{
                    handler.afterUpdate(Trigger.newMap, Trigger.oldMap);
                }
                when AFTER_DELETE{
                    handler.afterDelete(Trigger.oldMap);
                }
                when AFTER_UNDELETE{
                    handler.afterUndelete(Trigger.newMap);
                }
            }
        }
        
    }
}