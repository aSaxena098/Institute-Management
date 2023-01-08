import { LightningElement,api } from 'lwc';
import deleteAttendanceDetails from '@salesforce/apex/Students.deleteAttendanceDetails';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ClearAttendance extends LightningElement {
    @api clearattsubjectid;
    selectedCourseId={
        subjectId:''
    }
    closeattendancemodal(){
        this.dispatchEvent(new CustomEvent('closeclearattendance',{detail:false}));
    }
    clearAttendaceCheckbox(){
        this.selectedCourseId = {...this.selectedCourseId,subjectId:this.clearattsubjectid};
        deleteAttendanceDetails({var:this.selectedCourseId}).then(()=>{
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success',
                message: 'Previous Attendances were Removed Successfully !!!',
                variant: 'success'
            }));  
            this.closeattendancemodal();  
            eval("$A.get('e.force:refreshView').fire();");
        })
        .catch(error=>{
            console.log(error);
        })
    }
    
}