import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
export default class Notification extends LightningElement {


    successToastHandler(){
       this.showToast('Success!!','Account Created!!','success')
    }

    errorToastHandler(){
       this.showToast('Error!!','Account Creation failed','error')
    }

    warningToastHandler(){
        this.showToast('Warning!!','Password should have 15 characters!!','warning')
    }

    infoToastHandler(){
        this.showToast('Info!!','Summer 20 realease is available!!','info')
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