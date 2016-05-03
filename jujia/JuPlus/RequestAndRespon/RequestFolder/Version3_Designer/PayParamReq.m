//
//  PayParamReq.m
//  JuPlus
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "PayParamReq.h"

@implementation PayParamReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",@"orderNo",@"payType",TOKEN,nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"trans" forKey:@"ModuleName"];
    [self setField:@"payParam" forKey:@"FunctionName"];
}

@end
