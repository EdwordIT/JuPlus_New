//
//  UnPackException.h
//  Autoyol
//
//  Created by Ning Gang on 13-9-8.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnPackException : NSException

+(UnPackException *)exception:(NSString *)reason;
-(NSString *)getErrorCode;
@end
