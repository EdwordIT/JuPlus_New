//
//  DeleteOrderReq.m
//  JuPlus
//
//  Created by admin on 15/9/29.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "DeleteOrderReq.h"

@implementation DeleteOrderReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",@"orderNo",TOKEN,nil];
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
    [self setField:@"delete" forKey:@"FunctionName"];
}

@end
