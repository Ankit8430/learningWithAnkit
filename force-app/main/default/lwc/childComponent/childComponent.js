import { LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {

    constructor(){
        super()
        console.log('Child Constructor')
    }
    connectedCallback(){
        console.log('Child Connected Callback')
        throw new Error('Loading of Child Component Failed')
    }
    renderedCallback(){
        console.log('Child Rendered Callback')
    }


    // disconnectedCallback(){
    //     alert('Child Disconnected Callback')
    // }
    // disconnectHandler(){
    //     this.disconnectedCallback()
    // }
}