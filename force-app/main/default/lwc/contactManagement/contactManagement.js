import { LightningElement,wire} from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts'
import deleteRecord from '@salesforce/apex/ContactController.deleteRecord'
import bulkDeleted from '@salesforce/apex/ContactController.bulkDeleted'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import {refreshApex} from '@salesforce/apex'
export default class ContactManagement extends LightningElement {
    
    contacts;
    error;
    IdtoEditRecord=null
    isModalOpen=false
    wiredContactResult
    searchKey='';
    selectedContacts=[]

    columns=[
        {label:'First Name',fieldName:'FirstName'},
        {label:'Last Name',fieldName:'LastName'},
        {label:'Title',fieldName:'Title'},
        {label:'Phone',fieldName:'Phone'},
        {label:'Account Name',fieldName:'AccountUrl',type:'url',
            typeAttributes:{label:{fieldName:'AccountName'},target:'_blank'}
        },
        {label:'Email',fieldName:'Email',type:'email'},
        {
            type:'action',
            typeAttributes:{rowActions:this.getRowActions},
        }
    ]

    @wire(getContacts,{
        searchKeyword:'$searchKey'
    })
    getWiredContacts(result){
        this.wiredContactResult=result
        const {data,error}=result
        if(data){
            // console.log('data..',data)
            this.contacts=data.map(contact=>{
                let flatContact={...contact}
                flatContact.AccountName=contact.Account.Name
                flatContact.AccountUrl=`/lightning/r/Account/${contact.AccountId}/view`
                //console.log('flatContact....',flatContact)
                return flatContact
            })
            this.error=undefined
        }else if(error){
            this.error=error
            this.contacts=undefined
        }
    }

    getRowActions(row,doneCallback){
        const actions=[
            {label:'Edit',name:'edit'},
            {label:'Delete',name:'delete'}
        ];
        doneCallback(actions);
    }

    handleRowAction(event){
        const action=event.detail.action
        const rowId=event.detail.row.Id

        switch(action.name){
            case 'edit': 
                this.isModalOpen=true
                this.IdtoEditRecord=rowId
                break;
            case 'delete':
                this.deleteRecord(rowId);
                break;
            default:
                break;

        }
    }

    successHandler(){
        this.showToast('Success','Contact updated successfully!!','success');
        this.isModalOpen=false
        this.refreshData()
    }
    closeModal(){
        this.isModalOpen=false
        this.IdtoEditRecord=null
    }

    deleteRecord(recordId){
        deleteRecord({
            contactId:recordId
        }).then(()=>{
            this.showToast('Successfully','Contact deleted successfully','success');
            this.refreshData()
        }).catch(error=>{
            this.showToast('Error!!',error.body.message,'error');
        })
    }

    showToast(title,message,variant){
        const event= new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }

    refreshData(){
        return this.wiredContactResult?refreshApex(this.wiredContactResult):undefined;
    }

    handleSearch(event){
        this.searchKey=event.target.value
    }
    handleContactCreate(){
        this.isModalOpen=true
        this.IdtoEditRecord=null
    }
    handleRowSelection(event){
       const allselectedrows=event.detail.selectedRows
       this.selectedContacts=allselectedrows
    }
    handleBulkDelete(){
        if(this.selectedContacts.length===0){
            alert('Please select at least on row.')
            return;
        }
        const contactIds=this.selectedContacts.map(contact=>contact.Id);
        bulkDeleted({
            lstContactIds:contactIds
        }).then(result=>{
            this.showToast('Success','Contacts Deleted Successfully!!','success');
            this.refreshData()
        }).catch(error=>{
            this.showToast('Error',error.body.message,'error');
        })
    }
}