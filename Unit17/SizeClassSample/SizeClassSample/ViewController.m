

#import "ViewController.h"
#import "GADBannerView.h"

#define AdUnitID  @"ca-app-pub-1990684556219793/1962464393"

@interface ViewController () <GADBannerViewDelegate>

@property (strong, nonatomic) GADBannerView *adBannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBannerView:kGADAdSizeSmartBannerPortrait];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//屏幕旋转
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"height =%f, width =%f", size.height, size.width);
    
    if (size.height < size.width) { //横屏
        [self createBannerView: kGADAdSizeSmartBannerLandscape];
    } else {
        [self createBannerView: kGADAdSizeSmartBannerPortrait];
    }
    
}


- (void)createBannerView:(GADAdSize) size {
    
    if (self.adBannerView != nil) {
        self.adBannerView.delegate = nil;
        [self.adBannerView removeFromSuperview];
    }
    self.adBannerView = [[GADBannerView alloc] initWithAdSize:size];
    self.adBannerView.adUnitID = AdUnitID;
    self.adBannerView.delegate = self;
    self.adBannerView.rootViewController = self;
    [self.view addSubview: self.adBannerView];
    //请求加载广告
    [self.adBannerView loadRequest: [self request]];
}


// GADRequest方法
- (GADRequest*)request {
    
    GADRequest* request = [[GADRequest alloc] init];
    
    //设定性别
    request.gender = kGADGenderMale;
    //设置出生年月日
    [request setBirthdayWithMonth:12 day:7 year:1973];
    //设置位置信息
    [request setLocationWithLatitude:39.904667
                           longitude:116.408198
                            accuracy:1000];
    //设置位置描述信息
    [request setLocationWithDescription:@"美食城"];
    
    request.testDevices = [NSArray arrayWithObjects:
                           @"7740674c81cf31a50d2f92bcdb729f10", GAD_SIMULATOR_ID, nil];
    return request;
}

#pragma mark GbannerViewViewDelegate实现

//广告接收成功
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"广告接收成功");
}
//广告接收失败
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"广告接收失败 %@", [error localizedFailureReason]);
}


@end
