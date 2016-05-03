//
//  MyworkslistReq.m
//  JuPlus
//
//  Created by ios_admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyworkslistReq.h"

@implementation MyworkslistReq

-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",@"pageNum",@"pageSize",@"token",nil];
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
    [self setField:@"owner" forKey:@"FunctionName"];
}

@end
