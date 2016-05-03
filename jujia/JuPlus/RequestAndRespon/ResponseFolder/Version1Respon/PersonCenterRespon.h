//
//  PersonCenterRespon.h
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface PersonCenterRespon : JuPlusResponse
//头像
@property(nonatomic,strong)NSString *portrait;
//昵称
@property(nonatomic,strong)NSString *nickname;
//作品数
@property(nonatomic,strong)NSString *worksCount;
//购买
@property(nonatomic,strong)NSString *payCount;
//收藏
@property(nonatomic,strong)NSString *favourCount;
//搭配师标志
@property (nonatomic, retain)NSString *designerFlag;
//预约标志
@property (nonatomic ,strong)NSString *orderFlag;

@property (nonatomic ,strong)NSString *collocateRemind;
//订单提醒
@property (nonatomic ,strong)NSString *orderRemind;
//消息数量提醒
@property (nonatomic ,strong)NSString *messageCount;
@end
