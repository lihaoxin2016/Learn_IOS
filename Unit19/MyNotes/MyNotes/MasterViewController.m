

#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    NotesURLConnection* conn = [[NotesURLConnection alloc] init];
    conn.delegate = self;
    //开始查询
    [conn findAll];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  forIndexPath:indexPath];
    
    NSMutableDictionary*  dict = self.listData[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"Content"];
    cell.detailTextLabel.text = [dict objectForKey:@"CDate"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //       NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //        Note  *note = self.listData[indexPath.row];
        //        [[segue destinationViewController] setDetailItem:note];
    }
}


#pragma mark - NotesURLConnection委托协议
//查询所有数据方法 成功
-(void) findAllFinished:(NSDictionary*)res {
    NSNumber *resultCodeObj = [res objectForKey:@"ResultCode"];
    if ([resultCodeObj integerValue] >=0) {
        self.listData = [res objectForKey:@"Record"];
        [self.tableView reloadData];
    } else {
        NSString *errorStr = [resultCodeObj errorMessage];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误信息"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

//查询所有数据方法 失败
-(void) findAllFailed:(NSError*)error {
    
}


@end
