
#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    
    NSError *error;
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonObj || error) {
        NSLog(@"JSON解码失败");
    }
    self.objects = [jsonObj objectForKey:@"Record"];

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
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  forIndexPath:indexPath];
 
    NSMutableDictionary*  dict = self.objects[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"Content"];
    cell.detailTextLabel.text = [dict objectForKey:@"CDate"];
    
    return cell;
}


@end
