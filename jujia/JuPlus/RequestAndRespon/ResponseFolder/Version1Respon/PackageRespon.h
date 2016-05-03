//
//  PackageRespon.h
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "CommentItem.h"
@interface PackageRespon : JuPlusResponse
//注册会员号
@property(nonatomic,strong)NSString *memerNo;
//是否收藏过
@property(nonatomic,strong)NSString *isFav;
//效果id
@property(nonatomic,strong)NSString *regNo;
//价格
@property(nonatomic,strong)NSString *price;
//套餐图
@property(nonatomic,strong)NSString *imgUrl;

@property(nonatomic,strong)NSString *shareImgUrl;
//单品列表（包括单品图片和单品的标签内容）
@property(nonatomic,strong)NSMutableArray *labelArray;
//头像
@property(nonatomic,strong)NSString *portraitUrl;
//搭配师
@property(nonatomic,strong)NSString *designer;
//线下体验店地址
@property(nonatomic,strong)NSString *address;
//简装介绍
@property(nonatomic,strong)NSString *content;
//相关列表
@property(nonatomic,strong)NSArray *packageList;
//套餐状态
@property(nonatomic,strong)NSString *status;
//是否允许预约
@property(nonatomic,strong)NSString *visitFlag;

@property(nonatomic,strong)NSMutableArray *commentList;
@end
