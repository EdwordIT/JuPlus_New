//
//  PackException.m
//  Autoyol
//
//  Created by Ning Gang on 13-9-23.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import "PackException.h"

@implementation PackException

+(PackException*)exception:(NSString *)reason{
    PackException* e = [[[PackException alloc]initWithName:@"PackException" reason:reason userInfo:nil]autorelease];
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
    return @"网络不给力哦，请检查网络状态";
}

#else

//测试环境
-(NSString*)reason
{
    NSString *message =@"组包异常";
    return [NSString stringWithFormat:@"%@,%@",message,[super reason]];
}
#endif
@end
