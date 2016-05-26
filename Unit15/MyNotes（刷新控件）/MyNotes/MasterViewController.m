

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    
    //查询请求数据
    action = QUERY;
    [self startRequest];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
}

-(void) refreshTableView
{
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中..."];
        
        //查询请求数据
        action = QUERY;
        [self startRequest];
    }
}

//
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
//    
//    action = QUERY;
//    [self startRequest];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary*  dict = self.objects[indexPath.row];
        
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        
        [controller setDetailItem:[dict objectForKey:@"ID"]];
        [controller setDetailContent: [dict objectForKey:@"Content"]];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSMutableDictionary*  dict = self.objects[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"Content"];
    cell.detailTextLabel.text = [dict objectForKey:@"CDate"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据
        action = REMOVE;
        deleteRowId = indexPath.row;
        [self startRequest];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


/*
 * 开始请求Web Service
 */
-(void)startRequest {
    
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSString *post;
    if (action == QUERY) {//查询处理
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@", @"<你的51work6.com用户邮箱>",@"JSON",@"query"];
    } else if (action == REMOVE) {//删除处理
        
        NSMutableDictionary*  dict = self.objects[deleteRowId];
        post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",
                @"<你的51work6.com用户邮箱>",@"JSON",@"remove",[dict objectForKey:@"ID"]];
    }
    
    NSData *postData  = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request delegate:self];
    
    if (connection) {
        self.datas = [NSMutableData new];
    }
}


#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.datas appendData:data];
}


-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"请求完成...");
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:self.datas options:NSJSONReadingAllowFragments error:nil];
    
    if (action == QUERY) {//查询处理
        [self reloadView:dict];
    } else if (action == REMOVE) {//删除处理
        
        NSString *message = @"操作成功。";
        NSNumber *resultCodeObj = [dict objectForKey:@"ResultCode"];
        
        if ([resultCodeObj integerValue] < 0) {
            message = [resultCodeObj errorMessage];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        
        //重新查询
        action = QUERY;
        [self startRequest];
    }
    
}


//重新加载表视图
-(void)reloadView:(NSDictionary*)res
{
    if (self.refreshControl) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    }
    
    NSNumber *resultCodeObj = [res objectForKey:@"ResultCode"];
    if ([resultCodeObj integerValue] >=0)
    {
        self.objects = [res objectForKey:@"Record"];
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
@end
