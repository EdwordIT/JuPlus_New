//
//  MessageDTO.m
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "MessageDTO.h"

@implementation MessageDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.idString = EncodeStringFromDic(dict, @"id");
    self.userId = EncodeStringFromDic(dict, @"uid");
    self.title = EncodeStringFromDic(dict, @"tit");
    self.content = EncodeStringFromDic(dict, @"content");
    self.type = EncodeStringFromDic(dict, @"type");
    self.typeKey = EncodeStringFromDic(dict, @"type_key");
    self.status = EncodeStringFromDic(dict, @"stat");
    self.createTime = EncodeStringFromDic(dict, @"ctime");
}
@end
