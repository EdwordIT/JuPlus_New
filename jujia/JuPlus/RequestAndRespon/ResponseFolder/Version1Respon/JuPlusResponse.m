//
//  JuPlusResponse.m
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "NetException.h"
#import "UnPackException.h"
#import "ServerException.h"
#import "CommonUtil.h"

@implementation JuPlusResponse
@synthesize encryptionState,signState;

-(id)init{
    self = [super init];
    if (self)
    {
        signState =NO;
        encryptionState = EncryptionType_NO;
    }
    return self;
}
//网络连接成功时候的数据处理
-(void)parseResponse:(NSDictionary *) response encryptionType:(EncryptionType)encryptionType signType:(BOOL) sign
{
   // NSError *jsonError = nil;
    NSDictionary * responseDic = nil;
    if(![response isKindOfClass:[NSDictionary class]])
    {    
        @throw [UnPackException exception:@"Json数据格式错误"];
    }
    else
    {
        responseDic = (NSDictionary *)response;
        //下发的状态码为200 此时json为返回的data所有内容（包括resCode、resMsg、data）
        id json = [responseDic objectForKey:RESPONSE_DATA];
        NSLog(@"json = %@",json);
        
        if ([json isKindOfClass:[NSDictionary class]]) {
            [self validateJsonValue:json ParamsArray:unpackParams Optional:NO];
        }
        
        if (![[responseDic objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK]) {
            @throw [ServerException exception:[responseDic objectForKey:RESPONSE_MESSAGE] withCode:[responseDic objectForKey:RESPONSE_CODE]];
        }
        else
        {
            if ([json isKindOfClass:[NSDictionary class]]){
                
                [self unPackJsonValue:[responseDic objectForKey:RESPONSE_DATA]];
            }
            else
            {
                [self unPackJsonValue:responseDic];
            }
            
            
        }
        
    }
}

-(void)unPackJsonValue:(NSDictionary *)dict
{
    //返回状态码
    resCode = [dict objectForKey:@"resCode"];
    //状态信息
    resMsg = [dict objectForKey:@"resMsg"];
}

-(void)validateJsonValue:(NSDictionary *)jsonDic ParamsArray:(NSArray *)paras Optional:(BOOL) optional
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
        id value = [jsonDic objectForKey:[paras objectAtIndex:i]];
        if(value == nil){
            NSString * message = [NSString stringWithFormat:@"解包时缺少必需的字段%@",[paras objectAtIndex:i]];
            @throw [UnPackException exception:message];
        }
    }
}

@end
