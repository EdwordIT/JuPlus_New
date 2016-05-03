//
//  TimeoutException.m
//  Autoyol
//
//  Created by Ning Gang on 13-10-11.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import "TimeoutException.h"

@implementation TimeoutException

+(TimeoutException*)exception:(NSString *)reason withMethod:(NSString *)method{
    TimeoutException* e = [[[TimeoutException alloc]initWithName:@"TimeoutException" reason:reason userInfo:[NSDictionary dictionaryWithObject:method forKey:@"method"]]autorelease];
    return e;
}

-(NSString *)getErrorCode
{
    return [self.userInfo valueForKey:@"code"];
}
-(NSString *)getMethod
{
    return [self.userInfo valueForKey:@"method"];
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
    NSString *message = @"操作超时";
    return [NSString stringWithFormat:@"%@:%@",message,[super reason]];
}
#endif

@end
