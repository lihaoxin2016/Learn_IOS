//
//  ViewController.m
//  PopoverViewSample
//
//  Created by 李昊鑫 on 16/4/16.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import "ViewController.h"
#import "SelectViewController.h"


@interface ViewController ()

@property (nonatomic, strong) UIPopoverController *poc;
- (IBAction)show:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)show:(id)sender {
    
    
    SelectViewController *popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectViewController"];
    
    if (self.poc == nil) {
        popoverViewController.title = @"选择你喜欢的颜色";
        UINavigationController *nav = [[UINavigationController alloc]
                                       initWithRootViewController:popoverViewController];
        self.poc  = [[UIPopoverController alloc] initWithContentViewController:nav];
    }
    
    [self.poc presentPopoverFromBarButtonItem:sender
                     permittedArrowDirections:UIPopoverArrowDirectionUp
                                     animated:YES];
    
}


@end
