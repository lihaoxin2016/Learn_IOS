

#import "MasterViewController.h"
#import "DetailViewController.h"

#import <BusinessLogicLayer/NoteBL.h>
#import <PersistenceLayer/Note.h>

@interface MasterViewController ()

@property (strong, nonatomic) DetailViewController *detailViewController;
//保存数据列表
@property (nonatomic,strong) NSMutableArray* listData;
//保存数据列表
@property (nonatomic,strong) NoteBL* bl;

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
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    self.bl = [[NoteBL alloc] init];
    self.listData = [self.bl findAll];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView:)
                                                 name:@"reloadViewNotification"
                                               object:nil];
}
//
//- (void)insertNewObject:(id)sender
//{
//    
//    UIViewController *modalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"addViewController"];
//    modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    modalViewController.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentViewController:modalViewController animated:YES completion:nil];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Note *object = self.listData[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Note  *note = self.listData[indexPath.row];
    cell.textLabel.text = note.content;
    cell.detailTextLabel.text = [note.date description];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Note *note = [self.listData objectAtIndex:[indexPath row]];
        NoteBL *bl = [[NoteBL alloc] init];
        self.listData = [bl remove: note];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

#pragma mark - 处理通知
-(void)reloadView:(NSNotification*)notification {
    NSMutableArray *resList = [notification object];
    self.listData  = resList;
    [self.tableView reloadData];
}


@end
