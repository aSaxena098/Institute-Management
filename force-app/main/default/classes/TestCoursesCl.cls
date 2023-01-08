@IsTest
public class TestCoursesCl {
    @TestSetup
    public static void testCourseData()
    {
		List<Course__c> couList = new List<Course__c>();
        couList.add(new Course__c(Course_Name__c='Cloud Computing',Course_Starting_Date__c=System.today()));
        INSERT couList;
        
        List<Student__c> stuList = new List<Student__c>();
        stuList.add(new Student__c(Student_Name__c='Anubhav Saxena',Guardian_Name__c='Roomy',Course__c=couList[0].Id,Year_Of_Pass__c='2023-2000',Mobile_No__c='8708060525',Permanent_Address__c='3769 Laurel Lane USA',Passed_Out_Organization__c='DCRUST'));
        INSERT stuList;
    }
    @IsTest
    public static void getAllCoursesTest()
    {
        List<Course__c> courseList = Courses.getAllCourses();
        List<Course__c> courseTestList = [Select Id From Course__c];
        System.assert(courseList.size()==courseTestList.size(), 'getAllCourse() method is not fetching all the courses');
    }
    @IsTest
    public static void getsearchCourseListSizeTest()
    {
        Courses.Variables cv = new Courses.Variables();
        cv.searchCourse = 'Cloud Computing';
        Integer size = Courses.getsearchCourseListSize(cv);
        System.assert(size==1,'Course Name is not searched properly');
    }
    
    @IsTest
    public static void getCourseDetailsFromIdTest()
    {
        Courses.Variables cvt = new Courses.Variables();
        List<Course__c> cou = [Select Id From Course__c where Course_Name__c='Cloud Computing'];
        cvt.courseId = cou[0].Id;
        List<Course__c> couListTest = Courses.getCourseDetailsFromId(cvt);
        System.assert(couListTest.size()==1,'Course is not searched by Course Id');
    }
    @IsTest
    public static void getStudentListFromCourseIdTest()
    {
        Courses.Variables cv = new Courses.Variables();
        List<Course__c> cou = [Select Id From Course__c where Course_Name__c='Cloud Computing'];
        cv.courseId = cou[0].Id;
        List<Student__c> stu = Courses.getStudentListFromCourseId(cv);
        system.assert(stu.size()==1,'Students are searched by Id');
    }
}