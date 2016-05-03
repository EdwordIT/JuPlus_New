//
//  RelatedTagsReq.m
//  JuPlus
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "RelatedTagsReq.h"

@implementation RelatedTagsReq
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
    
    [self setField:@"product/name" forKey:@"ModuleName"];

}

@end
