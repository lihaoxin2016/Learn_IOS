
#if !TARGET_OS_IPHONE
#import "NSAlert+MKNetworkKitAdditions.h"

@implementation NSAlert (MKNetworkKitAdditions)

+(NSAlert*) showWithError:(NSError*) networkError {

    DLog(@"%@", [networkError userInfo]);
    
    NSAlert *alert = [NSAlert alertWithError:networkError];
    [alert runModal];
    return alert;
}
@end
#endif