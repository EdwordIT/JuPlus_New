//
//  JuPlusUserInfoCenter.h
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginRespon.h"
#import "UserInfoDTO.h"

@interface JuPlusUserInfoCenter : NSObject
AS_SINGLETON(JuPlusUserInfoCenter);

@property (nonatomic,strong)UserInfoDTO *userInfo;
//退出登录，清除登录信息K
- (void)resetUserInfo;

- (void)loadUserInfo:(LoginRespon *)respon;
@end
