//
//  PackException.h
//  Autoyol
//
//  Created by Ning Gang on 13-9-23.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackException : NSException

+(PackException *)exception:(NSString *)reason;
-(NSString *)getErrorCode;
@end
