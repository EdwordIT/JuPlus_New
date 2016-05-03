//
//  ServerException.h
//  Autoyol
//
//  Created by Ning Gang on 13-9-8.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import <Foundation/Foundation.h>

//客户端错误码定义

#define RESPONSE_OK @"000000"           //成功

#define ERROR_VERSION_OUTOFDATE @"800000"       //客户端版本过低
@interface ServerException : NSException

+(ServerException *)exception:(NSString *)reason withCode:(NSString*)code;
-(NSString *)getErrorCode;
@end
