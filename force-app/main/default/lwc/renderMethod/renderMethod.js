import { LightningElement } from 'lwc';
import singinTemplate from './SiginTemplate.html'
import signupTemplate from './SignupTemplate.html'
import renderMethod from './renderMethod.html'
export default class RenderMethod extends LightningElement {

    selectBtn=''

    handleClick(event){
        this.selectBtn=event.target.label
        // console.log(event.target.label)
    }

    render(){
        return this.selectBtn==='SignUp' ? signupTemplate :
        this.selectBtn==='Sigin' ? singinTemplate :
        renderMethod;
    }
}