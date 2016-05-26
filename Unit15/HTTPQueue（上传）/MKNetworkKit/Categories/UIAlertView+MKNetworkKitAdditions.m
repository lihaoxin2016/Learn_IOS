#if TARGET_OS_IPHONE
#import "UIAlertView+MKNetworkKitAdditions.h"

@implementation UIAlertView (MKNetworkKitAdditions)

+(UIAlertView*) showWithError:(NSError*) networkError {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[networkError localizedDescription]
                                                    message:[networkError localizedRecoverySuggestion]
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles:nil];
    [alert show];
    return alert;
}
@end
#endif
