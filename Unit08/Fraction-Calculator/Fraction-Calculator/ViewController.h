//
//  ViewController.h
//  Fraction-Calculator
//
//  Created by 李昊鑫 on 16/3/30.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *display;
-(void) processDigit:(int) digit;
-(void) processOp:(char) theOp;
-(void) storeFracPart;


-(IBAction) clickDigit: (UIButton *) sender;


-(IBAction)clickPlus;
-(IBAction)clickMinus;
-(IBAction)clickMultiply;
-(IBAction)clickDivide;

-(IBAction)clickOver;
-(IBAction)clickEquals;
-(IBAction) clickClear;



@end

