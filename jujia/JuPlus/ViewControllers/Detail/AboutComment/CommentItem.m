//
//  CommentItem.m
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CommentItem.h"

@implementation CommentItem
-(void)loadDTO:(NSDictionary *)dict
{
    self.comId = EncodeStringFromDic(dict, @"id");
    self.memberNo = EncodeStringFromDic(dict, @"memberNo");
    self.memberNickname = EncodeStringFromDic(dict, @"memberNickname");
    self.memberPortrait = EncodeStringFromDic(dict, @"memberPortrait");
    self.contentText = EncodeStringFromDic(dict, @"contentText");
    self.answeredNo = EncodeStringFromDic(dict, @"answeredNo");
    self.answeredNickname = EncodeStringFromDic(dict, @"answeredNickname");
    self.createTime = EncodeStringFromDic(dict, @"createTime");

}
@end
