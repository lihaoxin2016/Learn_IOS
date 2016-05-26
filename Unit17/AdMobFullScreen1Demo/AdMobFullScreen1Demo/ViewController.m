

#import "ViewController.h"
#import "GADInterstitial.h"

#define AdUnitID @"ca-app-pub-1990684556219793/1962464393"

@interface ViewController () <GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *splashInterstitial;

- (GADRequest *)createRequest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.splashInterstitial = [[GADInterstitial alloc] init];
    self.splashInterstitial.adUnitID =  AdUnitID;
    self.splashInterstitial.delegate = self;
    [self.splashInterstitial loadRequest:[self createRequest]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark GADRequest generation
// 创建广告请求
- (GADRequest *)createRequest {
    
    GADRequest *request = [GADRequest request];
    
    //设置测试设备，防止测试阶段的无效请求，
    request.testDevices = [NSArray arrayWithObjects: @"7740674c81cf31a50d2f92bcdb729f10",
                                                     GAD_SIMULATOR_ID, nil];
    return request;
}

#pragma mark GADInterstitialDelegate实现
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"广告加载成功");
    if (self.splashInterstitial.isReady) {
        [self.splashInterstitial presentFromRootViewController:self];
    }
}

- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"广告接收失败 %@", [error localizedDescription]);
}

@end
