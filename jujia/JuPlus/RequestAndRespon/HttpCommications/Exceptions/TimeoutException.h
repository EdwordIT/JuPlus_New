//
//  TimeoutException.h
//  Autoyol
//
//  Created by Ning Gang on 13-10-11.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeoutException : NSException

+(TimeoutException *)exception:(NSString *)reason withMethod:(NSString *)method;
-(NSString *)getErrorCode;
-(NSString *)getMethod;
@end
