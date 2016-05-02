//
//  ViewController.m
//  PageNavigation
//
//  Created by 李昊鑫 on 16/4/14.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import "ViewController.h"

enum DirectionForward
{
    ForwardBefore = 1 //向前
    ,ForwardAfter =2  //向后
};


@interface ViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    //当前Page的索引
    int pageIndex;
    //翻页的方向 BeforeForward 向前 AfterForward 向后
    int  directionForward;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    UIStoryboard *mainStoryboard = self.storyboard;
    
    UIViewController* page1ViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"page1"];
    
    //取出第一个视图控制器，作为PageViewController首页
    NSArray *viewControllers = @[page1ViewController];
    
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    [self.view addSubview:self.pageViewController.view];
    
    pageIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    pageIndex--;
    
    if (pageIndex < 0){
        pageIndex = 0;
        return nil;
    }
    
    directionForward = ForwardBefore;
    
    UIStoryboard *mainStoryboard = self.storyboard;
    
    NSString *pageId = [NSString stringWithFormat:@"page%i",pageIndex+1];
    UIViewController* pvController = [mainStoryboard instantiateViewControllerWithIdentifier:pageId];
    
    return pvController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    pageIndex++;
    
    if (pageIndex > 2){
        pageIndex = 2;
        return nil;
    }
    
    directionForward = ForwardAfter;
    
    UIStoryboard *mainStoryboard = self.storyboard;
    
    NSString *pageId = [NSString stringWithFormat:@"page%i",pageIndex+1];
    UIViewController* pvController = [mainStoryboard instantiateViewControllerWithIdentifier:pageId];
    
    return pvController;
}


#pragma mark - Page View Controller Delegate
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}


- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    if (!completed) {
        if (directionForward == ForwardAfter) {
            pageIndex--;
        }
        if (directionForward == ForwardBefore) {
            pageIndex++;
        }
    }
}

@end
