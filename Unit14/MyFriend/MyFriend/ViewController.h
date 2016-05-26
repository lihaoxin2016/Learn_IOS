
#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController : UITableViewController
<ABPeoplePickerNavigationControllerDelegate>

//保存联系人姓名数组属性
@property(nonatomic, retain) NSMutableArray *contactNames;
//保存联系人ID数组属性
@property(nonatomic, retain) NSMutableArray *contactIDs;

//选择联系人
- (IBAction)selectContacts:(id)sender;

@end

