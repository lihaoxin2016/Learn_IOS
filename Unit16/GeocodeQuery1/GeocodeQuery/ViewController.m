

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
            NSDictionary* address = placemark.addressDictionary;
            MKPlacemark *place = [[MKPlacemark alloc]
                                  initWithCoordinate:coordinate addressDictionary:address];
            
            MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
            [mapItem openInMapsWithLaunchOptions:nil];
            
            
//             //地图上设置行车路线
//             NSDictionary* options =[[NSDictionary alloc]initWithObjectsAndKeys:
//             MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsDirectionsModeKey, nil];
//             
//             MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
//             [mapItem openInMapsWithLaunchOptions:options];
            
            
            //关闭键盘
            [_txtQueryKey resignFirstResponder];
        }
    }];
    
}

/*
- (IBAction)geocodeQuery:(id)sender {
    
    if (self.txtQueryKey.text == nil || [self.txtQueryKey.text length] == 0) {
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.txtQueryKey.text completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"查询记录数：%lu",[placemarks count]);
        
        NSMutableArray* array = [NSMutableArray new];
        
        for (int i = 0; i < [placemarks count]; i++) {
            
            CLPlacemark* placemark = placemarks[i];
            
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            NSDictionary* address = placemark.addressDictionary;
            
            MKPlacemark *place = [[MKPlacemark alloc]
                                  initWithCoordinate:coordinate addressDictionary:address];
            
            MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
            
            [array addObject:mapItem];
            
            
        }
        //关闭键盘
        [_txtQueryKey resignFirstResponder];
        
        if ([array count] > 0) {
            [MKMapItem openMapsWithItems:array launchOptions:nil];
        }
    }];
    
}
*/
@end
