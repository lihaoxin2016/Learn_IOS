//
//  Calculator.h
//  Fraction-Calculator
//
//  Created by 李昊鑫 on 16/3/30.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"


@interface Calculator : NSObject

@property (strong, nonatomic) Fraction *operand1;
@property (strong, nonatomic) Fraction *operand2;
@property (strong, nonatomic) Fraction *accumulator;

-(Fraction *) performOperation:(char) op;
-(void) clear;

@end
