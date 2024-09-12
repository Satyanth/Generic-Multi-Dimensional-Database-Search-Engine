import { Component,AfterViewInit, ViewChild } from '@angular/core';
import { HttpClient, HttpHeaders} from '@angular/common/http';
import { exhaustAll } from 'rxjs';


declare var HTMLOptionElement: { new (): HTMLOptionElement };

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})

export class HomeComponent {

  

  collegeData:any;
  automobileData:any;
  collegeDataQuestions:any;

  options=['Select a Domain','Colleges','Automobiles'];
  selectedDomainType = this.options[0];

  currentPage=0;

  disabledPrevious:boolean=true;
  disabledNext:boolean=false;
  
  bookmark ='';
  userID:string='';
  welcomeMessage:string;
  bookmarks:any;
  bname:string='';
  domainType:string='';
  results:any;
  collegeRes:string='';
  radioData:any;
  checkData:string[]=[];
  checkValues:string[]=[];
  checkList:any;
  regionData:string[]=[];
  selectedRegions:string[]=[];
  codeValue:any;
  responses:any={};
  radioValue:string='';
  graphqlUrl = 'http://127.0.0.1:5000/graphql';

  constructor(private http: HttpClient) {
      this.welcomeMessage='';
   }

 

  updateWelcomeMessage() {
    this.welcomeMessage = 'Welcome, ' + this.userID ;
    this.displayBookmarks();

  }
  onRadioSelectionChange(radioValue:string,value:string)
  {
      this.radioData=value;
      this.responses[radioValue]=value;

  }


  onOptionsSelected(propName:string)
  {
    this.responses[propName] = this.codeValue
  }


  displayBookmarks() {
    const query = `
      query {
        bookmarks (domainName:"${this.domainType}",userId:"${this.userID}"){
         bname
        }
      }
    `;
    this.http.post(this.graphqlUrl, { query }).subscribe((data:any)=>{
      this.bookmarks=data.data.bookmarks;
    });
  }

   
  onCheckboxSelectionChange(checkBoxValue:string,value: string, input: EventTarget) {
    const checkbox = input as HTMLInputElement;
    if (checkbox.checked) {
      this.checkData.push(value);
      this.responses[checkBoxValue].push(value);
    } else {
      this.checkData = this.checkData.filter(item => item !== value);
      this.responses[checkBoxValue]=this.responses[checkBoxValue].filter((item:any) => item !== value);
    }
  }
  

