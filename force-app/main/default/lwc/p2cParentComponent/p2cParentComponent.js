import { LightningElement} from 'lwc';

export default class P2cParentComponent extends LightningElement {

    // accountData=[
    //     {
    //         id:"1",
    //         name:"Ankit Gupta",
    //         phone:"1234567890"
    //     },
    //     {
    //         id:"2",
    //         name:"Aman Gupta",
    //         phone:"1234567890"
    //     },
    //     {
    //         id:"3",
    //         name:"Naman Gupta",
    //         phone:"1234567890"
    //     },
    //     {
    //         id:"4",
    //         name:"Vikas Gupta",
    //         phone:"1234567890"
    //     },
    // ]

    // percentage=50

    // changeHandler(event){
    //     this.percentage=event.target.value
    // }


    handleClick(){
        this.template.querySelector('c-p2c-slider-component').resetSlider()
    }
}