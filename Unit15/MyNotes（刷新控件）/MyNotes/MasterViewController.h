

#import <UIKit/UIKit.h>
#import "NSNumber+Message.h"

enum ActionTypes {
    QUERY,      //查询操作
    REMOVE,     //删除操作
    ADD,        //添加操作
    MOD         //修改操作
};

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSURLConnectionDataDelegate>
{
    enum ActionTypes action; //请求动作标识
    NSInteger deleteRowId;//删除行号
}

@property (strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* objects;

//接收从服务器返回数据。
@property (strong,nonatomic) NSMutableData *datas;

//重新加载表视图
-(void)reloadView:(NSDictionary*)res;

//开始请求Web Service
-(void)startRequest;


@end

