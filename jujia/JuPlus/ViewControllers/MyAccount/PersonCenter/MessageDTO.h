//
//  MessageDTO.h
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface MessageDTO : BaseDTO
//消息ID
@property(nonatomic,strong)NSString *idString;
//用户ID
@property(nonatomic,strong)NSString *userId;
//标题
@property(nonatomic,strong)NSString *title;
//消息内容
@property(nonatomic,strong)NSString *content;
//消息类型
@property(nonatomic,strong)NSString *type;
//要进行的操作(如果要跳网页的话则调用)
@property(nonatomic,strong)NSString *typeKey;
//是否已读(1为未读，2为已读)
@property(nonatomic,strong)NSString *status;
//创建时间
@property(nonatomic,strong)NSString *createTime;

@end
