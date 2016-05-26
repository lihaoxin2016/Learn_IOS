

#import <UIKit/UIKit.h>
#import "NSNumber+Message.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSURLConnectionDataDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic,strong) NSMutableArray* objects;


@property (strong,nonatomic) NSMutableData *datas;


-(void)reloadView:(NSDictionary*)res;


-(void)startRequest;

@end
