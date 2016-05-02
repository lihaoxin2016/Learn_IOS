//
//  NoteManagedObject+CoreDataProperties.h
//  HelloWorld
//
//  Created by 李昊鑫 on 16/4/24.
//  Copyright © 2016年 lhx. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NoteManagedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteManagedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END
