//
//  JuPlusResponse.h
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#define RESPONSE_CODE @"resCode"
#define RESPONSE_MESSAGE @"resMsg"
#define RESPONSE_DATA @"data"
#define RESPONSE_OK @"000000" //服务器返回的数据成功信息
#define RESPONSE_FAIL @"111111" //可能用于强制升级等状态吗
#import "NSString+JuPlusString.h"
//加密类型
typedef enum{
    EncryptionType_NO,      //不加密
    EncryptionType_3DES,    //3DES加密
    EncryptionType_RSA,     //RSA加密
}EncryptionType;


@interface JuPlusResponse : NSObject
{
    BOOL signState;  //yes 需要签名，no 不需要签名
    EncryptionType encryptionState; //加密类型枚举
    NSArray  *unpackParams; //必要的参数校验（如果返回字段无此内容则报错）
    
    NSString * resCode;
    NSString * resMsg ;
    
}


@property(nonatomic,assign) BOOL signState;
@property(nonatomic,assign) EncryptionType encryptionState;

-(void)parseResponse:(NSDictionary *) response encryptionType:(EncryptionType)encryptionType signType:(BOOL) sign;

-(void)unPackJsonValue:(NSDictionary *)dict;


@end
