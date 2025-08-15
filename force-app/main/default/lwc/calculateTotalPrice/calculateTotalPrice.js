import { LightningElement,api} from 'lwc';
import calculateTotalPrice from '@salesforce/apex/ProductController.calculateTotalPrice'
import updateProduct from '@salesforce/apex/ProductController.updateProduct'
import { CloseActionScreenEvent } from 'lightning/actions'
export default class CalculateTotalPrice extends LightningElement {
    @api recordId

    isTotalPrice=false
    isShowData=true
    unitPrice=0
    quantity=0
    discount=0
    totalPrice=0

    handleUnitPriceChange(event){
        this.unitPrice=parseFloat(event.target.value)
    }
    handleQuantityChange(event){
        this.quantity=parseInt(event.target.value)
    }
    handleDiscountChange(event){
        this.discount=parseFloat(event.target.value)
    }
    getCalculatePrice(){
        calculateTotalPrice({
                unitPrice:this.unitPrice,
                quantity:this.quantity,
                discount:this.discount
        }).then((result)=>{
            console.log(result)
            this.totalPrice=parseFloat(result)
            this.isTotalPrice=true
            this.isShowData=false
        }).catch((error)=>{
            console.error(error);
        })
    }

    handleSave(){
        this.isTotalPrice=false
        this.dispatchEvent(new CloseActionScreenEvent());
        updateProduct({
            ids:this.recordId,
            totalPrice:this.totalPrice
        }).then(()=>{
            console.log('successfully')
        }).catch((error)=>{
            console.log(error)
        })  
        setTimeout(()=>{
            window.location.reload()
        },1000)
    }
}