//
//  ViewController.m
//  DatePickerSample
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
-(IBAction)oncilck:(id)sender{
    NSDate * theDate = self.datepicker.date;
    NSLog(@"the date picked os :%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter .dateFormat = @"YYYY-MM-dd  HH:mm:ss" ;
    NSLog(@"the date formate is :%@",[dateFormatter stringFromDate:theDate]);
    self.label.text = [dateFormatter stringFromDate:theDate];
}
@end
