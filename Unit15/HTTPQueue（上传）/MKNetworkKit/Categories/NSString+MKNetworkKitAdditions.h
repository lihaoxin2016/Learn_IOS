
@interface NSString (MKNetworkKitAdditions)

- (NSString *) md5;
+ (NSString*) uniqueString;
- (NSString*) mk_urlEncodedString;
- (NSString*) urlDecodedString;
@end
