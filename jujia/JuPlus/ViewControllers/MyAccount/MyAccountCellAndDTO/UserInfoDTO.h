//
//  UserInfoDTO.h
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoDTO : NSObject
//登陆返回token
@property (nonatomic,strong)NSString *token;
//登陆返回昵称
@property (nonatomic,strong)NSString *nickname;
//登陆返回注册号
@property (nonatomic,strong)NSString *portraitUrl;

@property (nonatomic,strong)NSString *mobile;

@property (nonatomic,strong)NSString *regNo;

@end
