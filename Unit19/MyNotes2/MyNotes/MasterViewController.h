

#import <UIKit/UIKit.h>


@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* listData;


@end
