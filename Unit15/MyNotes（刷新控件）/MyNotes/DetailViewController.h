

#import <UIKit/UIKit.h>
#import "NSNumber+Message.h"

@interface DetailViewController : UIViewController
        <UITextViewDelegate,NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) id detailContent;

- (IBAction)onclickSave:(id)sender;

//接收从服务器返回数据。
@property (strong,nonatomic) NSMutableData *datas;

//开始请求Web Service
-(void)startRequest;

@end

