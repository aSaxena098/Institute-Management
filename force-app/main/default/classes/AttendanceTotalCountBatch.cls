/*
    1. coming from main
    2. Coming from dev b1
*/
public class AttendanceTotalCountBatch implements Database.Batchable<sObject>
{
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id,Total_Count__c,Student_Name__c,Attendance__c,Course__c FROM Attendance__c';
        Sytem.debug('Testiging DEV_b1');
        return Database.getQueryLocator(query);
    }
    //Murakmi
    public void execute(Database.BatchableContext BC,List<Attendance__c> attList)
    {
        for(Attendance__c att:attList)
        {
            att.Total_Count__c=0.1;
            System.debug('Hello');
            att.Attendance__c = false;
        }
        UPDATE attList;
    }
    public static void helloWorld(){
        System.debug('Heeleo world!!');
    }
    public void finish(Database.BatchableContext BC)
    {
        System.debug('Hello Dev b2');
    }
    // Murakmi 2
    public void main(){
        //Murakmi 3
    }
}
