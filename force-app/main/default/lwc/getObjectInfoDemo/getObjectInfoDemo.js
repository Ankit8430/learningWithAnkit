import { LightningElement ,wire} from 'lwc';
import {getObjectInfo,getObjectInfos} from 'lightning/uiObjectInfoApi'
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity'
export default class GetObjectInfoDemo extends LightningElement {

    // defaultRecordTypeId
    @wire(getObjectInfo,{
        objectApiName:ACCOUNT_OBJECT
    })
    objectInfo
    // objectInfo({data,error}){
    //     if(data){
    //         console.log(data)
    //         this.defaultRecordTypeId=data.defaultRecordTypeId
    //     }if(error){
    //         console.error(error)
    //     }
    // }

    objectApiNames=[ACCOUNT_OBJECT,OPPORTUNITY_OBJECT]
    objectInfos
    @wire(getObjectInfos,{
        objectApiNames:'$objectApiNames'
    })
    objectInfosHandler({data,error}){
        if(data){
            console.log(data)
            this.objectInfos=data
        }if(error){
            console.error(error)
        }
    }

}