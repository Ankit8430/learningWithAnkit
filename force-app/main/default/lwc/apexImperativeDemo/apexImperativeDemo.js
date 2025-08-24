import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/AccountControllerLWC.getAccounts'
import findAccounts from '@salesforce/apex/AccountControllerLWC.findAccounts'
export default class ApexImperativeDemo extends LightningElement {

    accounts

    handleClick(){
        getAccounts().then(result=>{
            this.accounts=result
            // console.log(result)
        }).catch(error=>{
            console.error(error)
        })
    }


    searchKey=''
    accountList
    timer
    searchHandler(event){
        window.clearTimeout(this.timer)
        this.searchKey=event.target.value
        this.timer=setTimeout(()=>{
                this.callApex()
            },1000)        
    }
    callApex(){
        findAccounts({
            searchKey:this.searchKey
        }).then(result=>{
            this.accountList=result
        }).catch(error=>{
            console.error(error)
        })
    }
}