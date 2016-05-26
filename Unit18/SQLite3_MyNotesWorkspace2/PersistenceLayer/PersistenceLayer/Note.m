

#import "Note.h"

@implementation Note

-(id)initWithDate:(NSDate*)date content:(NSString*)content {
    
    self = [super init];
    
    if (self) {
        self.date = date;
        self.content = content;
    }
    
    return self;
}


//var note = Note(date: NSDate(), content: self.txtView.text)

@end
