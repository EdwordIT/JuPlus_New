//
//  ClassifyTagsDTO.h
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//标签内容

#import "BaseDTO.h"

@interface ClassifyTagsDTO : BaseDTO
@property(nonatomic,strong)NSString *tagId;
//需求排序
@property(nonatomic,strong)NSString *sortId;

@property(nonatomic,strong)NSString *name;
//正常图片
@property(nonatomic,strong)NSString *imgUrl;
//被选中状态
@property(nonatomic,strong)NSString *selImgUrl;

@end
