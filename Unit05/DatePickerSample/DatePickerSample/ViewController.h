//
//  ViewController.h
//  DatePickerSample
//
//  Created by 李昊鑫 on 16/4/7.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak ,nonatomic)IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UILabel *label;

-(IBAction)oncilck:(id)sender;
@end

