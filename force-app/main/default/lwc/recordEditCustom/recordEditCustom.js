import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class RecordEditCustom extends LightningElement {

    objectName=ACCOUNT_OBJECT
    inputValue=''

    handleChange(event){
        this.inputValue=event.target.value
    }

    handleSubmit(event){
        event.preventDefault()
        const inputCmp=this.template.querySelector('lightning-input')
        const value=inputCmp.value
        if(!value.includes('Australia')){
            inputCmp.setCustomValidity("This account name must include 'Australia'")
        }else{
            inputCmp.setCustomValidity("")
            const fields=event.detail.fields
            fields.Name=value
            this.template.querySelector('lightning-record-edit-form').submit(fields)
        }
        inputCmp.reportValidity()
    }

    successHandler(event){
        const toastEvent=new ShowToastEvent({
            title:'Account Created',
            message:'Record Id: '+event.detail.id,
            variant:'success'
        })
        this.dispatchEvent(toastEvent)
    }
    errorHandler(event){
        const toastEvent=new ShowToastEvent({
            title:'Error creating Account',
            message:event.detail.message,
            variant:'error'
        })
        this.dispatchEvent(toastEvent)
    }
}