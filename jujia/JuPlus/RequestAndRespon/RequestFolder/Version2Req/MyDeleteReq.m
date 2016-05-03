//
//  MyDeleteReq.m
//  JuPlus
//
//  Created by ios_admin on 15/8/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyDeleteReq.h"

@implementation MyDeleteReq

-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName", @"collocateNo",@"token",nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"collocate" forKey:@"ModuleName"];
    [self setField:@"delete" forKey:@"FunctionName"];
}


@end
