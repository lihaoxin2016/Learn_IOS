//
//  ViewController.m
//  AlertView ActionSheetSample
//
//  Created by 李昊鑫 on 16/4/7.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

-(IBAction)testAlertView:(id)senderb{
    
}


-(IBAction)testActionSheet:(id)sender{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Alert"
                              message:@"Alert text goes here"
                              delegate:self
                              cancelButtonTitle:@"NO"
                              otherButtonTitles:@"YES",nil];
    
    [alertView show];
}
#pragma mark
-(void)alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex = %li",(long)buttonIndex);
    
    UIAlertView *alertview = [[UIAlertView alloc]
                              initWithTitle:@"Alert"
                              message:@"Alert text goes here"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
    
    [alertview show];
}



@end
