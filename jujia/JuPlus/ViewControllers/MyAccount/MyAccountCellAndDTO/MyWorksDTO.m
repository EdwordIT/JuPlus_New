//
//  MyWorksDTO.m
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyWorksDTO.h"

@implementation MyWorksDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    self.payCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"buyCount"]];
    self.favCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"favouriteCount"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];
    self.uploadTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"uploadTime"]];
    self.coverUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coverUrl"]];

}
@end
