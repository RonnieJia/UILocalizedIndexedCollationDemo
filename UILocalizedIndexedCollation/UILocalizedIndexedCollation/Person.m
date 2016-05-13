//
//  Person.m
//  UILocalizedIndexedCollation
//
//  Created by jia on 16/5/5.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (NSArray *)createPersonsWithCount:(NSInteger)count {
    NSMutableArray *names = [NSMutableArray array];
    
    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"楚",@"卫",@"蒋",@"沈",@"韩",@"杨"];
    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯"];
    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山"];
    
    for (int i = 0; i < count; i++) {
        NSString *name = xings[arc4random_uniform((int)xings.count)];
        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
        name = [name stringByAppendingString:ming];
        if (arc4random_uniform(10) > 3) {
            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
            name = [name stringByAppendingString:ming];
        }
        Person *p = [Person new];
        p.name = name;
        p.age = arc4random_uniform(50)+10;
        [names addObject:p];
    }
    
    return names;
}
@end
