//
//  GetFavListRespon.m
//  JuPlus
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "GetFavListRespon.h"
#import "MyFavourDTO.h"
@implementation GetFavListRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *arr = [dict objectForKey:@"list"];
    for (NSDictionary *dic in arr) {
        MyFavourDTO *dto = [[MyFavourDTO alloc]init];
        [dto loadDTO:dic];
        [self.dataArray addObject:dto];
    }
    self.count = [[dict objectForKey:@"count"] intValue];
}
@end
