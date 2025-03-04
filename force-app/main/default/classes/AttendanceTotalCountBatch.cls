/*
    1. coming from main
*/
public class AttendanceTotalCountBatch implements Database.Batchable<sObject>
{
    /*
        Comment from dev b2
    */ 
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Anubhav__c ,Id,Total_Count__c,Student_Name__c,Attendance__c,Course__c FROM Attendance__c';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC,List<Attendance__c> attList)
    {
        for(Attendance__c att:attList)
        {
            att.Total_Count__c=0;
            att.Attendance__c = false;
        }
        UPDATE attList;
    }
    public void finish(Database.BatchableContext BC)
    {

    }
}
