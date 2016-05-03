//
//  HomePageInfoDTO.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//首页数据层

#import "BaseDTO.h"
#import "LabelDTO.h"
@interface HomePageInfoDTO : BaseDTO
//注册号
@property(nonatomic,strong)NSString *regNo;
//上传者会员号
@property(nonatomic,strong)NSString *memNo;
//上传时间
@property(nonatomic,strong)NSString *uploadTime;
//头像
@property(nonatomic,strong)NSString *portrait;
//昵称
@property(nonatomic,strong)NSString *nikename;
//描述文字
@property(nonatomic,strong)NSString *descripTxt;
//家居布景大图
@property(nonatomic,strong)NSString *collectionPic;
//分享的大图
@property(nonatomic,strong)NSString *sharePic;
//价格
@property(nonatomic,strong)NSString *price;
//标签组
@property(nonatomic,strong)NSMutableArray *labelArray;

@property(nonatomic,strong)NSMutableArray *commentList;

@property(nonatomic,strong)NSString *favCount;

@property(nonatomic,strong)NSString *comCount;

@end
