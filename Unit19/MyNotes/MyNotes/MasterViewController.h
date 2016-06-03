

#import <UIKit/UIKit.h>
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"

#import "NotesURLConnection.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NotesURLConnectionDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* listData;

//接收从服务器返回数据。
@property (strong,nonatomic) NSMutableData *datas;


@end
