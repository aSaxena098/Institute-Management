import { LightningElement,wire } from 'lwc';
import getAttendanceListFromCourseId from '@salesforce/apex/Students.getAttendanceListFromCourseId';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAllCourses from '@salesforce/apex/Courses.getAllCourses';
const COLS = [
    {label:'Name',fieldName:'Name',
    cellAttributes:
        {
            class:'slds-theme_shade slds-theme_alert-texture'
        }
    },
    {label:'Mark Attendance',fieldName:'Attendance__c',editable:true,type: 'boolean',cellAttributes: { alignment: 'center' }}
];
export default class MarkAttendance extends LightningElement {
    showClearAttendancePopUp = false;
    columnsList = COLS;
    dataList;
    value;
    getAttendanceDetailsById={
      subjectId:'',
    }
    clearAttendanceSubjectId;
    courseNames;
    draftValues = [];
    @wire(getAllCourses)
    getCourseName({data,error}){
        if(data){
            console.log(data);
            this.courseNames =  data.map(item => {
                return {label:item.Course_Name__c,value:item.Id};
            });
        }else if(error){
            console.log(error);
        }
    }
    get options() {
        return this.courseNames;
    }
    handleChange(event){
        this.value = event.detail.value;
        this.getAttendanceDetailsById = {...this.getAttendanceDetailsById,subjectId:this.value};
        this.clearAttendanceSubjectId = this.getAttendanceDetailsById.subjectId;
        getAttendanceListFromCourseId({var:this.getAttendanceDetailsById}).then(response=>{
            let tempRecords = JSON.parse(JSON.stringify(response));
            tempRecords = tempRecords.map(row => {
                return {...row, Name:row.Student_Name__r.Student_Name__c};
            });
            this.dataList = tempRecords;
        })
    }
    handleSave(event){
        console.log('save button clicked!!');
        console.log(JSON.stringify(event.detail.draftValues));
        const recordInputs = event.detail.draftValues.map(draft=>{
            const fields = {...draft};
            return {fields:fields};
        });
        const promises = recordInputs.map(recordInput=>{
            updateRecord(recordInput);
        });
        Promise.all(promises).then(()=>{
            this.draftValues= [];
            this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'Attendance was updated Successfully',
                    variant: 'success'
            }));
            eval("$A.get('e.force:refreshView').fire();");
        }).catch((error)=>{
            console.log(error);
        });
        
    }
    clearAttendance(){
        this.showClearAttendancePopUp = true;
    }
    closeattendancemodal(event){
        this.showClearAttendancePopUp = event.detail;
    }
}