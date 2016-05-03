//
//  OrderListRespon.m
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderListRespon.h"
#import "OrderListDTO.h"
@implementation OrderListRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.totalCount = [NSString stringWithFormat:
                       @"%@",[dict objectForKey:@"count"]];
    self.orderListArray = [[NSMutableArray alloc]init];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    for (int i=0; i<[arr count]; i++) {
        OrderListDTO *dto = [[OrderListDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.orderListArray addObject:dto];
    }
}
@end
