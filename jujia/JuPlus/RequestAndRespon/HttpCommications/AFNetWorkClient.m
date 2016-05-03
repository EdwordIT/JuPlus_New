//
//  AFNetWorkClient.m
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "AFNetWorkClient.h"
#import "JuPlusConstant.h"
@implementation AFNetWorkClient

+ (instancetype)sharedClient {
    static AFNetWorkClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFNetWorkClient alloc] initWithBaseURL:[NSURL URLWithString:FRONT_SERVER_URL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}
- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}
@end
