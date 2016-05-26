

#import <UIKit/UIKit.h>
#import "NSNumber+Message.h"


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


- (IBAction)onClick:(id)sender;
@end
