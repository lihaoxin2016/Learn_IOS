//
//  NoteManagedObject.h
//  HelloWorld
//
//  Created by 李昊鑫 on 16/4/24.
//  Copyright © 2016年 lhx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoteManagedObject : NSManagedObject
@property(nonatomic, retain)NSDate *date;
@property(nonatomic,retain) NSString *content;

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "NoteManagedObject+CoreDataProperties.h"
