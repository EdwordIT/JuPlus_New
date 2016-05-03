//
//  MyappointRespon.m
//  JuPlus
//
//  Created by ios_admin on 15/9/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyappointRespon.h"
#import "MyappointDTO.h"
@implementation MyappointRespon

- (void)unPackJsonValue:(NSDictionary *)dict
{
    self.count = [NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    self.appArray = [[NSMutableArray alloc]init];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    
    for (int i = 0; i < [arr count]; i++) {
        MyappointDTO *dto = [[MyappointDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.appArray addObject:dto];
    }
}

@end
