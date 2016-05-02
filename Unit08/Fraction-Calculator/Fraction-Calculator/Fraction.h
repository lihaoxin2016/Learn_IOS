//
//  Fraction.h
//  Fraction-Calculator
//
//  Created by 李昊鑫 on 16/3/30.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fraction : NSObject

@property int numerator, denominator;

-(void) print;
-(void) setTo:(int) n over: (int) d;
-(Fraction *) add: (Fraction *)f;
-(Fraction *) subtract: (Fraction *) f;
-(Fraction *) multiply: (Fraction *) f;
-(Fraction *) divide: (Fraction *) f;
-(void) reduce;
-(double) convertToNum;
-(NSString *) convertToString;


@end
