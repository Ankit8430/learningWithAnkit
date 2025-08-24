import { LightningElement,wire} from 'lwc';
import getContactList from '@salesforce/apex/refreshApexController.getContactList'
import {updateRecord} from 'lightning/uiRecordApi'
import {refreshApex} from '@salesforce/apex'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
const COLS=[
    {label:'First Name',fieldName:'FirstName',editable:true},
    {label:'Last Name',fieldName:'LastName',editable:true},
    {label:'Email',fieldName:'Email',type:'email'}
]
export default class RefreshApexDemoLWC extends LightningElement {

    draftValues=[]
    columns=COLS

    @wire(getContactList)
    contacts


    get isContactAvailable(){
        //console.log(JSON.stringify(this.contacts))
        return this.contacts && this.contacts.data && this.contacts.data.length>0?'Yes':'No'
    }


    handleSave(event){
        //console.log(JSON.stringify(event.detail.draftValues))
        const recordInputs=event.detail.draftValues.slice().map(draft=>{
            const fields=Object.assign({},draft)
            //fields={"Phone":"1234567890","id":"row-1"}
            return {fields}
        })
        const promises=recordInputs.map(recordInput=>updateRecord(recordInput))
        Promise.all(promises).then(result=>{
            this.showToast('Success!!','Contact Updated Successfully','success')
            this.draftValues=[]
            return refreshApex(this.contacts)
        }).catch(error=>{
            this.showToast('Error',error.body.message,'error')
        })
    }
    showToast(title,message,variant){
        const event=new ShowToastEvent({
            title,
            message,
            variant
        })
        this.dispatchEvent(event)
    }
}