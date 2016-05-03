//
//  ErrorInfoDto.m
//  JuPlus
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ErrorInfoDto.h"

@implementation ErrorInfoDto
-(void)loadDTO:(NSDictionary *)dict
{
    self.resCode = [NSString stringWithFormat:@"%@",[dict objectForKey:@"resCode"]];
    self.resMsg = [NSString stringWithFormat:@"%@",[dict objectForKey:@"resMsg"]];
    if([self.resCode integerValue]==ERROR_VERSON_OUT)
    self.downloadUrl = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"downLink"]];
}
@end
