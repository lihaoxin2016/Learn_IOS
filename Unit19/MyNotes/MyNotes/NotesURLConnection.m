

#import "NotesURLConnection.h"

@implementation NotesURLConnection

//查询所有数据方法
-(void) findAll {
    
    NSString* strURL = @"http://www.51work6.com/service/mynotes/WebService.php";
    
    NSString* post = [[NSString alloc] initWithFormat: @"email=%@&type=%@&action=%@",
                                        @"<你的51work6.com用户邮箱>", @"JSON", @"query" ];
    
    NSData* postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [[NSURL alloc] initWithString:strURL];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = postData;
    
    NSURLConnection* connection  = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection != nil) {
        self.datas = [[NSMutableData alloc] init];
    }
    
}

#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.datas appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    NSLog(@"%@",[error localizedDescription]);
    [self.delegate findAllFailed: error];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"请求完成...");
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:self.datas options:NSJSONReadingAllowFragments error:nil];
    [self.delegate findAllFinished: dict];
}

@end
