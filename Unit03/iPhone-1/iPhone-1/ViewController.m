//
//  ViewController.m
//  iPhone-1
//
//  Created by 李昊鑫 on 16/3/29.
//  Copyright © 2016年 lhx. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize display;

-(IBAction) click1
{
    display.text = @"lihaoxin";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
