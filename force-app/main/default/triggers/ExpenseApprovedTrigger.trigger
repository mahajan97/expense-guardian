trigger ExpenseApprovedTrigger on Expense__c (before update) {
    for(Expense__c exp : Trigger.New){
		Expense__c oldExp = Trigger.oldMap.get(exp.Id) ;
        if(oldExp.Approval_Status__c == 'Approved'){
            if(exp.Amount__c != oldExp.Amount__c){
            	exp.Amount__c.addError('Amount can not be modified for Approved expenses.') ;  
            }
            if(exp.Category__c != oldExp.Category__c){
            	exp.Category__c.addError('Category can not be modified for Approved expenses.') ;  
            }
        }        
    }
}