//
//  ServerException.m
//  Autoyol
//
//  Created by Ning Gang on 13-9-8.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import "ServerException.h"

@implementation ServerException

+(ServerException*)exception:(NSString *)reason withCode:(NSString*)code{
    ServerException* e = [[[ServerException alloc]initWithName:@"ServerException" reason:reason userInfo:[NSDictionary dictionaryWithObject:code forKey:@"code"]]autorelease];
    return e;
}

-(NSString *)getErrorCode
{
    return [self.userInfo valueForKey:@"code"];
}

#ifdef IS_PROD
//生产环境
-(NSString*)reason
{
    NSString *exceptionCode = [self.userInfo valueForKey:@"code"];
    
    if ([exceptionCode isEqualToString:ERROR_VERSION_OUTOFDATE])
    {
        return [NSString stringWithFormat:@"客户端版本过低"];
    }
    
    else
    {
        return [NSString stringWithFormat:@"%@",[super reason]];
    }
    
}



#else


//测试环境
-(NSString*)reason
{
    NSString *exceptionCode = [self.userInfo valueForKey:@"code"];


    NSString* reasonStr = [super reason];


    if ([exceptionCode isEqualToString:ERROR_VERSION_OUTOFDATE])
    {
        return [NSString stringWithFormat:@"服务器返回信息：%@,错误码：%@,显示信息：测试环境错误信息",reasonStr,exceptionCode];
    }
    
    else
    {
        return [NSString stringWithFormat:@"%@",[super reason]];
    }

}
#endif

@end
