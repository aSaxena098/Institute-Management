public with sharing class Students {
    public class StudentVariables
    {
        @AuraEnabled
        public Id subjectId {get;set;}
    }
    public static List<Student__c> getStudents()
    {
        return [SELECT Id, Student_Name__c, Guardian__c, Guardian_Name__c, Community__c, Proofs_Submitted__c, Passport_No__c, Gender__c, DOB__c, Age__c, Father_Occupation__c, Mother_Occupation__c, Family_Annual_Income__c, Educational_Qualification__c, Year_Of_Pass__c, Passed_Out_Organization__c, Mobile_No__c, Address_For_Correspondence__c, Permanent_Address__c, Father_s_Mobile_No__c, Email__c, Interested_Course__c, Course__c FROM Student__c];
    }
    @AuraEnabled(cacheable=true)
    public static List<Attendance__c> getAttendanaceList()
    {
        return [SELECT Id,Student_Name__c,Student_Name__r.Student_Name__c,Attendance__c,Course__c,Course__r.Course_Name__c FROM Attendance__c];
    }
    @AuraEnabled
    public static List<Attendance__c> getAttendanceListFromCourseId(StudentVariables var)
    {
        Id courseId = var.subjectId;
        List<Attendance__c> attList = [SELECT Id,Student_Name__c,Student_Name__r.Student_Name__c,Attendance__c,Course__c,Course__r.Course_Name__c FROM Attendance__c where Course__r.Id=:courseId];
        return attList;
    }
    public static void createAttendanceRecord(List<Student__c> stuList)
    {
        Attendance__c att = new Attendance__c();
        List<Attendance__c> attList = new List<Attendance__c>();
        for(Student__c stuRec:stuList)
        {
            att.Student_Name__c = stuRec.Id;
            att.Course__c = stuRec.Course__c;
            attList.add(att);
        }
        INSERT attList;
    }
    public static void increaseTheTotalCountofAttendance(List<Attendance__c> attList, Map<Id,Attendance__c> oldAttRecords,Map<Id,Attendance__c> newAttRecords)
    {
        for(Attendance__c att:attList)
        {
            if(oldAttRecords.get(att.Id).Attendance__c==false && newAttRecords.get(att.Id).Attendance__c==true)
            {
                att.Total_Count__c++;
            }
        }
    }
    @AuraEnabled
    public static void deleteAttendanceDetails(StudentVariables var)
    {
        Id courseId = var.subjectId;
        List<Attendance__c> attList = [SELECT Id,Student_Name__c,Student_Name__r.Student_Name__c,Attendance__c,Course__c,Course__r.Course_Name__c FROM Attendance__c where Course__r.Id=:courseId];
        List<Attendance__c> updatedattList = new List<Attendance__c>();
        for(Attendance__c att:attList)
        {
            att.Attendance__c = false;
            updatedattList.add(att);
        }
        UPDATE updatedattList;
    }
}