//
//  MyappointDTO.m
//  JuPlus
//
//  Created by ios_admin on 15/9/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyappointDTO.h"

@implementation MyappointDTO

- (void)loadDTO:(NSDictionary *)dict
{
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];
    self.imgUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgUrl"]];
    self.status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    self.createTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"createTime"]];
    self.type = [NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]];
    
    self.objNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"objNo"]];

}

@end
