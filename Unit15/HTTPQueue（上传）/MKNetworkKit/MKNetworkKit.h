

#ifndef MKNetworkKit_MKNetworkKit_h
#define MKNetworkKit_MKNetworkKit_h

#ifndef __IPHONE_4_0
#error "MKNetworkKit uses features only available in iOS SDK 4.0 and later."
#endif

#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#if MAC_OS_X_VERSION_MIN_REQUIRED >= 1080
#define DO_GCD_RETAIN_RELEASE 0
#else
#define DO_GCD_RETAIN_RELEASE 1
#endif
#endif

#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

// ALog always displays output regardless of the DEBUG setting
#ifndef ALog
#define ALog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);};
#endif

#import "Categories/NSString+MKNetworkKitAdditions.h"
#import "Categories/NSDictionary+RequestEncoding.h"
#import "Categories/NSDate+RFC1123.h"
#import "Categories/NSData+MKBase64.h"
#import "Categories/UIImageView+MKNetworkKitAdditions.h"
#if TARGET_OS_IPHONE
#import "Categories/UIAlertView+MKNetworkKitAdditions.h"
#elif TARGET_OS_MAC
#import "Categories/NSAlert+MKNetworkKitAdditions.h"
#endif

#import "Reachability/Reachability.h"

#import "MKNetworkOperation.h"
#import "MKNetworkEngine.h"

#define kMKNetworkEngineOperationCountChanged @"kMKNetworkEngineOperationCountChanged"
#define MKNETWORKCACHE_DEFAULT_COST 10
#define MKNETWORKCACHE_DEFAULT_DIRECTORY @"MKNetworkKitCache"
#define kMKNetworkKitDefaultCacheDuration 60 // 1 minute
#define kMKNetworkKitDefaultImageHeadRequestDuration 3600*24*1 // 1 day (HEAD requests with eTag are sent only after expiry of this. Not that these are not RFC compliant, but needed for performance tuning)
#define kMKNetworkKitDefaultImageCacheDuration 3600*24*7 // 1 day

// if your server takes longer than 30 seconds to provide real data,
// you should hire a better server developer.
// on iOS (or any mobile device), 30 seconds is already considered high.

#define kMKNetworkKitRequestTimeOutInSeconds 30
#endif


