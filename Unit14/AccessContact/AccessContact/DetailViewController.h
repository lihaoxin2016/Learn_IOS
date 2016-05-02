//
//  DetailViewController.h
//  AccessContact
//
//  Created by 李昊鑫 on 16/5/2.
//  Copyright © 2016年 lhx. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface DetailViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblMobile;

@property (weak, nonatomic) IBOutlet UILabel *lblIPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblWorkEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblHomeEmail;

@property (strong, nonatomic) NSNumber* personIDAsNumber;


@end
