import { LightningElement, wire, track } from 'lwc';

import getExpenses from '@salesforce/apex/ExpenseController.getExpenses';
import getBudgets from '@salesforce/apex/ExpenseController.getBudgets';

export default class DisplayExpenseListforaBudget extends LightningElement {
    @track expenses;
    @track budgetOptions;
    selectedBudgetId;

    columns = [
        { label: 'Expense Name', fieldName: 'Name' },
        { label: 'Amount', fieldName: 'Amount__c', type: 'currency' },
        { label: 'Status', fieldName: 'Approval_Status__c' }
    ];

    @wire(getBudgets)
    wiredBudgets({ error, data }) {
        if (data) {
            this.budgetOptions = data.map(budget => {
                return { label: budget.Name, value: budget.Id };
            });
        } else if (error) {
            console.error(error);
        }
    }

    handleBudgetChange(event) {
        this.selectedBudgetId = event.detail.value;
    }

    @wire(getExpenses, { budgetId: '$selectedBudgetId' })
    wiredExpenses({ error, data }) {
        if (data) {
            this.expenses = data;
        } else if (error) {
            console.error(error);
        }
    }
}