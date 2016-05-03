//
//  ReceiveMessageView.h
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//收货信息展示

#import "JuPlusUIView.h"
#import "AddressDTO.h"

@interface ReceiveMessageView : JuPlusUIView
-(id)initWithFrame:(CGRect)frame;
//收件人
@property(nonatomic,strong)JuPlusUILabel *nameL;
//联系方式
@property(nonatomic,strong)JuPlusUILabel *mobileL;
//地址
@property(nonatomic,strong)JuPlusUILabel *addressL;
//箭头
@property(nonatomic,strong)UIButton *rightArrow;
//信息填充
-(void)setAddressInfo:(AddressDTO *)dto;
@end
