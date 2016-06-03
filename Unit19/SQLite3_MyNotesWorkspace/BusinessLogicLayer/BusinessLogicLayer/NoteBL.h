

#import <Foundation/Foundation.h>

#import <PersistenceLayer/NoteDAO.h>
#import <PersistenceLayer/Note.h>

@interface NoteBL : NSObject

//插入Note方法
-(NSMutableArray*) createNote:(Note*)model;

//删除Note方法
-(NSMutableArray*) remove:(Note*)model;

//查询所用数据方法
-(NSMutableArray*) findAll;


@end
