import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import NAME_FIELD from '@salesforce/schema/Account.Name'
import TYPE_FIELD from '@salesforce/schema/Account.Type'
export default class LightningRecordForm extends LightningElement {


    objectName=ACCOUNT_OBJECT
    fieldList=[NAME_FIELD,TYPE_FIELD]

    successHandler(event){
        const toastEvent=new ShowToastEvent({
            title:"Account Created",
            message:"Record Id: "+event.detail.id,
            variant:"success"
        })
        this.dispatchEvent(toastEvent);
    }
}