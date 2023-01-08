import { LightningElement,wire} from 'lwc';
import getsearchCourseListSize from '@salesforce/apex/Courses.getsearchCourseListSize';
import getCourseDetailsFromId from '@salesforce/apex/Courses.getCourseDetailsFromId';
import getAllCourses from '@salesforce/apex/Courses.getAllCourses';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const actions = [
    { label: 'Show details', name: 'show_details' },
];
const COLS = [
   {
      label:"Course Name",fieldName:"Course_Name__c",
      cellAttributes: 
      {
         class: 'slds-theme_shade slds-theme_alert-texture',
      }
   },
   {label:"Faculty",fieldName:"Faculty__c",cellAttributes: { alignment: 'center' }},
   {label:"Start Date",fieldName:"Course_Starting_Date__c",cellAttributes: { alignment: 'center' }},
   {label:"Timings",fieldName:"Course_Timings__c",cellAttributes: { alignment: 'center' }},
   {label:"Contact",fieldName:"Contact_Number__c",cellAttributes: { alignment: 'center' }},
   {
      type: 'action',
      typeAttributes: { rowActions: actions },
   }
   
];
export default class SearchCourses extends LightningElement {
   courseId;
   showCourseModal=false;
   courseListData=[];
   courseDetailsById;
   columns = COLS;
   record={};
   searchText={
      searchCourse:'',
   }
   getCourseDetailsById={
      courseId:'',
   }
   // Fetching the Course Data from the Apex Method
   @wire(getAllCourses)
   courseList({data,error}){
      if(data){
         console.log(data);
         this.courseListData = data;
      }else if(error){
         console.log(error);
      }
   }
   // Searching Courses from Serach input
   searchHandler(event) {
      if (event.keyCode == 13) {
         this.searchText = {...this.searchText,searchCourse:event.target.value}
         if(this.searchText.searchCourse!==''){
            getsearchCourseListSize({var:this.searchText}).then(data=>{
               if(data>0){
                  this.dispatchEvent(new ShowToastEvent({
                  title: 'Search Successfull',
                  message: 'Course Found',
                  variant: 'success'
                  }));
               }else if(data==0){
                  this.dispatchEvent(new ShowToastEvent({
                     title: 'Search Error',
                     message: 'No Course Found',
                     variant: 'error'
                  })); 
               }
            })
         }else if(this.searchText.searchCourse==''){
            this.dispatchEvent(new ShowToastEvent({
               title: 'Search Error',
               message: 'Type the Course Name in the Search',
               variant: 'error'
            }));
         } 
      }
   }
   // Show Course Details 
   handleRowAction(event) {
      const actionName = event.detail.action.name;
      const row = event.detail.row;
      switch (actionName) {
         case 'show_details':
            this.showRowDetails(row);
            break;
            default:
      }
   }
   showRowDetails(row) {
      this.record = row;
      console.log("show row details "+JSON.stringify(this.record));
      this.courseId = this.record.Id;
      this.getCourseDetailsById = {...this.getCourseDetailsById,courseId:this.record.Id};
      getCourseDetailsFromId({var:this.getCourseDetailsById}).then(result=>{
         console.log(result);
         this.courseDetailsById = result;
         console.log(this.courseDetailsById);
         this.showCourseModal=true;
      })
   }
   // Close Course Modal Pop Up
   closeHandler(event){
      console.log(event.detail);
      this.showCourseModal = event.detail;
   }
}