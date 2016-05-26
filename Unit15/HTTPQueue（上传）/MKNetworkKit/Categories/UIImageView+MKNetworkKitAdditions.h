

#import <UIKit/UIKit.h>

extern const float kFromCacheAnimationDuration;
extern const float kFreshLoadAnimationDuration;

@class MKNetworkEngine;
@class MKNetworkOperation;

@interface UIImageView (MKNetworkKitAdditions)
+(void) setDefaultEngine:(MKNetworkEngine*) engine;
-(MKNetworkOperation*) setImageFromURL:(NSURL*) url;
-(MKNetworkOperation*) setImageFromURL:(NSURL*) url placeHolderImage:(UIImage*) image;
-(MKNetworkOperation*) setImageFromURL:(NSURL*) url placeHolderImage:(UIImage*) image animation:(BOOL) yesOrNo;
-(MKNetworkOperation*) setImageFromURL:(NSURL*) url placeHolderImage:(UIImage*) image usingEngine:(MKNetworkEngine*) imageCacheEngine animation:(BOOL) yesOrNo;
@end
