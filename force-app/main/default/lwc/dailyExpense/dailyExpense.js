import { LightningElement,wire,track} from 'lwc';
// Apex Class
import getExpenses from '@salesforce/apex/ExpenseController.getExpenses'
import getCurrentMonthSpend from '@salesforce/apex/ExpenseController.getCurrentMonthSpend'
import getCurrentYearSpend from '@salesforce/apex/ExpenseController.getCurrentYearSpend'
import getCurrentMaxExpenditure from '@salesforce/apex/ExpenseController.getCurrentMaxExpenditure'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
// Expense Object
import EXPENSE_OBJECT from '@salesforce/schema/Expense__c'
//Fields
import ITEM_NAME_FIELD from '@salesforce/schema/Expense__c.Name'
import CATEGORY_FIELD from '@salesforce/schema/Expense__c.Category__c'
import AMOUNT_FIELD from '@salesforce/schema/Expense__c.Amount__c'
import DATE_FIELD from '@salesforce/schema/Expense__c.Date__c'


export default class DailyExpense extends LightningElement {
    // Variable
    expenseList=[];
    IdToEditRecord=null;
    isModalOpen=false
    totalAmount=0;
    totalAmountOfCurrentMonth=0;
    totalAmountOfCurrentYear=0;
    modalHeader=''
    successPopus=''
    isData=true

    // Variable for related to fields and Object
    nameField=ITEM_NAME_FIELD
    categoryField=CATEGORY_FIELD
    amountField=AMOUNT_FIELD
    dateField=DATE_FIELD
    expenseObject=EXPENSE_OBJECT

    // Date Filter Variables
    
    selectedMonth;
    selectedMonthIndex;
    selectedYear;
    fromDate;
    toDate;
    currentMonth;
    currentYear;
    expenditureMonthName;
    expenditureTotalAmount=0;
    monthOptions=this.generateMonthOptions();

    // Columns for Datatable
    columns = [
        { label: 'Item Name', fieldName: ITEM_NAME_FIELD.fieldApiName},
        { label: 'Category', fieldName: CATEGORY_FIELD.fieldApiName},
        { label: 'Date', fieldName: DATE_FIELD.fieldApiName},
        { label: 'Amount', fieldName: AMOUNT_FIELD.fieldApiName, type: 'currency' },
        {
            type:'action',
            typeAttributes:{rowActions:this.getRowActions},
        },
    ];

    // get total amount of the current month
    fetchTotalAmountOfCurrentMonth(){
        getCurrentMonthSpend({
            currentMonth:this.currentMonth
        }).then(result => {
            this.totalAmountOfCurrentMonth=result
        }).catch(error=>{
            this.showToast('Error','An error occurred while fetching the total amount for the current month.','error');
        })
    }
    // Get Total Amount of the Current Year
    fetchTotalAmountOfCurrentYear(){
        getCurrentYearSpend().then(result=>{
            this.totalAmountOfCurrentYear=result
        }).catch(error=>{
            this.showToast('Error','An error occurred while fetching the total amount for the current year.','error');
        })
    }

    // Month with Max expenditure
    fetchMonthWithMaxExpenditure(){
        getCurrentMaxExpenditure().then(result=>{
            const entries =Object.entries(result);
            if(entries.length>0){
                this.expenditureMonthName=entries[0][0];
                this.expenditureTotalAmount=entries[0][1];
            }
        }).catch(error=>{
        })
    }

    // Get Expenses from Apex Class
    fetchData() {
        getExpenses({
            selectedMonth: this.selectedMonth,
            formDate: this.fromDate,
            toDate: this.toDate
        }).then(result => {
            this.expenseList = result;
            this.totalAmount = result.reduce((sum, expense) => {
                return sum + (expense.Amount__c || 0);
            }, 0);
            this.isData = true;
        }).catch(error => {
            this.showToast('Error', error.body.message, 'error');
        })
    }

    refreshAllApexClass(){
        this.fetchData()
        this.fetchTotalAmountOfCurrentMonth()
        this.fetchTotalAmountOfCurrentYear()
        this.fetchMonthWithMaxExpenditure()
    }
    // Show Action on the Datatable
    getRowActions(row,doneCallback){
        const action=[
            {label:'Edit',name:'edit'}
        ]
        doneCallback(action)
    }

    // Handle Edit Action
    handleRowAction(event){
        const action=event.detail.action
        const rowId=event.detail.row.Id
        if(action.name==='edit'){
            this.isModalOpen=true
            this.IdToEditRecord=rowId
            this.modalHeader='Edit Expense'
        }
    }

    // Add Expense Handler
    handleCreateExpense(){
        this.isModalOpen=true
        this.IdToEditRecord=null
        this.modalHeader='Add Exepnse'
    }

    // Close Modal
    closeModal(){
        this.isModalOpen=false
    }
    // Success Handler
    successHandler(){
        // Show Success popus
        this.successPopus=this.IdToEditRecord===null?'Expense Added Successfully':'Expense Updated Succssfully';
        this.showToast('Success',this.successPopus,'success')
        this.isModalOpen=false
        this.isData=true
        this.refreshAllApexClass()
    }

    showToast(title,message,variant){
        const event=new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }

    // Generate Month Option for Showing filters
    generateMonthOptions(){
        const months=[]
        for(let i=0;i<12;i++){
            const date=new Date(2025,i,1);
            months.push({
                label:date.toLocaleString('default',{month:'long'}),
                value:date.toLocaleString('default',{month:'long'})
            })
        }
        return months;
    }

    // ConnectedCallback
    connectedCallback(){
        const today=new Date();
        this.selectedMonthIndex=today.getMonth()
        this.selectedYear=today.getFullYear()
        this.selectedMonth=today.toLocaleString('default',{month:'long'})
        this.currentMonth=today.toLocaleString('default',{month:'long'})
        this.currentYear=today.getFullYear()
        this.refreshAllApexClass()
    }

    // Hanlde Month Change Handler
    handleMonthChange(event){
        // console.log(event.detail.value)
        this.selectedMonth=event.detail.value
        this.selectedMonthIndex=this.monthOptions.findIndex(opt =>opt.value===this.selectedMonth)
        this.fromDate=null
        this.toDate=null
        this.isData=true
        this.refreshAllApexClass()
    }
    // From Date Change Handler
    handleFromDateChange(event){
        // console.log(event.detail.value)
        this.fromDate=event.detail.value
        this.validateDates()
    }
    handleToDateChage(event){
        // console.log(event.detail.value)
        this.toDate=event.detail.value
        this.validateDates()
    }
    // Validate Dates
    validateDates(){
        // Check if both are not selected
        if(
            (this.fromDate && !this.toDate) ||
            (!this.fromDate && this.toDate)
        ){
            setTimeout(()=>{
                this.showToast('Error','Please select both From Date and To Date','error')
            },1000)
            this.isData=false
        }
        //  Check if both are selected
        if(this.fromDate && this.toDate){
            const from=new Date(this.fromDate)
            const to=new Date(this.toDate)

            if(
                from.getMonth() !==this.selectedMonthIndex || 
                to.getMonth()!==this.selectedMonthIndex ||
                from.getFullYear() !=this.selectedYear ||
                to.getFullYear() !== this.selectedYear
            ){ 
                this.showToast('Error',`Please select dates within the ${this.selectedMonth} ${this.selectedYear}`,'error')
                this.isData=false
            }else{
                this.isData=true
                this.refreshAllApexClass()
            }
        }
    }
}