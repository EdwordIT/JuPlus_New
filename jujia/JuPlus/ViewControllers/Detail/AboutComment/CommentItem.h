//
//  CommentItem.h
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface CommentItem : BaseDTO

@property (nonatomic,strong)NSString *comId;
//评论用户注册号
@property (nonatomic,strong)NSString *memberNo;
//评论用户昵称
@property (nonatomic,strong)NSString *memberNickname;
//评论用户头像
@property (nonatomic,strong)NSString *memberPortrait;
//评论内容
@property (nonatomic,strong)NSString * contentText;
//回复的用户注册号
@property (nonatomic,strong)NSString *answeredNo;
//回复的用户昵称
@property (nonatomic,strong)NSString *answeredNickname;
//回复时间
@property (nonatomic,strong)NSString *createTime;
@end
