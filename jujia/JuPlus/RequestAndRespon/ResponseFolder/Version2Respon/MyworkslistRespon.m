//
//  MyworkslistRespon.m
//  JuPlus
//
//  Created by ios_admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyworkslistRespon.h"
#import "MyWorksDTO.h"
@implementation MyworkslistRespon

- (void)unPackJsonValue:(NSDictionary *)dict
{
    self.count = [NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    self.myworkArray = [[NSMutableArray alloc]init];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    
    for (int i = 0; i < [arr count]; i++) {
        MyWorksDTO *dto = [[MyWorksDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.myworkArray addObject:dto];
    }
}
@end
