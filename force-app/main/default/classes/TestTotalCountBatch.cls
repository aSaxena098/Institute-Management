@isTest
public class TestTotalCountBatch 
{
    @TestSetup
    public static void testDataBatchApex()
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
            att.Attendance__c = true;
            attUpdateList.add(att);
        }
        UPDATE attUpdateList;
		
    }
    
    @IsTest
    public static void attendanceTotalCountBatchTest()
    {

        Test.startTest();
        AttendanceTotalCountBatch ba = new AttendanceTotalCountBatch();
        DataBase.executeBatch(ba); 
        Test.stopTest();

        List<Attendance__c> aferBatchAttList = [Select Id,Total_Count__c from Attendance__c where Total_Count__c>0];
        System.assert(aferBatchAttList.size()==0,'Batch Apex was not executed successfully');
    }
}