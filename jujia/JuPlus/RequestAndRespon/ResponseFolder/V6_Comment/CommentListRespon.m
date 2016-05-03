//
//  CommentListRespon.m
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CommentListRespon.h"

@implementation CommentListRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.count = [EncodeStringFromDic(dict, @"count") integerValue];
    self.listArray = [[NSMutableArray alloc]init];
    NSArray *arr = [dict objectForKey:@"list"];
    for (NSDictionary *dic in arr) {
        CommentItem *item = [[CommentItem alloc]init];
        [item loadDTO:dic];
        [self.listArray addObject:item];
    }
}
@end
