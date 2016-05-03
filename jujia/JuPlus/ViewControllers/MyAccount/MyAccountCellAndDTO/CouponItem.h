//
//  CouponItem.h
//  JuPlus
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface CouponItem : BaseDTO
//优惠券类型
@property (nonatomic,strong)NSString *title;
//id
@property (nonatomic,strong)NSString *idString;
//优惠金额
@property (nonatomic,strong)NSString *amt;
//描述
@property (nonatomic,strong)NSString *txt;

@property (nonatomic,strong)NSString *usedMinAmt;
//有效期
@property (nonatomic,strong)NSString *expireDate;
//状态：1可用、2已使用、3已过期
@property (nonatomic,assign)NSInteger status;
@end
