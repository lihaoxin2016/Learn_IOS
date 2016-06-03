//
//  DetailViewController.h
//  MyNotes
//
//  Created by tonymacmini on 14/11/17.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

