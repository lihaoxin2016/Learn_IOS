
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newClick:(id)sender {
    
    ABNewPersonViewController *viewController = [[ABNewPersonViewController alloc] init];
    viewController.newPersonViewDelegate = self;
    UINavigationController *newNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:viewController];
    
    [self presentViewController:newNavigationController animated:YES completion:nil];
}

- (IBAction)unknowClick:(id)sender {
    
    ABRecordRef person = ABPersonCreate();
    
    //保存姓名
    ABRecordSetValue(person, kABPersonFirstNameProperty, @"51work6.com", NULL);
    
    // 设置Email属性
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multi,  @"eorient@sina.com", kABHomeLabel, NULL);
    ABMultiValueAddValueAndLabel(multi,  @"eorient@163.com", kABWorkLabel, NULL);
    // 添加Email到联系人记录
    ABRecordSetValue(person, kABPersonEmailProperty, multi, NULL);
    CFRelease(multi);
    
    ABUnknownPersonViewController *viewController = [[ABUnknownPersonViewController alloc] init];
    viewController.unknownPersonViewDelegate = self;
    viewController.displayedPerson = person;
    viewController.allowsAddingToAddressBook = YES;
    
    CFRelease(person);
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark -
#pragma mark ABNewPersonViewController 委托方法实现
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView
       didCompleteWithNewPerson:(ABRecordRef)person
{
    [newPersonView dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark ABUnknownPersonViewController 委托方法实现
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownCardViewController
                 didResolveToPerson:(ABRecordRef)person
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
