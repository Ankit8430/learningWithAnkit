import { LightningElement } from 'lwc';

export default class C2pParentComponent extends LightningElement {
    showModal=false
    msg
    clickHandler(){
        this.showModal=true
    }

    closeModal(event){
        this.msg=event.detail
        this.showModal=false
    }
}