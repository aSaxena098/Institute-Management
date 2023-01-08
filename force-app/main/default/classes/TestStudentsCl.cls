@IsTest
public class TestStudentsCl {
    
	@TestSetup
    public static void testDataStudents()
    {
        List<Course__c> couList = new List<Course__c>();
        couList.add(new Course__c(Course_Name__c='Cloud Computing',Course_Starting_Date__c=System.today()));
        INSERT couList;
        
        List<Student__c> stuListTest = new List<Student__c>();
        stuListTest.add(new Student__c(Student_Name__c='Anubhav Saxena',Guardian_Name__c='Roomy',Course__c=couList[0].Id,Year_Of_Pass__c='2023-2000',Mobile_No__c='8708060525',Permanent_Address__c='3769 Laurel Lane USA',Passed_Out_Organization__c='DCRUST'));
		INSERT stuListTest;
        
        List<Attendance__c> attList = [Select Id,Attendance__c from Attendance__c];
        List<Attendance__c> attUpdateList = new List<Attendance__c>();
        for(Attendance__c att:attList)
        {
            att.Attendance__c=true;
            attUpdateList.add(att);
        }
        UPDATE attList;
    }
    
    @isTest
    public static void getStudentsTest()
    {
       List<Student__c> stuList = Students.getStudents();
       System.assert(stuList.size()==1,'Students Data is not fetched Properly');
    }
    
    @isTest
    public static void createAttendanceRecordTest()
    {
        List<Attendance__c> attList = [Select Id from Attendance__c];
        System.assert(attList.size()==1,'Attendance List is not Created successfully');
    }
    
    @isTest
    public static void getAttendanceListFromCourseIdTest()
    {
        List<Course__c> couList = [Select Id from Course__c];
        Students.StudentVariables sv = new Students.StudentVariables();
        sv.subjectId = couList[0].Id;
        List<Attendance__c> attList = Students.getAttendanceListFromCourseId(sv);
        System.assert(attList.size()==1,'Attendance record is fetched properly from Course Id');
    }
    
    @isTest
    public static void getAttendanceListTest()
    {
        System.assert(Students.getAttendanaceList().size()==1,'Attendance List is not Created successfully');
    }
    
    @isTest
    public static void increaseTheTotalCountofAttendanceTest()
    {
        List<Attendance__c> attList = [Select Id,Attendance__c,Total_Count__c from Attendance__c];
		System.assert(attList[0].Total_Count__c==1,'Total Count was not increased');
    }
    
    @isTest
    public static void deleteAttendanceDetailsTest()
    {
      	List<Course__c> couList = [Select Id from Course__c];
     	Students.StudentVariables sv = new Students.StudentVariables();
      	sv.subjectId = couList[0].Id;
        Students.deleteAttendanceDetails(sv);
        List<Attendance__c> attList = [Select Id,Attendance__c from Attendance__c];
        System.assert(attList[0].Attendance__c==false,'Attendace was not switched to false');
    }
    
}