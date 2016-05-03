//
//  DesignerRequest.m
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerRequest.h"

@implementation DesignerRequest

-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName", @"pageNum",@"pageSize",@"memNo",nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"mem" forKey:@"ModuleName"];
    [self setField:@"detail" forKey:@"FunctionName"];
}

@end
