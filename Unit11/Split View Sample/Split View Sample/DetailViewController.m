//
//  DetailViewController.m
//  Split View Sample
//
//  Created by 李昊鑫 on 16/4/16.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import "DetailViewController.h"
#import "YellowViewController.h"
#import "BlueViewController.h"


@interface DetailViewController ()
@property (nonatomic, strong)YellowViewController *yellowViewController;
@property (nonatomic, strong)BlueViewController *blueViewController;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"blueViewController"];
    self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"yellowViewController"];
    [self.view addSubview:self.yellowViewController.view];
    [self.view addSubview:self.blueViewController.view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateView:(NSInteger)row
{
    if(row == 0){
        if(self.yellowViewController.view.superview){
            [self.yellowViewController.view removeFromSuperview];
        }
        if(self.blueViewController.view.superview == nil){
            [self.view addSubview:self.blueViewController.view];
        }
        
    }else{
        if(self.blueViewController.view.superview){
            [self.blueViewController.view removeFromSuperview];
        }
        if(self.yellowViewController.view.superview == nil){
            [self.view addSubview:self.yellowViewController.view];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
