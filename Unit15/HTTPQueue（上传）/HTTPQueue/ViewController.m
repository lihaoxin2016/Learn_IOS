

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onClick:(id)sender {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"jpg"];
    
    
    NSString *path = [[NSString alloc] initWithFormat:@"/service/upload.php"];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:@"<你的51work6.com用户邮箱>" forKey:@"email"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"51work6.com" customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addFile:filePath forKey:@"file"];
    [op setFreezable:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        
        NSLog(@"Upload file finished!");
        NSData *data = [operation responseData];
        
        if (data) {
            
            NSError *eror;
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&eror];
            if (resDict) {
                NSNumber *resultCodeObj = [resDict objectForKey:@"ResultCode"];
                
                NSString *errorStr = [resultCodeObj errorMessage];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误信息"
                                                                    message:errorStr
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                [alertView show];
                return ;
            }
        }
        [self seeImage];
        
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
    }];
    [engine enqueueOperation:op];
}

-(void)seeImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = paths[0];
    NSString *downloadPath = [cachesDirectory stringByAppendingPathComponent:@"1.jpg"];
    
    
    NSString *path = [[NSString alloc] initWithFormat:@"/service/download.php?email=%@&FileName=1.jpg",@"<你的51work6.com用户邮箱>"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"51work6.com" customHeaderFields:nil];
    [engine useCache];

    MKNetworkOperation *downloadOperation = [engine operationWithPath:path params:nil httpMethod:@"POST" ssl:NO];
    [downloadOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:downloadPath
                                                append:NO]];
    
    [downloadOperation onDownloadProgressChanged:^(double progress) {
        NSLog(@"download progress: %.2f%%", progress*100.0);
        _progressView.progress = progress;
    }];
    
    [downloadOperation addCompletionHandler:^(MKNetworkOperation *operation) {
        
        NSLog(@"download file finished!");
        NSData *data = [operation responseData];
        
        if (data) {
            
            NSError *eror;
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&eror];
            if (!resDict) {
                NSNumber *resultCodeObj = [resDict objectForKey:@"ResultCode"];
                
                NSString *errorStr = [resultCodeObj errorMessage];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误信息"
                                                                    message:errorStr
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                [alertView show];
            }
        } else {
            UIImage *img = [UIImage imageWithContentsOfFile:downloadPath];
            _imageView1.image = img;
        }
        
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
    }];
    [engine enqueueOperation:downloadOperation];
}

@end
