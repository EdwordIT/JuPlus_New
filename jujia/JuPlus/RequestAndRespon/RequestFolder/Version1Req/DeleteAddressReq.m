//
//  DeleteAddressReq.m
//  JuPlus
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DeleteAddressReq.h"

@implementation DeleteAddressReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",@"addressId",TOKEN,nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
        
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"address" forKey:@"ModuleName"];
    [self setField:@"del" forKey:@"FunctionName"];
}

@end
