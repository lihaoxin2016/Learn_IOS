

#import "AddViewController.h"


@interface AddViewController () 


@end

@implementation AddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.txtView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onclickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onclickSave:(id)sender {
    
    [self startRequest];
    
    [self.txtView resignFirstResponder];
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
-(void)startRequest
{
    //准备参数    
    NSDate *date = [NSDate new];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //设置参数
    NSString *post = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@",
                      @"<你的51work6.com用户邮箱>",@"JSON",@"add",dateStr,self.txtView.text];
    
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
        _datas = [NSMutableData new];
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
