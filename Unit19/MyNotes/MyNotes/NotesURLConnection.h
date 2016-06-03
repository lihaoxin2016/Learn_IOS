

#import <Foundation/Foundation.h>

@protocol NotesURLConnectionDelegate

//查询所有数据方法 成功
-(void) findAllFinished:(NSDictionary*)res;
//查询所有数据方法 失败
-(void) findAllFailed:(NSError*)error;

@end


@interface NotesURLConnection : NSObject <NSURLConnectionDataDelegate>

//保存数据列表
@property(nonatomic, strong)NSMutableArray* listData;
//接收从服务器返回数据
@property(nonatomic, strong)NSMutableData* datas;

@property(nonatomic, weak)id<NotesURLConnectionDelegate> delegate;

//查询所有数据方法
-(void) findAll;


@end
