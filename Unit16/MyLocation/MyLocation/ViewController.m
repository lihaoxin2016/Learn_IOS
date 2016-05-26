

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

//经度
@property (weak, nonatomic) IBOutlet UITextField *txtLng;
//纬度
@property (weak, nonatomic) IBOutlet UITextField *txtLat;
//高度
@property (weak, nonatomic) IBOutlet UITextField *txtAlt;

@property(nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //定位服务管理对象初始化
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

#pragma mark Core Location委托方法用于实现位置的更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    self.txtLat.text = [NSString stringWithFormat:@"%3.5f",
                    currLocation.coordinate.latitude];
    self.txtLng.text = [NSString stringWithFormat:@"%3.5f",
                    currLocation.coordinate.longitude];
    self.txtAlt.text = [NSString stringWithFormat:@"%3.5f",
                    currLocation.altitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
        
        if (status == kCLAuthorizationStatusAuthorizedAlways) {
            NSLog(@"Authorized");
        } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            NSLog(@"AuthorizedWhenInUse");
        } else if (status == kCLAuthorizationStatusDenied) {
            NSLog(@"Denied");
        } else if (status == kCLAuthorizationStatusRestricted) {
            NSLog(@"Restricted");
        } else if (status == kCLAuthorizationStatusNotDetermined) {
            NSLog(@"NotDetermined");
        }
    
}


@end
