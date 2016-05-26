
#import <Foundation/Foundation.h>

void *mk_NewBase64Decode(
	const char *inputBuffer,
	size_t length,
	size_t *outputLength);

char *mk_NewBase64Encode(
	const void *inputBuffer,
	size_t length,
	bool separateLines,
	size_t *outputLength);

@interface NSData (MKNKBase64)

+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;

@end
