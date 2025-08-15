import { LightningElement,track} from 'lwc';
import getAccounts from '@salesforce/apex/PagingApexController.getAccounts';
import getTotalRecords from '@salesforce/apex/PagingApexController.getTotalRecords';
export default class PagingLWCComponent extends LightningElement {
    @track accounts=[]
    searchKey=''
    pageNumber=1
    pageSize=100
    totalRecords=0
    totalPage=0

    columns=[
        {label:'Name',fieldName:'Name'},
        {label:'Phone',fieldName:'Phone'},
        {label:'Type',fieldName:'Type'}
    ]

    connectedCallback(){
        this.loadTotalRecords();
    }

    loadTotalRecords(){
        getTotalRecords().then(result=>{
            this.totalRecords=result
            this.totalPage=Math.ceil(this.totalRecords/this.pageSize);
            this.loadAccountData();
        }).catch(error=>{
            console.error(error);
        })
    }
    loadAccountData(){
        getAccounts({
            pageNumber: this.pageNumber,
            pageSize:this.pageSize,
            searchKeyWord:this.searchKey

        }).then(result=>{
            this.accounts=result
        }).catch(error=>{
            console.error(error)
        })
    }

    handleNextButton(){
        if(this.pageNumber<this.totalPage){
            this.pageNumber++;
            this.loadAccountData();
        }
    }
    handlePreviousButton(){
        if(this.pageNumber>1){
            this.pageNumber--;
            this.loadAccountData()
        }
    }

    get disablePrevious(){
        return this.pageNumber===1
    }

    get disableNext(){
        return this.pageNumber===this.totalPage
    }

    handleSearchKey(event){
        this.searchKey=event.target.value;
        this.loadAccountData()
    }
}