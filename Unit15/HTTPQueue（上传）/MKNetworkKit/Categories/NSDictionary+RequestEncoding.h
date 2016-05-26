

@interface NSDictionary (RequestEncoding)

-(NSString*) urlEncodedKeyValueString;
-(NSString*) jsonEncodedKeyValueString;
-(NSString*) plistEncodedKeyValueString;
@end
