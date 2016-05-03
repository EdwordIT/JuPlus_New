//
//  AddressDTO.h
//  JuPlus
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface AddressDTO : BaseDTO
//收货地址id
@property(nonatomic,strong)NSString *addId;
//收货人姓名
@property(nonatomic,strong)NSString *addName;
//收货人地址
@property(nonatomic,strong)NSString *addAddress;
//收货人电话
@property(nonatomic,strong)NSString *addMobile;
//是否是默认地址
@property(nonatomic,assign)BOOL isDefault;
@end
