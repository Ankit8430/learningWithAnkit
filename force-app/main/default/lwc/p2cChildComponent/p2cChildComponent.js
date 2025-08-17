import { LightningElement,api} from 'lwc';

export default class P2cChildComponent extends LightningElement {

    @api message
    @api cardHeading
    @api number
    @api isValid

}