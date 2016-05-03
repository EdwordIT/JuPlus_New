//
//  FavDTO.h
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface FavDTO : BaseDTO
//用户注册号
@property (nonatomic, strong) NSString *memberNo;
//用户头像url
@property (nonatomic, strong) NSString *memPortraitPath;
//昵称
@property (nonatomic, strong) NSString *nickname;
//收藏日期
@property (nonatomic, strong) NSString *createTime;

@end
