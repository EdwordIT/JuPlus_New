//
//  GetVersionReq.m
//  JuPlus
//
//  Created by admin on 15/10/14.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "GetVersionReq.h"

@implementation GetVersionReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",@"platform",nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"default" forKey:@"ModuleName"];
    [self setField:@"version" forKey:@"FunctionName"];
}

@end
