public with sharing class Courses {
    public class Variables{
        @AuraEnabled
        public String searchCourse {get;set;}
        @AuraEnabled
        public Id courseId {get;set;}
    }
    @AuraEnabled(cacheable=true)
    public static List<Course__c> getAllCourses()
    {
        return [SELECT Id, Course_Name__c, Faculty__c, Course_Starting_Date__c, Course_Timings__c, Course_Closing_Date__c, Course_Intake_Strength__c, Course_Duration__c, Contact_Person__c, Contact_Number__c, Regestered_Strength__c,Course_Logo__c  FROM Course__c];
    }
    @AuraEnabled
    public static Integer getsearchCourseListSize(Variables var)
    {
        String searchKey = var.searchCourse;
        List<Course__c> searchCourseList =  [SELECT Id, Course_Name__c, Faculty__c, Course_Starting_Date__c, Course_Timings__c, Course_Closing_Date__c, Course_Intake_Strength__c, Course_Duration__c, Contact_Person__c, Contact_Number__c, Regestered_Strength__c  FROM Course__c WHERE Course_Name__c =:searchKey];
        return searchCourseList.size();
    }
    @AuraEnabled
    public static List<Course__c> getCourseDetailsFromId(Variables var)
    {
        Id courseRecordId = var.courseId;
        List<Course__c> courseDetailsList = [SELECT Id, Course_Name__c, Faculty__c, Course_Starting_Date__c, Course_Timings__c, Course_Closing_Date__c, Course_Intake_Strength__c, Course_Duration__c, Contact_Person__c, Contact_Number__c, Regestered_Strength__c  FROM Course__c WHERE Id =:courseRecordId];
        return courseDetailsList;
    }
    @AuraEnabled
    public static List<Student__c> getStudentListFromCourseId(Variables var)
    {
        Id courseRecordId = var.courseId;
        List<Student__c> studentList = [SELECT Id,Name,Student_Name__c,Email__c FROM Student__c where Course__r.Id =: courseRecordId]; 
        System.debug('Hello from Main');
        return studentList; 
    }
}
