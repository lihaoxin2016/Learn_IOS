//
//  ViewController.m
//  PageControINvigation
//
//  Created by 李昊鑫 on 16/4/13.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong, nonatomic)UIView *page1;
@property(strong, nonatomic)UIView *page2;
@property(strong, nonatomic)UIView *page3;
@property(weak, nonatomic)IBOutlet UIScrollView *scrollView;
@property(weak, nonatomic)IBOutlet UIPageControl *pageControl;

-(IBAction)changePage:(id)sender;
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

@end
