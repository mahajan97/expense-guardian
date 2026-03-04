trigger ExpenseApprovalStatus on Expense__c (before insert, before update) {
    for(Expense__c exp : Trigger.New){
        if(Trigger.isInsert){
            if(exp.Amount__c > 10000){
                exp.Approval_Status__c = 'Pending' ;
            }
            else{
                exp.Approval_Status__c = 'Approved' ;   
            }
        }
        if(Trigger.isUpdate){
            Expense__c oldExp = Trigger.oldMap.get(exp.Id);
            if(exp.Amount__c != oldExp.Amount__c){
                if(exp.Amount__c > 10000){
                exp.Approval_Status__c = 'Pending' ;
            }
            else{
                exp.Approval_Status__c = 'Approved' ;   
            }  
        }
    }    
	}
}