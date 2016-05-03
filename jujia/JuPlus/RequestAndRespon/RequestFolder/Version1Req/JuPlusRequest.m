//
//  JuPlusRequest.m
//  JuPlus
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusRequest.h"
#import "CommonUtil.h"
#import "PackException.h"
#import "JuPlusLoadingView.h"
#import "JuPlusEnvironmentConfig.h"
@implementation JuPlusRequest
@synthesize urlSeq,packDic,path,validParams,verifyMethod,verifySignSeq,securityMethod,requestMethod;
-(id)init{
    self = [super init];
    if (self)
    {
    }
    return self;
}
-(NSArray *)getUrlArray
{
    return urlSeq;
}
//网络请求格式(使用/来区别对待字段)
-(NSString *)getUrlString :(NSArray *) array{
    if (packDic == nil||[packDic count] == 0) {
        return nil;
    }
    else
    {
        if (array == nil || [array count] == 0) {
            return nil;
        }
        else
        {
            for(NSInteger i = 0; i < [array count]; i++){
                NSString * temp = (NSString *)[packDic objectForKey:[array objectAtIndex:i]];
                if (temp) {
                    NSString * urlencoding = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)temp, nil, nil, kCFStringEncodingUTF8));
                    path = [path stringByAppendingFormat:@"%@%@",@"/", urlencoding];
                }
                else
                {
                    path = [path stringByAppendingFormat:@"%@%@",@"/", DEFAULT_PACKNAME];
                }
            }
            return path;
        }
    }
}

-(NSString *)getrequestMethodString{
    switch (requestMethod) {
        case RequestMethod_GET:
            return @"GET";
            break;
        case RequestMethod_POST:
            return @"POST";
            break;
        case RequestMethod_PUT:
            return @"PUT";
            break;
        case RequestMethod_DELETE:
            return @"DELETE";
            break;
        default:
            return nil;
            break;
    }
}

-(NSTimeInterval)getTimeout{
    return CONNECT_TIMEOUT;
}

-(NSMutableDictionary *)getJsonDict{
    return packDic;
}

-(NSArray *)getValidArray
{
    return validParams;
}
//set方法
-(void)setField:(id) value forKey:(NSString *) key
{
    [packDic setValue:value forKey:key];
}

//get方法
-(id)getField:(NSString *) key
{
    return [packDic valueForKey:key];
}

-(void)validatePackValue:(NSDictionary *)dataDic ParamsArray:(NSArray *)paras Optional:(BOOL) optional
{
    if(paras == nil)
    {
        return;
    }
    if (optional) {
        return;
    }
    for(NSInteger i = 0 ; i < [paras count]; i++)
    {
        id value = [dataDic objectForKey:[paras objectAtIndex:i]];
        if(value == nil){
            NSString * message = [NSString stringWithFormat:@"组包时缺少必需的字段%@",[paras objectAtIndex:i]];
            @throw [PackException exception:message];
        }
    }
}

-(NSString *)getsecurityMethodString
{
    switch (securityMethod) {
        case SecurityMethod_3DES:
            return TDES_STRING;
            break;
        case SecurityMethod_RSA:
            return RSA_STRING;
            break;
        default:
            return nil;
            break;
    }
}

-(NSString *)getverifyMethodString
{
    switch (verifyMethod) {
        case VerifyMethod_HMAC:
            return HMAC_STRING;
            break;
        default:
            return nil;
            break;
    }
}

-(NSArray *)getverifySignSeq{
    
    return verifySignSeq;
}

@end
