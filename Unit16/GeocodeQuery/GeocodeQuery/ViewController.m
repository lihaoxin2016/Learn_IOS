

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtQueryKey;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
- (IBAction)geocodeQuery:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)geocodeQuery:(id)sender {
    
    if (self.txtQueryKey.text == nil || [self.txtQueryKey.text length] == 0) {
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.txtQueryKey.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"查询记录数：%lu",[placemarks count]);
        
        if ([placemarks count] > 0) {
            
            CLPlacemark* placemark = placemarks[0];
            
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            
            
            NSString *urlString = [NSString stringWithFormat:
                                   @"http://maps.google.com/maps?q=%f,%f",
                                   coordinate.latitude,
                                   coordinate.longitude];
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            [[UIApplication sharedApplication] openURL:url];
            
            //关闭键盘
            [_txtQueryKey resignFirstResponder];
        }
    }];
    
}

@end
