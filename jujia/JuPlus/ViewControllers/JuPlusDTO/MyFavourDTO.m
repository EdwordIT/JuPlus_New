//
//  MyFavourDTO.m
//  JuPlus
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyFavourDTO.h"

@implementation MyFavourDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.coverUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coverUrl"]];
    self.name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];
    self.typeId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]];
    self.createTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"createTime"]];

}
@end
