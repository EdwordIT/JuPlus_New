//
//  AFNetWorkClient.h
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFNetWorkClient : AFHTTPSessionManager
+(instancetype)sharedClient;
@end
