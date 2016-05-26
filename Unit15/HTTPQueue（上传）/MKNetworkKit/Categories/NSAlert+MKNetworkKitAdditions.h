

#if !TARGET_OS_IPHONE
#import <AppKit/AppKit.h>

@interface NSAlert (MKNetworkKitAdditions)
+(NSAlert*) showWithError:(NSError*) networkError;
@end
#endif