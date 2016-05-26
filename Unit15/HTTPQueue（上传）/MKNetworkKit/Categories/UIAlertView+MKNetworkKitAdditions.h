
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface UIAlertView (MKNetworkKitAdditions)
+(UIAlertView*) showWithError:(NSError*) networkError;
@end
#endif
