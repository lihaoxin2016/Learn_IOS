

#import <UIKit/UIKit.h>

#import "NSNumber+Message.h"

@interface AddViewController : UIViewController
        <UITextViewDelegate,NSURLConnectionDataDelegate>

//接收从服务器返回数据。
@property (strong,nonatomic) NSMutableData *datas;
@property (weak, nonatomic) IBOutlet UITextView *txtView;

- (IBAction)onclickCancel:(id)sender;
- (IBAction)onclickSave:(id)sender;

//开始请求Web Service
-(void)startRequest;

@end
