public class ProjectSharingService {
    public static void shareProject(Id projectId, Id userId){
     	Project__Share ps=new Project__share();
        ps.ParentId=projectId;
        ps.UserOrGroupId=userId;
        ps.AccessLevel='Read';
        insert ps;
    }
}