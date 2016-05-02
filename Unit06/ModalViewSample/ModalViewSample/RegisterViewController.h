//
//  RegisterViewController.h
//  ModalViewSample
//
//  Created by 李昊鑫 on 16/4/13.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property(weak, nonatomic)IBOutlet UITextField *txtUsername;

-(IBAction)save:(id)sender;
-(IBAction)cancle:(id)sender;


@end
