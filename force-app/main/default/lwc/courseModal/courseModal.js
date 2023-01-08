import { LightningElement,api } from 'lwc';
import getStudentListFromCourseId from '@salesforce/apex/Courses.getStudentListFromCourseId';
const COLS = [
    {label:"Student ID",fieldName:"Name"},
    {label:"Student Name",fieldName:"Student_Name__c"},
    {label:"Email",fieldName:"Email__c"}
];
export default class CourseModal extends LightningElement {
    @api coursedata;
    @api courseid; 
    getStudentList = {
        courseId:''
    }
    studentList=[];
    columns = COLS;
    showStudentPopUp = false;
    closemodal(){
        this.dispatchEvent(new CustomEvent('close'),{detail:false});
    }
    openStudentModal(){
        this.showStudentPopUp = true;
        this.getStudentList = {...this.getStudentList,courseId:this.courseid};
        getStudentListFromCourseId({var:this.getStudentList}).then(result => {
            this.studentList = result;
        });
    }
    closeStuedntModal(){
        this.showStudentPopUp = false;
    }

}