

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property(nonatomic, strong) NSDate* date;
@property(nonatomic, strong) NSString* content;

-(id)initWithDate:(NSDate*)date content:(NSString*)content;

@end
