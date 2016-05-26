#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>


@interface ViewController : UITableViewController
<ABNewPersonViewControllerDelegate,ABUnknownPersonViewControllerDelegate>

//ABNewPersonViewController点击
- (IBAction)newClick:(id)sender;

//ABUnknownPersonViewController点击
- (IBAction)unknowClick:(id)sender;

@end
