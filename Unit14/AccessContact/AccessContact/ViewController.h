//
//  ViewController.h
//  AccessContact
//
//  Created by 李昊鑫 on 16/5/2.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "DetailViewController.h"


@interface ViewController : UITableViewController<UISearchBarDelegate>
@property(weak, nonatomic)IBOutlet UISearchBar *searchBar;
@property(nonatomic, strong)NSArray *listContacts;
-(void)filterContentForSerachText:(NSString*)searchText;



@end

