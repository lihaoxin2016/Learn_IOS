

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NotesURLConnection.h"
#import "MasterViewController.h"

@interface MyNotesTests : XCTestCase <NotesURLConnectionDelegate>

@property (strong, nonatomic) XCTestExpectation* expectation;

@end

@implementation MyNotesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


#pragma mark - NotesURLConnection委托协议
//查询所有数据方法 成功
-(void) findAllFinished:(NSDictionary*)res {
    
    [self.expectation fulfill];
    XCTAssert(true, @"查询所有数据方法 成功");
    
    NSNumber* resultCode = (NSNumber*)[res objectForKey:@"ResultCode"];
    XCTAssertEqual([resultCode integerValue], 0);
    
    NSMutableArray* objects = [res objectForKey:@"Record"];
    XCTAssertEqual(objects.count, 6);
}

//查询所有数据方法 失败
-(void) findAllFailed:(NSError*)error {
    [self.expectation fulfill];
    XCTAssertNotNil(error);
    XCTFail(@"查询所有数据方法失败");
}

- (void)testFindAll {
    self.expectation = [self expectationWithDescription: @"Request NotesURL"];
    NotesURLConnection* conn = [[NotesURLConnection alloc] init];
    conn.delegate = self;
    
    //开始查询
    [conn findAll];
    [self waitForExpectationsWithTimeout:5.0 handler: nil];
}

@end
