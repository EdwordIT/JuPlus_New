//
//  BannerItem.h
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface BannerItem : BaseDTO
@property (nonatomic,strong)NSString *title;
//banner图片
@property (nonatomic,strong)NSString *imgUrl;
//传递参数(例如H5界面需要的来源网页/详情界面的regNo..)
@property (nonatomic,strong)NSString *param;
//定义的跳转详情类型（1、h5 2、效果图详情 3、单品详情）
@property (nonatomic,strong)NSString *type;
@end
