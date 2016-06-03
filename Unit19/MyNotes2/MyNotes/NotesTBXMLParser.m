

#import "NotesTBXMLParser.h"


@implementation NotesTBXMLParser

//开始解析
-(void)start
{
    _notes = [NSMutableArray new];
    
    TBXML* tbxml = [[TBXML alloc] initWithXMLFile:@"Notes.xml" error:nil];
    
    TBXMLElement * root = tbxml.rootXMLElement;
    
	// if root element is valid
	if (root) {
        
		TBXMLElement * noteElement = [TBXML childElementNamed:@"Note" parentElement:root];
        
        while ( noteElement != nil) {
            
            NSMutableDictionary *dict = [NSMutableDictionary new];
            
            TBXMLElement *CDateElement = [TBXML childElementNamed:@"CDate" parentElement:noteElement];
            if ( CDateElement != nil) {
                NSString *CDate = [TBXML textForElement:CDateElement];
                [dict setValue:CDate forKey:@"CDate"];
            }
            
            TBXMLElement *ContentElement = [TBXML childElementNamed:@"Content" parentElement:noteElement];
            if ( ContentElement != nil) {
                NSString *Content = [TBXML textForElement:ContentElement];
                [dict setValue:Content forKey:@"Content"];
            }
            
            TBXMLElement *UserIDElement = [TBXML childElementNamed:@"UserID" parentElement:noteElement];
            if ( UserIDElement != nil) {
                NSString *UserID = [TBXML textForElement:UserIDElement];
                [dict setValue:UserID forKey:@"UserID"];
            }
            
            //获得ID属性
            NSString *_id = [TBXML valueOfAttributeNamed:@"id" forElement:noteElement error:nil];
            [dict setValue:_id forKey:@"id"];
            
            [_notes addObject:dict];
            
            
            noteElement = [TBXML nextSiblingNamed:@"Note" searchFromElement:noteElement];
            
		}
    }
    
    NSLog(@"解析完成...");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
    self.notes = nil;
    
}


@end
