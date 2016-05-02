//
//  ViewController.h
//  Activity IndicatorView_ProgerssViewSample
//
//  Created by 李昊鑫 on 16/4/7.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicatorView;
@property(nonatomic, strong)NSTimer *myTimer;
-(IBAction)startToMove:(id)sender;

@property (weak, nonatomic) IBOutlet UIProgressView *myprogressView;
-(IBAction)downloadProgerss:(id)sender;
@end



