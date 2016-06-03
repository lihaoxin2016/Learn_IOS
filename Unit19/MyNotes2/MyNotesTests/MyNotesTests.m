

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "NotesTBXMLParser.h"
#import "NotesXMLParser.h"

@interface MyNotesTests : XCTestCase

@end

@implementation MyNotesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNotesTBXMLParser {
    [self measureBlock:^{
        NotesTBXMLParser* parser = [NotesTBXMLParser new];
        [parser start];
    }];
}

- (void)testNotesXMLParser {
    [self measureBlock:^{
        NotesXMLParser* parser = [NotesXMLParser new];
        [parser start];
    }];
}


@end
