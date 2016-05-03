//
//  RegisterRequest.m
//  JuPlus
//
//  Created by admin on 15/7/1.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest
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
    
    [self setField:@"mem" forKey:@"ModuleName"];
    [self setField:@"reg" forKey:@"FunctionName"];
}
@end
