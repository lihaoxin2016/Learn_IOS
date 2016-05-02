#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ABRecordID personID = [self.personIDAsNumber intValue];
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, personID);
    
    //取得姓名属性
    NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    firstName = firstName != nil?firstName:@"";
    NSString *lastName =  CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    lastName = lastName != nil?lastName:@"";
    [self.lblName setText: [NSString stringWithFormat:@"%@ %@",firstName,lastName]];
    NSString* name = CFBridgingRelease(ABRecordCopyCompositeName(person));
    [self.lblName setText: name];
    
    //取得Email属性
    ABMultiValueRef emailsProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSArray* emailsArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(emailsProperty));
    for(int index = 0; index< [emailsArray count]; index++){
        NSString *email = [emailsArray objectAtIndex:index];
        NSString *emailLabel = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(emailsProperty, index));
        
        if ([emailLabel isEqualToString:(NSString*)kABWorkLabel]) {
            [self.lblWorkEmail setText:email];
        } else if ([emailLabel isEqualToString:(NSString*)kABHomeLabel]) {
            [self.lblHomeEmail setText:email];
        } else {
            NSLog(@"%@: %@", @"其它Email", email);
        }
    }
    CFRelease(emailsProperty);
    
    //取得电话号码属性
    ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray* phoneNumberArray = CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(phoneNumberProperty));
    for(int index = 0; index< [phoneNumberArray count]; index++){
        NSString *phoneNumber = [phoneNumberArray objectAtIndex:index];
        NSString *phoneNumberLabel = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phoneNumberProperty, index));
        
        if ([phoneNumberLabel isEqualToString:(NSString*)kABPersonPhoneMobileLabel]) {
            [self.lblMobile setText:phoneNumber];
        } else if ([phoneNumberLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel]) {
            [self.lblIPhone setText:phoneNumber];
        } else {
            NSLog(@"%@: %@", @"其它电话", phoneNumber);
        }
    }
    CFRelease(phoneNumberProperty);
    
    //取得个人图片
    if (ABPersonHasImageData(person)) {
        NSData *photoData = CFBridgingRelease(ABPersonCopyImageData(person));
        if(photoData){
            [self.imageView setImage:[UIImage imageWithData:photoData]];
        }
    }
    
    CFRelease(addressBook);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end