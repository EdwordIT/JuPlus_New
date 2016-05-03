//
//  LabelDTO.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//标签详情

#import "LabelDTO.h"

@implementation LabelDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.coverUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coverUrl"]];
    self.productName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productName"]];
    self.productNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productNo"]];
    self.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];

    self.locX = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"positionX"]] floatValue];
    self.locY = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"positionY"]] floatValue];
    self.direction = [NSString stringWithFormat:@"%@",[dict objectForKey:@"direction"]];
}
@end
