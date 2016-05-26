

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        self.textView.text = _detailContent;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onclickSave:(id)sender {
    
    [self startRequest];
    
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


/*
 * 开始请求Web Service
 */
-(void)startRequest {
    //准备参数
    NSDate *date = [NSDate new];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //设置参数
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@&id=%@",
                      @"<你的51work6.com用户邮箱>",@"JSON",@"modify",dateStr,_textView.text,_detailItem];
    
    
    NSString *strURL = @"http://www.51work6.com/service/mynotes/WebService.php";    
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
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
    
    
}


@end
