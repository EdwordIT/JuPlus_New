//
//  OrderInsureReq.m
//  JuPlus
//
//  Created by admin on 15/10/27.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "OrderInsureReq.h"

@implementation OrderInsureReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.requestMethod = RequestMethod_POST;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"trans" forKey:@"ModuleName"];
    [self setField:@"before" forKey:@"FunctionName"];
}

@end
