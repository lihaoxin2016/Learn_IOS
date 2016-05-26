

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.mapView.mapType = MKMapTypeStandard;
        self.mapView.delegate = self;
        //self.mapView.showsUserLocation = YES;
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        
        //授权
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Map View Delegate Methods
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    self.mapView.centerCoordinate = userLocation.location.coordinate;
//}

- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error
{
    NSLog(@"error : %@",[error description]);
}

@end
