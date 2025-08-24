import { LightningElement } from 'lwc';
import {deleteRecord} from 'lightning/uiRecordApi'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class DeleteRecordDemo extends LightningElement {

    recordId;
    changeHandler(event){
        this.recordId=event.target.value
    }
    deleteHandler(){
        deleteRecord(this.recordId).then(result=>{
            this.showToast('Success!!','Record Deleted Successfully','success')
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