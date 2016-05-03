//
//  LoginRespon.m
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "LoginRespon.h"

@implementation LoginRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    NSDictionary *memInfo = [dict objectForKey:@"memInfo"];
    self.token = [NSString stringWithFormat:@"%@",[memInfo objectForKey:@"token"]];
    self.portraitPath = [NSString stringWithFormat:@"%@",[memInfo objectForKey:@"portraitPath"]];
    self.nickname = [NSString stringWithFormat:@"%@",[memInfo objectForKey:@"nickname"]];
    self.orderFlag = [NSString stringWithFormat:@"%@",[memInfo objectForKey:@"orderFlag"]];
    self.regNo = [NSString stringWithFormat:@"%@",[memInfo objectForKey:@"regNo"]];

}
@end
