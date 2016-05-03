//
//  LoginRespon.h
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface LoginRespon : JuPlusResponse
@property(nonatomic,strong)NSString *token;
//昵称
@property(nonatomic,strong)NSString *nickname;
//头像
@property(nonatomic,strong)NSString *portraitPath;
//用户id
@property(nonatomic,strong)NSString *regNo;
//是否可预约
@property(nonatomic,strong)NSString *orderFlag;
@end
