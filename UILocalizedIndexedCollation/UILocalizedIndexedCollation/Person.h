//
//  Person.h
//  UILocalizedIndexedCollation
//
//  Created by jia on 16/5/5.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (NSArray *)createPersonsWithCount:(NSInteger)count;

@end
