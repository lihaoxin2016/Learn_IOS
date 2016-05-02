//
//  RegisterViewController.m
//  ModalViewSample
//
//  Created by 李昊鑫 on 16/4/13.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)save:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"点击save，关闭视图");
        NSDictionary *dataDict = [NSDictionary dictionaryWithObject:self.txtUsername.text forKey:@"username"];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"RegisterCompletionNotification" object:nil
         userInfo:dataDict];
        
    }];
}
-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"点击Cancel，关闭视图");
    }];
}
@end
