//
//  DiagramsDTO.h
//  JuPlus
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface DiagramsDTO : BaseDTO
//效果图
@property (nonatomic,strong)NSString *imgUrl;
//效果图ID
@property (nonatomic,strong)NSString *regNo;
//效果图名称
@property (nonatomic,strong)NSString *title;
//类型
@property (nonatomic,strong)NSString *spaceStyle;
//风格
@property (nonatomic,strong)NSString *styleType;
//创建时间
@property (nonatomic,strong)NSString *createTime;
//描述
@property (nonatomic,strong)NSString *textString;
//是否被收藏过
@property (nonatomic,strong)NSString *isFav;
@end
