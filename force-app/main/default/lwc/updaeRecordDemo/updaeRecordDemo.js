import { LightningElement,wire } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import {getListUi} from 'lightning/uiListApi'
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
const COLS=[
    {label:'Id',fieldName:'Id'},
    {label:'Name',fieldName:'Name'},
    {label:'Title',fieldName:'Title'},
    {label:'Phone',fieldName:'Phone',type:'tel',editable:true},
    {label:'Email',fieldName:'Email',type:'email',editable:true},
]
export default class UpdaeRecordDemo extends LightningElement {
 
    contacts=[]
    draftValues=[]
    columns=COLS

    @wire(getListUi,{
        objectApiName:CONTACT_OBJECT,
        listViewApiName:'AllCOntacts'
      })
      listViewHandler({data,error}){
        if(data){
            console.log(data)
            this.contacts=data.records.records.map(item=>{
                return{
                    // "Name":item.fields.Name.value
                    "Id":this.getValue(item,"Id"),
                    "Name":this.getValue(item,"Name"),
                    "Title":this.getValue(item,"Title"),
                    "Phone":this.getValue(item,"Phone"),
                    "Email":this.getValue(item,"Email")
                }
            })
        }if(error){
            console.error(error)
        }
    }

    getValue(data,field){
        return data.fields[field].value
    }

    handleSave(event){
        //console.log(JSON.stringify(event.detail.draftValues))
        const recordInputs=event.detail.draftValues.map(draft=>{
            const fields={...draft}
            //fields={"Phone":"1234567890","id":"row-1"}
            return {fields:fields}
        })
        const promises=recordInputs.map(recordInput=>{
           updateRecord(recordInput)
        })
        Promise.all(promises).then(result=>{
            this.showToast('Success!!','Contact Updated Successfully','success')
            this.draftValues=[]
            
        }).catch(error=>{
            this.showToast('Error',error.body.message,'error')
        })
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