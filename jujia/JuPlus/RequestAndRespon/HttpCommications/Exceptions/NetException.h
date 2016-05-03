//
//  NetException.h
//  Autoyol
//
//  Created by Ning Gang on 13-9-8.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetException : NSException

+(NetException *)exception:(NSString *)reason withMethod:(NSString *)method;
-(NSString *)getErrorCode;
-(NSString *)getMethod;
@end
