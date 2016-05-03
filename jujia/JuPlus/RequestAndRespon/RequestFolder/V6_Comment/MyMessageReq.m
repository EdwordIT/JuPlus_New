//
//  MyMessageReq.m
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "MyMessageReq.h"

@implementation MyMessageReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",TOKEN,PageNum,PageSize,nil];
        self.requestMethod = RequestMethod_GET;
        self.validParams = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",nil];
        self.packDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.path = [[NSString alloc] init];
    }
    [self setPath];
    return self;
}

-(void)setPath{
    
    [self setField:@"message" forKey:@"ModuleName"];
    [self setField:@"list" forKey:@"FunctionName"];
}


@end
