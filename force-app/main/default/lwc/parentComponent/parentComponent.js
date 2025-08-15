import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    constructor(){
        super()
        console.log('Parent Constructor')
    }
    connectedCallback(){
        console.log('Parent Connected Callback')
        
    }
    renderedCallback(){
        console.log('Parent Rendered Callback')
    }
    errorCallback(error,stack){
        console.log(error.message)
        console.log(stack)
    }
}