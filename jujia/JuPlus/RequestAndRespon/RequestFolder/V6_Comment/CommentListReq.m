//
//  CommentListReq.m
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CommentListReq.h"

@implementation CommentListReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",PageNum,PageSize,@"collocateNo",nil];
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
    [self setField:@"comment/list" forKey:@"FunctionName"];
}

@end
