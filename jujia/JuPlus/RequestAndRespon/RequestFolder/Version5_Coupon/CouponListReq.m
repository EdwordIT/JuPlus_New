//
//  CouponListReq.m
//  JuPlus
//
//  Created by admin on 15/10/20.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CouponListReq.h"

@implementation CouponListReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",PageNum,PageSize,TOKEN,nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"coupon" forKey:@"ModuleName"];
    [self setField:@"list" forKey:@"FunctionName"];
}

@end
