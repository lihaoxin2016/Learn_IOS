

#import "ViewController.h"
#import "GADInterstitial.h"

#define AdUnitID @"ca-app-pub-1990684556219793/1962464393"

@interface ViewController () <GADInterstitialDelegate>
{
    NSTimer *timer;        //用于模拟控制游戏进度
}

//插页广告GADInterstitial对象属性
@property(nonatomic, strong) GADInterstitial *splashInterstitial;

//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
//插页广告GADInterstitial对象属性
@property(nonatomic, strong) GADInterstitial *interstitial;
//画面中的按钮
@property (weak, nonatomic) IBOutlet UIButton *startButton;
//创建广告请求对象
- (GADRequest *)createRequest;
//更新进度条
-(void)update;

//按钮事件
- (IBAction)start:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)start:(id)sender {
    self.startButton.enabled = NO;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(update)
                                           userInfo:nil
                                            repeats:YES];
    
}

-(void)update
{
    self.progressView.progress += 0.1;
    if (self.progressView.progress == 1.0) {
        //游戏结束
        NSLog(@"游戏结束");
        [timer invalidate];
        timer = nil;
        
        //初始化广告
        self.interstitial = [[GADInterstitial alloc] init];
        self.interstitial.adUnitID =  AdUnitID;
        self.interstitial.delegate = self;
        [self.interstitial loadRequest:[self createRequest]];
    }
}


#pragma mark GADRequest generation
// 创建广告请求
- (GADRequest *)createRequest {
    
    GADRequest *request = [GADRequest request];
    //设置测试设备，防止测试阶段的无效请求，
    request.testDevices = [NSArray arrayWithObjects:
                           @"7740674c81cf31a50d2f92bcdb729f10",
                           GAD_SIMULATOR_ID, nil];
    
    return request;
}

#pragma mark GADInterstitialDelegate实现
- (void)interstitial:(GADInterstitial *)interstitial didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"广告接收失败 %@", [error localizedDescription]);
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    NSLog(@"广告接收成功");
    [self.interstitial presentFromRootViewController:self];
    self.startButton.enabled = YES;
    self.progressView.progress = 0.0;
}

@end
