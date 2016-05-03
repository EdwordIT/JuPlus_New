//
//  AlipayDTO.h
//  JuPlus
//
//  Created by admin on 15/9/18.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface AlipayDTO : BaseDTO
//公钥
@property (nonatomic,strong)NSString *ali_public_key;
//appId
@property (nonatomic,strong)NSString *app_id;
//回调地址
@property (nonatomic,strong)NSString *notify_url;
//合作者身份Id
@property (nonatomic,strong)NSString *partner;
//私钥
@property (nonatomic,strong)NSString *private_key;

@end
