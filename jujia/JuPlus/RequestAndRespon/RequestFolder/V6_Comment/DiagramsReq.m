//
//  DiagramsReq.m
//  JuPlus
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "DiagramsReq.h"

@implementation DiagramsReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"created" forKey:@"ModuleName"];
//    [self setField:@"comment/list" forKey:@"FunctionName"];
}

@end
