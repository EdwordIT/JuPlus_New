//
//  UnPackException.m
//  Autoyol
//
//  Created by Ning Gang on 13-9-8.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import "UnPackException.h"

@implementation UnPackException

+(UnPackException*)exception:(NSString *)reason{
    UnPackException* e = [[[UnPackException alloc]initWithName:@"UnPackException" reason:reason userInfo:nil]autorelease];
    return e;
}

-(NSString *)getErrorCode
{
    return [NSString stringWithFormat:@"%@",[self.userInfo valueForKey:@"code"]];
}
#ifdef IS_PROD
//生产环境
-(NSString*)reason
{
    return @"网络不给力哦，请检查网络状态";
}

#else

//测试环境
-(NSString*)reason
{
    NSString *message =@"解包异常";
    return [NSString stringWithFormat:@"%@,%@",message,[super reason]];
}
#endif

@end
