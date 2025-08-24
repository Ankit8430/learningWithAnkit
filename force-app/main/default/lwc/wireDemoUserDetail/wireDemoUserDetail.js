import { LightningElement,wire} from 'lwc';
import ID from '@salesforce/user/Id'
import {getRecord} from 'lightning/uiRecordApi'
import NAME_FIELD from '@salesforce/schema/User.Name'
import EMAIL_FIELD from '@salesforce/schema/User.Email'

const fields=[NAME_FIELD,EMAIL_FIELD]
export default class WireDemoUserDetail extends LightningElement {
    userDetail
    userId=ID
    // 005dM00000GXg1lQAD

    // @wire(adapter,{adapterConfig})
    // propertyOrFunction

    @wire(getRecord,{recordId:'$userId',fields:fields})
    userDetailHandler({data,error}){
        if(data){
            this.userDetail=data.fields
            // console.log(data)
        }
        if(error){
            console.error(error)
        }
    }

    @wire(getRecord,{recordId:'$userId',fields})
    userDetailProperty
}