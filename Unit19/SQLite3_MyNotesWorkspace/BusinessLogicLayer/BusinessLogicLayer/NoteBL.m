

#import "NoteBL.h"

@implementation NoteBL

//插入Note方法
-(NSMutableArray*) createNote:(Note*)model
{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao create:model];
    
    return [dao findAll];
}

//删除Note方法
-(NSMutableArray*) remove:(Note*)model
{
    NoteDAO *dao = [NoteDAO sharedManager];
    [dao remove:model];
    
    return [dao findAll];
}

//查询所用数据方法
-(NSMutableArray*) findAll
{
    NoteDAO *dao = [NoteDAO sharedManager];
    return [dao findAll];
}
@end
