@interface NSDate (RFC1123)

+(NSDate*)dateFromRFC1123:(NSString*)value_;


-(NSString*)rfc1123String;

@end
