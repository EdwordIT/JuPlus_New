//
//  RegisterRespon.h
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface RegisterRespon : JuPlusResponse
//用户名
@property(nonatomic,strong)NSString *mobileNo;
//密码
@property(nonatomic,strong)NSString *passWord;
@end
