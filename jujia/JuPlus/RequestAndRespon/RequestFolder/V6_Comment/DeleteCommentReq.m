//
//  DeleteCommentReq.m
//  JuPlus
//
//  Created by admin on 15/11/20.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "DeleteCommentReq.h"

@implementation DeleteCommentReq
-(id)init{
    self = [super init];
    if (self)
    {
        self.urlSeq = [[NSArray alloc] initWithObjects:@"ModuleName",@"FunctionName",@"commentId",TOKEN,nil];
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
    [self setField:@"comment/delete" forKey:@"FunctionName"];
}

@end