  async createBookmark() {

    
    
    var queryString:any='';
    for(let key of Object.keys(this.responses))
    {
        queryString+=key+'='+this.responses[key]+'&';
    }
  
    queryString=queryString.slice(0, -1);

    const mutation = `
    mutation {
      createBookmark(
        bname: "${this.bookmark}",
        bookmark: "${queryString}",
        domainName: "${this.domainType}",
        userId: "${this.userID}"
      ) {
        isSuccess
      }
    }
  `;

    const response = await fetch(this.graphqlUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        query: mutation
      })
    });

    const result = await response.json();
    console.log(result);

    this.displayBookmarks();
  }

  resetData()
  {
    this.collegeData=null;
    this.automobileData=null;
    this.selectedDomainType = this.options[0];
    
    if(this.results.length>0)
    {
      this.results=null;
    }
  }

  nextPage()
  {

    var domainData:any;
    this.disabledPrevious=false;
    this.currentPage+=3;

    if(this.currentPage==12)
    {
      this.disabledNext=true;
    }

    const query = `
    query {
      properties(domainName:"${this.domainType}", offset: ${this.currentPage}, limit: 3) {
        propertyName
        propertyQuestion
        propertyDisplayType
        propertyDetails{
         allowedValue
         allowedValueCode
       }
       }
    }
`;
    if(this.domainType=='Colleges')
    {
        
     this.http.post(this.graphqlUrl,{query}).subscribe((data:any)=>{

      this.collegeData=data.data;
      this.collegeData.properties.forEach((element:any, index:any) => {

        this.collegeData.properties[index].propertyDetails.sort((a:any,b:any) => a.allowedValueCode-b.allowedValueCode);
        

        this.responses[element.propertyName]='';
        if(element.propertyDisplayType==='radio' || element.propertyDisplayType==='checkbox' || element.propertyDisplayType==='multiselect'){
          this.responses[element.propertyName]=[];
        }
      });
      });
    }
    else
    {
      this.http.post(this.graphqlUrl,{query}).subscribe((data:any)=>{

        this.automobileData=data.data;
        this.automobileData.properties.forEach((element:any, index:any) => {
  
          this.automobileData.properties[index].propertyDetails.sort((a:any,b:any) => a.allowedValueCode-b.allowedValueCode);
          
  
          this.responses[element.propertyName]='';
          if(element.propertyDisplayType==='radio' || element.propertyDisplayType==='checkbox' || element.propertyDisplayType==='multiselect'){
            this.responses[element.propertyName]=[];
          }
        });
        });
    }
  }

  previousPage(){
    this.currentPage-=3;

    if(this.currentPage==0)
       this.disabledPrevious=true;

    var domainData:any;
    if(this.domainType==='Colleges')
      domainData=this.collegeData;
    else
      domainData=this.automobileData;

    const query = `
    query {
      properties(domainName:"${this.domainType}", offset: ${this.currentPage}, limit: 3) {
        propertyName
        propertyQuestion
        propertyDisplayType
        propertyDetails{
         allowedValue
         allowedValueCode
       }
       }
    }
`;


     this.http.post(this.graphqlUrl,{query}).subscribe((data:any)=>{

        domainData=data.data;
        domainData.properties.forEach((element:any, index:any) => {

          domainData.properties[index].propertyDetails.sort((a:any,b:any) => a.allowedValueCode-b.allowedValueCode);
          

          this.responses[element.propertyName]='';
          if(element.propertyDisplayType==='radio' || element.propertyDisplayType==='checkbox' || element.propertyDisplayType==='multiselect'){
            this.responses[element.propertyName]=[];
          }
        });
        });

  }

  
 async deleteBookmark(bookmarkName:string) {
    const mutation = `
    mutation {
      deleteBookmark(
        bname: "${bookmarkName}",
        domainName: "${this.domainType}",
        userId: "${this.userID}"
      ) {
        isSuccess
      }
    }
  `;

    const response = await fetch(this.graphqlUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        query: mutation
      })
    });

    const result = await response.json();
    console.log(result);

    this.displayBookmarks();
   
  }

  retriveResults()
  {
  
    var queryString:any='';
    for(let key of Object.keys(this.responses))
    {
        queryString+=key+'='+this.responses[key]+'&';
    }
  
    queryString=queryString.slice(0, -1);

    const query = `
    query {
      searchResults(domainName:"${this.domainType}", queryParams: "${queryString}") {
        name
        url
      }
    }
`;

    this.http.post(this.graphqlUrl, { query }).subscribe((data:any)=>{
      
      this.results=data.data.searchResults;
    });

  }
  
  onOptionChange(event:any) {

    if(event.target.value === 'Select a Domain'){
      this.collegeData=null;
      this.automobileData=null;
    }


    else if(event.target.value === 'Colleges'){
      this.domainType=event.target.value;

      const query = `
    query {
      properties(domainName:"${this.domainType}", offset: ${this.currentPage}, limit: 3) {
        propertyName
        propertyQuestion
        propertyDisplayType
        propertyDetails{
         allowedValue
         allowedValueCode
       }
       }
    }
`;


     this.http.post(this.graphqlUrl,{query}).subscribe((data:any)=>{

        this.collegeData=data.data;
        
        this.collegeData.properties.forEach((element:any, index:any) => {

          this.collegeData.properties[index].propertyDetails.sort((a:any,b:any) => a.allowedValueCode-b.allowedValueCode);
          

          this.responses[element.propertyName]='';
          if(element.propertyDisplayType==='radio' || element.propertyDisplayType==='checkbox' || element.propertyDisplayType==='multiselect'){
            this.responses[element.propertyName]=[];
          }
        });
        this.collegeDataQuestions=this.collegeData;

        });

       

        this.automobileData=null;
     
    }
    
    else{
      
      this.domainType=event.target.value;

      const query = `
    query {
      properties(domainName:"${this.domainType}", offset: 0, limit: 3) {
        propertyName
        propertyQuestion
        propertyDisplayType
        propertyDetails{
         allowedValue
         allowedValueCode
       }
       }
    }
`;


      this.http.post(this.graphqlUrl,{query}).subscribe((data:any)=>{

        this.automobileData=data.data;
        this.automobileData.properties.forEach((element:any, index:any) => {

          this.automobileData.properties[index].propertyDetails.sort((a:any,b:any) => a.allowedValueCode-b.allowedValueCode);
          

          this.responses[element.propertyName]='';
          if(element.propertyDisplayType==='radio' || element.propertyDisplayType==='checkbox' || element.propertyDisplayType==='multiselect' || element.propertyDisplayType==='select'){
            this.responses[element.propertyName]=[];
          }
        });
        });

       

        this.collegeData=null;
     
    }

     
}

}



