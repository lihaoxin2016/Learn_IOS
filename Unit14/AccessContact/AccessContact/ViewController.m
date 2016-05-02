#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        
        if (granted) {
            //查询所有
            [self filterContentForSearchText:@""];
        }
        
    });
    
    CFRelease(addressBook);
}

//下拉刷新
- (void)refreshTableView
{
    
    if (self.refreshControl.refreshing) {
        [self filterContentForSearchText:@""];
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    //如果没有授权则退出
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        return ;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    
    if([searchText length]==0)
    {
        //查询所有
        self.listContacts = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    } else {
        //条件查询
        CFStringRef cfSearchText = (CFStringRef)CFBridgingRetain(searchText);
        self.listContacts = CFBridgingRelease(ABAddressBookCopyPeopleWithName(addressBook, cfSearchText));
        CFRelease(cfSearchText);
    }
    
    [self.tableView reloadData];
    
    CFRelease(addressBook);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listContacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    ABRecordRef thisPerson = CFBridgingRetain([self.listContacts objectAtIndex:[indexPath row]]);
    
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(thisPerson, kABPersonFirstNameProperty));
    firstName = firstName != nil?firstName:@"";
    NSString *lastName =  CFBridgingRelease(ABRecordCopyValue(thisPerson, kABPersonLastNameProperty));
    lastName = lastName != nil?lastName:@"";
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    NSString* name = CFBridgingRelease(ABRecordCopyCompositeName(thisPerson));
    cell.textLabel.text = name;
    
    
    CFRelease(thisPerson);
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DetailViewController *detailViewController = [segue destinationViewController];
        
        ABRecordRef thisPerson = CFBridgingRetain([self.listContacts objectAtIndex:[indexPath row]]);
        
        ABRecordID personID = ABRecordGetRecordID(thisPerson);
        NSNumber *personIDAsNumber = [NSNumber numberWithInt:personID];
        detailViewController.personIDAsNumber = personIDAsNumber;
        
        CFRelease(thisPerson);
    }
}

#pragma mark --UISearchBarDelegate 协议方法
//  获得焦点，成为第一响应者
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
//点击键盘上的搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}
//点击搜索栏取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //查询所有
    [self filterContentForSearchText:self.searchBar.text];
    [self.searchBar resignFirstResponder];
}

//当文本内容发生改变时候调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:self.searchBar.text];
}


@end