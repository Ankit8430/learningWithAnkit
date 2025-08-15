import { LightningElement,wire} from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class SampleLWC extends LightningElement {

    accounts
    @wire(getAccounts)
    accountHandler({data,error}){
        if(data){
            this.accounts=data
        }if(error){
            console.error(error)
        }
    }
}