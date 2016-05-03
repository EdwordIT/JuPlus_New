//
//  RegisterRespon.m
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "RegisterRespon.h"

@implementation RegisterRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.mobileNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"mobile"]];
    self.passWord = [NSString stringWithFormat:@"%@",[dict objectForKey:@"loginPwd"]];
}

@end
