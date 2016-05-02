//
//  CitiesTableViewController.m
//  TreeNavigation Controller
//
//  Created by 李昊鑫 on 16/4/14.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "DetailViewController.h"

@interface CitiesTableViewController ()

@end

@implementation CitiesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 实现表视图数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSInteger row = [indexPath row];
    NSDictionary *dict = [self.listData objectAtIndex:row];
    
    cell.textLabel.text = [dict objectForKey:@"name"];
    
    return cell;
}

//选择表视图行时候触发
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowSelectedCity"])
    {
        DetailViewController *detailViewController = segue.destinationViewController;
        
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        NSDictionary *dict = [self.listData objectAtIndex:selectedIndex];
        
        detailViewController.url = [dict objectForKey:@"url"];
        
        detailViewController.title = [dict objectForKey:@"name"];
    }
}



@end

